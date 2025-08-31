# Claude Code Status Line

A TypeScript/Deno-based status line for Claude Code that displays project information, git remote repository info, git branch, model details, session cost, and context token usage.

## Features

- 🤖 **Model Display**: Shows the current Claude model being used (optional)
- 📁 **Project Info**: Displays project name when enabled with flag (optional)
- 🔗 **Git Remote Repository**: Shows username/repository-name when connected to remote git repository
- 🌿 **Git Integration**: Shows current git branch when in a repository
- 📂 **Directory Display**: Falls back to current directory name when no git remote exists
- 🐍 **Python Environment Detection**: Displays active virtual environments (only when activated via VIRTUAL_ENV)
- 💰 **Session Cost**: Displays current session cost in selected currency
- 📈 **Context Usage**: Shows context token percentage
- 🎨 **Clean Icons**: Uses emojis for visual clarity

## Installation

Add this to your `.claude/settings.json`:

```json
{
	"statusLine": {
		"type": "command",
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.11"
	}
}
```

### Customization

You can customize the status line with the following options:

#### Currency Display

Add the `--currency` flag to change the currency used for session cost display:

```json
{
	"statusLine": {
		"type": "command",
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.11 --currency USD"
	}
}
```

Supported currencies include: USD, EUR, GBP, JPY, AUD, and many others. Defaults to CAD.

#### Model Display

Add the `--display-model` flag to show the Claude model name in the status line:

```json
{
	"statusLine": {
		"type": "command",
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.11 --display-model"
	}
}
```

#### Project Name Display

Add the `--display-project-name` flag to show the project name in the status line (only when project differs from current directory):

```json
{
	"statusLine": {
		"type": "command",
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.11 --display-project-name"
	}
}
```

#### Combined Options

You can combine multiple options:

```json
{
	"statusLine": {
		"type": "command",
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.11 --currency USD --display-model --display-project-name"
	}
}
```

## Development

### Prerequisites

- Deno 1.40+
- Access to Claude Code configuration files

### Available Tasks

```bash
deno check  # Type checking
deno fmt    # Format code
deno lint   # Lint code
```

### How It Works

The status line receives Claude Code context as JSON through stdin:

```typescript
interface ClaudeContext {
	session_id: string;
	transcript_path: string;
	model: {
		id: string;
		display_name: string;
	};
	workspace: {
		current_dir: string;
		project_dir: string;
	};
}

interface GitRemoteInfo {
	username: string;
	repo: string;
}
```

It then builds a status line showing:

- Project name with folder emoji (if enabled and different from current directory)
- Model name with robot emoji (if enabled)
- Session cost in desired currency (fetched from ccusage)
- Context token usage percentage
- Git remote repository info with link emoji (username/repo-name) OR current directory with folder emoji (fallback when no remote)
- Git branch with branch emoji (if in repository)
- Python environment name with snake emoji (if active environment detected)

### Git Remote Repository Detection

The status line automatically detects git remote repository information and displays it in preference to the directory name. It supports multiple URL formats:

- **HTTPS**: `https://github.com/username/repo.git` → `🔗 username/repo`
- **SSH**: `git@github.com:username/repo.git` → `🔗 username/repo`
- **Git Protocol**: `git://github.com/username/repo.git` → `🔗 username/repo`

When no git remote is configured, it falls back to showing the directory basename: `📂 directory-name`

### Python Environment Detection

The status line detects Python environments only when they are actively in use:

- **Active Virtual Environment**: Checks `VIRTUAL_ENV` environment variable
- Works with any virtual environment tool (venv, Poetry, Pipenv, conda, etc.)
- Only displays when an environment is actually activated
- Shows environment name and Python version when available

This ensures the Python environment indicator only appears when you're actually working within an activated environment, not just when environment files exist in the directory.

### Usage Tracking

The status line tracks your Claude usage by:

1. Loading session usage data using the ccusage library
2. Calculating session cost and displaying in configured currency
3. Computing context token usage percentage from transcript files
4. Displaying real-time cost and context information

### Example Output

#### Full Status Line (with all features enabled, git remote repository)

```
📁 my-project | 🤖 Claude 3.5 Sonnet | 💰 $0.45 session | 📈 67% | 🔗 username/repo-name | 🌿 feature-branch | 🐍 venv
```

#### Default Status Line (git remote repository detected)

```
💰 $0.45 session | 📈 67% | 🔗 tjr214/claude-status-line | 🌿 main
```

#### Fallback to Directory Name (no git remote)

```
💰 $0.45 session | 📈 67% | 📂 local-directory | 🌿 main | 🐍 poetry-env
```

#### Non-Git Repository

```
💰 $0.45 session | 📈 67% | 📂 my-folder
```

#### With Project Name Flag and Model Display

```
📁 enterprise-app | 🤖 Claude 3.5 Sonnet | 💰 $0.45 session | 📈 67% | 🔗 company/backend-api | 🌿 develop
```

## Troubleshooting

### Git Branch Not Showing

- Ensure you're in a git repository
- Check that `git` command is available in PATH
- Verify git repository is properly initialized

### Session Cost Not Displaying

- Ensure the ccusage library can access Claude usage data
- Check that the session ID is valid and usage data exists
- Verify network access for currency conversion

### Context Percentage Not Showing

- Ensure the transcript path is accessible
- Check that the transcript file contains valid data
- Verify file read permissions for the transcript directory

### Python Environment Not Detected

- Ensure you're in a directory with a Python environment
- Check that Python virtual environment is properly activated
- For Poetry projects, ensure `pyproject.toml` exists with `[tool.poetry]` section
- For Pipenv projects, ensure `Pipfile` exists in the project directory
- For conda environments, check that `CONDA_DEFAULT_ENV` environment variable is set
- Verify that Python executable is accessible in the environment's bin directory

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run the development tasks to ensure code quality
5. Submit a pull request

## License

MIT License - see LICENSE file for details

## Related

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Claude Code Status Line Guide](https://docs.anthropic.com/en/docs/claude-code/statusline)
- [Deno Documentation](https://deno.land/manual)
- Forked from https://github.com/nmwagencia/reimagined-journey
- Uses currency data provided at https://github.com/fawazahmed0/exchange-api
