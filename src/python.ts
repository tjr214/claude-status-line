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

async function checkVenvDirectory(
  currentDir: string,
  venvDir: string,
): Promise<PythonEnvInfo | null> {
  const venvPath = join(currentDir, venvDir);
  const pyvenvConfig = join(venvPath, "pyvenv.cfg");

  if (existsSync(pyvenvConfig)) {
    const config = await readFile(pyvenvConfig);
    if (config) {
      // Extract custom prompt name from pyvenv.cfg if available
      const promptMatch = config.match(/prompt\s*=\s*['"]?([^'"]+)['"]?/);
      let envName = venvDir;

      if (promptMatch && promptMatch[1]) {
        envName = promptMatch[1];
      } else {
        // Use project directory name as fallback instead of venv method
        const projectName = currentDir.split("/").pop() || venvDir;
        envName = projectName;
      }

      // Extract Python version from pyvenv.cfg
      const versionMatch = config.match(/version\s*=\s*(\d+\.\d+(?:\.\d+)?)/);
      if (versionMatch) {
        return { name: envName, version: versionMatch[1] };
      }

      // Fallback: try to get version from Python executable
      const pythonPath = join(venvPath, "bin", "python");
      const version = await getPythonVersion(pythonPath);
      if (version) {
        return { name: envName, version };
      }
    }
  }
  return null;
}

async function checkPoetry(currentDir: string): Promise<PythonEnvInfo | null> {
  const pyprojectPath = join(currentDir, "pyproject.toml");
  if (existsSync(pyprojectPath)) {
    const content = await readFile(pyprojectPath);
    if (content.includes("[tool.poetry]")) {
      // Try to get Poetry environment info
      const envInfo = await runCommand(
        ["poetry", "env", "info", "--path"],
        currentDir,
      );
      if (envInfo) {
        const envName = envInfo.split("/").pop() || "poetry";
        const pythonPath = join(envInfo, "bin", "python");
        const version = await getPythonVersion(pythonPath);
        if (version) {
          return { name: envName, version };
        }
      }

      // Fallback: check for Python version in pyproject.toml
      const versionMatch = content.match(/python\s*=\s*"[^"]*?(\d+\.\d+)/);
      if (versionMatch) {
        return { name: "poetry", version: versionMatch[1] };
      }
    }
  }
  return null;
}

async function checkPipenv(currentDir: string): Promise<PythonEnvInfo | null> {
  const pipfilePath = join(currentDir, "Pipfile");
  if (existsSync(pipfilePath)) {
    const content = await readFile(pipfilePath);
    if (content) {
      // Try to get Pipenv environment info
      const envInfo = await runCommand(["pipenv", "--venv"], currentDir);
      if (envInfo) {
        const envName = envInfo.split("/").pop() || "pipenv";
        const pythonPath = join(envInfo, "bin", "python");
        const version = await getPythonVersion(pythonPath);
        if (version) {
          return { name: envName, version };
        }
      }

      // Fallback: check for Python version in Pipfile
      const versionMatch = content.match(/python_version\s*=\s*"(\d+\.\d+)"/);
      if (versionMatch) {
        return { name: "pipenv", version: versionMatch[1] };
      }
    }
  }
  return null;
}

async function checkConda(currentDir: string): Promise<PythonEnvInfo | null> {
  // Check for conda-meta directory (indicates conda environment)
  const condaMetaPath = join(currentDir, "conda-meta");
  if (existsSync(condaMetaPath)) {
    const condaEnv = Deno.env.get("CONDA_DEFAULT_ENV") || "conda";
    const pythonVersion = await runCommand(["python", "--version"], currentDir);
    if (pythonVersion) {
      const match = pythonVersion.match(/Python\s+(\d+\.\d+(?:\.\d+)?)/);
      const version = match ? match[1] : "";
      if (version) {
        return { name: condaEnv, version };
      }
    }
  }
  return null;
}

export async function getPythonEnvInfo(
  currentDir: string,
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
