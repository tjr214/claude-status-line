import { basename } from "node:path";
import process from "node:process";
import { Buffer } from "node:buffer";
import { logger } from "ccusage/logger";
import {
  calculateContextTokens,
  loadSessionUsageById,
} from "ccusage/data-loader";
import { Command } from "@cliffy/command";

import { formatCurrency } from "./currency.ts";
import { getGitInfo } from "./git.ts";
import { getPythonEnvInfo } from "./python.ts";
import type { ClaudeContext } from "./types.ts";

function getContextPercentageColor(percentage: number): string {
  if (percentage >= 1 && percentage < 25) {
    return "\x1b[32m"; // bright green
  } else if (percentage >= 25 && percentage < 60) {
    return "\x1b[33m"; // bright yellow
  } else if (percentage >= 60 && percentage < 85) {
    return "\x1b[38;5;208m"; // bright orange
  } else if (percentage >= 85 && percentage <= 100) {
    return "\x1b[31m"; // bright red
  }
  // For 0% or any other case, return empty string (no color change)
  return "";
}

async function buildStatusLine(
  currency: string,
  displayModel: boolean,
  displayProjectName: boolean,
): Promise<void> {
  // Disable logging from ccusage.
  logger.removeReporter();

  // Read Claude Code context from stdin
  const chunks: Buffer[] = [];
  for await (const chunk of process.stdin) {
    chunks.push(chunk);
  }
  const input = Buffer.concat(chunks).toString();

  const {
    session_id: sessionID,
    transcript_path: transcriptPath,
    model: { display_name: modelName },
    workspace: { current_dir: currentDir, project_dir: projectDir },
  }: ClaudeContext = JSON.parse(input);

  // Build status line components with icons and separators
  const components: string[] = [];

  // Get project name if available
  let projectName: string | undefined;
  if (projectDir && projectDir !== currentDir) {
    projectName = `📁 ${basename(projectDir)}`;
  }

  // Add project name if available and enabled
  if (projectName && displayProjectName) {
    components.push(projectName);
  }

  // Add AI model with icon (if enabled)
  if (displayModel) {
    components.push(`🤖 ${modelName}`);
  }

  // Load the session usage by ID and format the cost in the specified currency.
  const sessionUsage = await loadSessionUsageById(sessionID, {
    mode: "auto",
    offline: false,
  });
  if (sessionUsage) {
    const sessionDisplay = await formatCurrency(
      sessionUsage.totalCost,
      currency,
    );
    components.push(`💰 ${sessionDisplay} session`);
  }

  const contextTokens = await calculateContextTokens(transcriptPath);
  if (contextTokens) {
    const colorCode = getContextPercentageColor(contextTokens.percentage);
    const resetCode = colorCode ? "\x1b[2m" : ""; // reset back to dim mode
    components.push(`📈 ${colorCode}${contextTokens.percentage}%${resetCode}`);
  } else {
    // 0% should appear dim (no special color)
    components.push(`📈 0%`);
  }

  // Get git information and add to components.
  const gitInfo = await getGitInfo(currentDir);

  // Display remote git info if available, otherwise show directory name
  if (gitInfo?.remoteInfo) {
    components.push(
      `🔗 ${gitInfo.remoteInfo.username}/${gitInfo.remoteInfo.repo}`,
    );
  } else {
    // Get just the directory name for cleaner display
    const dirName = currentDir ? basename(currentDir) : "~";
    components.push(`📂 ${dirName}`);
  }

  // Add git branch if available
  if (gitInfo) {
    components.push(`🌿 ${gitInfo.branch}`);
  }

  // Get Python environment information and add to components.
  const pythonInfo = await getPythonEnvInfo(currentDir);
  if (pythonInfo) {
    components.push(`🐍 ${pythonInfo.name}`);
  }

  // Join components with separator and output with dim styling
  console.log(`\x1b[2m${components.join(" | ")}\x1b[0m`);
}

if (import.meta.main) {
  try {
    await new Command()
      .name("claude-status-line")
      .version("0.1.8")
      .description("A status line for Claude Code")
      .option(
        "-c, --currency <currency:string>",
        "Currency code for session cost display",
        {
          default: "CAD",
        },
      )
      .option("-m, --display-model", "Display AI model name in status line", {
        default: false,
      })
      .option(
        "-p, --display-project-name",
        "Display project name in status line",
        {
          default: false,
        },
      )
      .action(async (options) => {
        await buildStatusLine(
          options.currency,
          options.displayModel,
          options.displayProjectName,
        );
      })
      .parse(Deno.args);
  } catch (err) {
    console.error("Error:", err instanceof Error ? err.message : String(err));
    process.exit(1);
  }
}
