#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color (reset)

# Error handling function
handle_error() {
    echo -e "${RED}${BOLD}ERROR: $1${NC}" >&2
    exit 1
}

# Execute command with error handling
execute_command() {
    local cmd="$1"
    local error_message="$2"
    
    echo -e "${BLUE}Executing: ${cmd}${NC}"
    if ! eval "$cmd"; then
        handle_error "$error_message"
    fi
}

# Detect Python package management approach
echo -e "${CYAN}🔍 Detecting Python package management approach...${NC}"

# Check for uv first (fastest and modern)
if command -v uv &> /dev/null; then
    echo -e "${MAGENTA}📊 Found uv: ${BOLD}$(uv --version)${NC}"
    
    if [ -f "pyproject.toml" ]; then
        echo -e "${CYAN}📦 Updating Python packages with uv (pyproject.toml)...${NC}"
        execute_command "uv sync --upgrade" "Failed to update Python packages with uv. Please check your project configuration and try again."
    elif [ -f "requirements.txt" ]; then
        echo -e "${CYAN}📦 Updating Python packages with uv (requirements.txt)...${NC}"
        execute_command "uv pip install -U -r requirements.txt" "Failed to update Python packages with uv. Please check your project configuration and try again."
    else
        handle_error "No pyproject.toml or requirements.txt found. Please ensure you have Python dependencies defined."
    fi

# Check for pyproject.toml with pip
elif [ -f "pyproject.toml" ]; then
    echo -e "${CYAN}🔍 Checking for pip installation...${NC}"
    if ! command -v pip &> /dev/null; then
        handle_error "pip is not installed. Please install pip first to continue."
    fi
    
    echo -e "${MAGENTA}📊 pip version: ${BOLD}$(pip --version)${NC}"
    echo -e "${CYAN}📦 Updating Python packages with pip (pyproject.toml)...${NC}"
    execute_command "pip install -U -e ." "Failed to update Python packages from pyproject.toml. Please check your project configuration and try again."

# Fallback to requirements.txt with pip
elif [ -f "requirements.txt" ]; then
    echo -e "${CYAN}🔍 Checking for pip installation...${NC}"
    if ! command -v pip &> /dev/null; then
        handle_error "pip is not installed. Please install pip first to continue."
    fi
    
    echo -e "${MAGENTA}📊 pip version: ${BOLD}$(pip --version)${NC}"
    echo -e "${CYAN}📦 Updating Python packages with pip (requirements.txt)...${NC}"
    execute_command "pip install -U -r requirements.txt" "Failed to update Python packages. Please check your project configuration and try again."

else
    handle_error "No Python dependency files found (pyproject.toml or requirements.txt). Please run this script from your project root with proper Python configuration."
fi

echo -e "${GREEN}${BOLD}✨ All done! Python packages have been updated.${NC}"
