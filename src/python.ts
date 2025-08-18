import { spawn } from "node:child_process";
import { Buffer } from "node:buffer";
import { existsSync } from "node:fs";
import { join } from "node:path";

function runCommand(cmd: string[], cwd: string): Promise<string> {
  try {
    return new Promise((resolve) => {
      const child = spawn(cmd[0], cmd.slice(1), {
        cwd,
        stdio: ["ignore", "pipe", "ignore"],
      });

      let output = "";
      child.stdout.on("data", (data: Buffer) => {
        output += data.toString();
      });

      child.on("close", () => {
        resolve(output.trim());
      });

      child.on("error", () => {
        resolve("");
      });
    });
  } catch {
    return Promise.resolve("");
  }
}

async function readFile(filePath: string): Promise<string> {
  try {
    const file = await Deno.readTextFile(filePath);
    return file;
  } catch {
    return "";
  }
}

type PythonEnvInfo = {
  name: string;
  version: string;
};

async function getPythonVersion(pythonPath: string): Promise<string> {
  const version = await runCommand([pythonPath, "--version"], ".");
  if (version) {
    // Extract version number from "Python 3.11.0" format
    const match = version.match(/Python\s+(\d+\.\d+(?:\.\d+)?)/);
    return match ? match[1] : "";
  }
  return "";
}

async function checkVirtualEnv(): Promise<PythonEnvInfo | null> {
  // Check VIRTUAL_ENV environment variable first (active environment)
  const virtualEnvPath = Deno.env.get("VIRTUAL_ENV");
  if (virtualEnvPath) {
    // First try to get name from pyvenv.cfg prompt
    const pyvenvConfig = join(virtualEnvPath, "pyvenv.cfg");
    let envName = virtualEnvPath.split("/").pop() || "venv";

    if (existsSync(pyvenvConfig)) {
      const config = await readFile(pyvenvConfig);
      const promptMatch = config.match(/prompt\s*=\s*['"]?([^'"]+)['"]?/);
      if (promptMatch && promptMatch[1]) {
        envName = promptMatch[1];
      } else {
        // Use project directory name as fallback for active environments too
        const parentDir = virtualEnvPath.split("/").slice(-2, -1)[0];
        if (parentDir && parentDir !== "envs") {
          envName = parentDir;
        }
      }
    }

    const pythonPath = join(virtualEnvPath, "bin", "python");
    const version = await getPythonVersion(pythonPath);
    if (version) {
      return { name: envName, version };
    }
  }
  return null;
}

export async function getPythonEnvInfo(
  _currentDir: string,
): Promise<PythonEnvInfo | null> {
  try {
    // Only check for active virtual environment (VIRTUAL_ENV)
    // This ensures we only display Python environment info when one is actually active
    const activeEnv = await checkVirtualEnv();
    if (activeEnv) return activeEnv;
  } catch {
    // Silent failure - no Python environment detected
  }

  return null;
}
