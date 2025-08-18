# Claude Code Status Line

A TypeScript/Deno-based status line for Claude Code that displays project information, git branch, model details, session cost, and context token usage.

## Features

- 🤖 **Model Display**: Shows the current Claude model being used (optional)
- 📁 **Project Info**: Displays project name and current directory
- 🌿 **Git Integration**: Shows current git branch when in a repository
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
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.4"
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
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.4 --currency USD"
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
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.4 --display-model"
	}
}
```

#### Combined Options
You can combine multiple options:

```json
{
	"statusLine": {
		"type": "command",
		"command": "deno run --allow-net --allow-env --allow-read --allow-write --allow-run --allow-sys jsr:@tjr214/claude-status-line@0.1.4 --currency USD --display-model"
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
```

It then builds a status line showing:

- Project name (if different from current directory)
- Model name with robot emoji (if enabled)
- Session cost in desired currency (fetched from ccusage)
- Context token usage percentage
- Current directory with folder emoji
- Git branch with branch emoji
- Python environment name with snake emoji

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

#### Full Status Line (with all features enabled)
```
📁 my-project | 🤖 Claude 3.5 Sonnet | 💰 $0.45 session | 📈 67% | 📂 src | 🌿 feature-branch | 🐍 venv
```

#### Minimal Status Line (model display disabled)
```
📁 my-project | 💰 $0.45 session | 📈 67% | 📂 src | 🌿 feature-branch | 🐍 poetry-env
```

#### Without Python Environment
```
💰 $0.45 session | 📈 67% | 📂 claude-status-line | 🌿 main
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
