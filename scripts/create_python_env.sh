#!/bin/bash

# Default Python version - configurable
DEFAULT_PYTHON_VERSION="3.12.6"

# Function to display usage
usage() {
    echo "Usage: $0 [VENV_NAME] [PYTHON_VERSION]"
    echo ""
    echo "Arguments:"
    echo "  VENV_NAME      Name of the virtual environment (optional)"
    echo "                 If omitted, reads from .python-version file"
    echo "  PYTHON_VERSION Python version to use (optional, default: $DEFAULT_PYTHON_VERSION)"
    echo ""
    echo "Examples:"
    echo "  $0 myproject 3.11.0"
    echo "  $0 myproject"
    echo "  $0"
    exit 1
}

# Parse command line arguments
VENV_NAME="$1"
PYTHON_VERSION="${2:-$DEFAULT_PYTHON_VERSION}"

# If VENV_NAME is not provided, try to read from .python-version
if [[ -z "$VENV_NAME" ]]; then
    if [[ -f ".python-version" ]]; then
        VENV_NAME=$(cat .python-version | tr -d '\n\r')
        echo "Using venv name from .python-version: $VENV_NAME"
    else
        echo "Error: No VENV_NAME provided and .python-version file not found"
        usage
    fi
fi

# Validate that VENV_NAME is not empty
if [[ -z "$VENV_NAME" ]]; then
    echo "Error: VENV_NAME cannot be empty"
    usage
fi

echo "Creating Python virtual environment..."
echo "  Name: $VENV_NAME"
echo "  Python Version: $PYTHON_VERSION"

# Check if pyenv and pyenv-virtualenv plugin are available
if ! command -v pyenv &> /dev/null; then
    echo "❌ pyenv is not installed or not in PATH"
    echo ""
    echo "This script requires pyenv to manage Python virtual environments."
    echo "To install pyenv, visit: https://github.com/pyenv/pyenv#installation"
    echo ""
    echo "Quick install commands:"
    echo "  # macOS (Homebrew):"
    echo "  brew install pyenv"
    echo ""
    echo "  # Linux:"
    echo "  curl https://pyenv.run | bash"
    exit 1
fi

# Check if pyenv-virtualenv plugin is available
if ! pyenv help virtualenv &> /dev/null; then
    echo "❌ pyenv-virtualenv plugin is not installed"
    echo ""
    echo "This script requires the pyenv-virtualenv plugin to create virtual environments."
    echo "To install pyenv-virtualenv:"
    echo ""
    echo "  # macOS (Homebrew):"
    echo "  brew install pyenv-virtualenv"
    echo ""
    echo "  # Linux/WSL:"
    echo "  git clone https://github.com/pyenv/pyenv-virtualenv.git \$(pyenv root)/plugins/pyenv-virtualenv"
    echo ""
    echo "After installation, restart your shell or run:"
    echo "  exec \$SHELL"
    exit 1
fi

echo "✅ pyenv and pyenv-virtualenv detected"

# Check if the Python version is installed in pyenv
if pyenv versions --bare | grep -q "^${PYTHON_VERSION}$"; then
    echo "✅ Python $PYTHON_VERSION is available via pyenv"
else
    echo "❌ Python $PYTHON_VERSION not found in pyenv"
    echo "Available versions:"
    pyenv versions --bare
    echo ""
    echo "To install Python $PYTHON_VERSION with pyenv, run:"
    echo "  pyenv install $PYTHON_VERSION"
    exit 1
fi

# Create virtual environment using pyenv
echo "Creating virtual environment with pyenv..."
pyenv virtualenv "$PYTHON_VERSION" "$VENV_NAME"

if [[ $? -eq 0 ]]; then
    echo "✅ Virtual environment '$VENV_NAME' created successfully with pyenv!"
    echo ""
    echo "To activate the environment, run:"
    echo "  pyenv activate $VENV_NAME"
    echo ""
    echo "To deactivate, run:"
    echo "  pyenv deactivate"
    echo ""
    echo "To set as local environment for this project:"
    echo "  pyenv local $VENV_NAME"
else
    echo "❌ Failed to create virtual environment with pyenv"
    exit 1
fi