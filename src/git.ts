import { spawn } from "node:child_process";
import { Buffer } from "node:buffer";
import type { GitRemoteInfo } from "./types.ts";

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

type GitInfo = {
  branch: string;
  remoteInfo?: GitRemoteInfo;
};

function parseRemoteUrl(url: string): GitRemoteInfo | null {
  if (!url) return null;

  // Handle different URL formats: HTTPS, SSH, Git protocol
  const patterns = [
    // HTTPS: https://github.com/username/repo.git
    /^https?:\/\/[^\/]+\/([^\/]+)\/([^\/]+?)(?:\.git)?$/,
    // SSH: git@github.com:username/repo.git
    /^git@[^:]+:([^\/]+)\/([^\/]+?)(?:\.git)?$/,
    // Git protocol: git://github.com/username/repo.git
    /^git:\/\/[^\/]+\/([^\/]+)\/([^\/]+?)(?:\.git)?$/,
  ];

  for (const pattern of patterns) {
    const match = url.match(pattern);
    if (match) {
      return {
        username: match[1],
        repo: match[2],
      };
    }
  }

  return null;
}

export async function getGitInfo(currentDir: string): Promise<GitInfo | null> {
  try {
    // Check if we're in a git repository
    await new Promise<void>((resolve, reject) => {
      const child = spawn("git", ["-C", currentDir, "rev-parse", "--git-dir"], {
        stdio: ["ignore", "pipe", "ignore"],
      });
      child.on("close", (code: number) => {
        if (code === 0) resolve();
        else reject();
      });
      child.on("error", reject);
    });

    // Get current branch
    const branch = await runCommand(
      ["git", "branch", "--show-current"],
      currentDir,
    );

    if (!branch) return null;

    // Get remote URL for origin
    const remoteUrl = await runCommand(
      ["git", "config", "--get", "remote.origin.url"],
      currentDir,
    );

    const remoteInfo = parseRemoteUrl(remoteUrl);

    const gitInfo: GitInfo = {
      branch,
    };

    if (remoteInfo) {
      gitInfo.remoteInfo = remoteInfo;
    }

    return gitInfo;
  } catch {
    // Not a git repository or git command failed
  }

  return null;
}
