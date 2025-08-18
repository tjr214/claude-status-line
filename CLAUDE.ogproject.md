# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a TypeScript/Deno-based status line for Claude Code that displays project information, git remote repository info, git branch, model details, session cost, context token usage, and directory information. The status line receives Claude Code context as JSON through stdin and outputs a formatted status line.

## Development Commands

- `deno check` - Type checking
- `deno fmt` - Format code (uses 2-space indentation, semicolons, double quotes)
- `deno lint` - Lint code
- `deno publish --dry-run --allow-dirty` - Test publishing

## Project Structure

- `src/main.ts` - Entry point that reads Claude context from stdin and builds status line
- `src/types.ts` - TypeScript interfaces for Claude context structure and GitRemoteInfo
- `src/git.ts` - Git repository information extraction and remote URL parsing using child_process
- `src/currency.ts` - Currency conversion with caching for session cost display
- `src/python.ts` - Python environment detection

## Architecture

The application follows a functional architecture:

1. **Input Processing**: Reads JSON context from stdin containing session_id, transcript_path, model info, and workspace details
2. **Component Generation**: Builds status line components with emojis:
   - 📁 Project name (if enabled with --display-project-name flag and different from current directory)
   - 🤖 Model name (if enabled with --display-model flag)
   - 💰 Session cost in selected currency (fetched from ccusage)
   - 📈 Context token percentage
   - 🔗 Git remote repository info (username/repo-name) OR 📂 Current directory basename (fallback when no remote)
   - 🌿 Git branch (if in repository)
   - 🐍 Python environment (if active environment detected)
3. **Output**: Joins components with " | " separator

## CLI Options

- `-c, --currency <currency>` - Currency code for session cost display (default: CAD)
- `-m, --display-model` - Display AI model name in status line (default: false)
- `-p, --display-project-name` - Display project name in status line (default: false)

## Key Dependencies

- `ccusage` (npm package) - For Claude session usage tracking and cost calculation
- `@cliffy/command` (JSR package) - For CLI argument parsing
- Built-in Deno APIs for file system, process, and networking

## Git Remote Repository Detection

The status line automatically detects and displays git remote repository information:

- **Detection**: Uses `git config --get remote.origin.url` to get remote URL
- **Parsing**: Supports HTTPS, SSH, and Git protocol URLs with regex patterns:
  - `https://github.com/username/repo.git` → `🔗 username/repo`
  - `git@github.com:username/repo.git` → `🔗 username/repo` 
  - `git://github.com/username/repo.git` → `🔗 username/repo`
- **Fallback**: When no remote exists, displays directory basename with `📂 directory-name`
- **Priority**: Remote repository info takes precedence over directory name display

## Error Handling

- All external command executions (git) are wrapped in try-catch with graceful fallbacks
- Currency conversion failures fall back to USD display
- Missing git repositories or branches result in empty components
- Failed remote URL parsing gracefully falls back to directory basename display

## Testing and Quality

Run formatting and linting after any changes:

```bash
deno fmt && deno lint
```

The project has strict TypeScript configuration with exactOptionalPropertyTypes enabled.
