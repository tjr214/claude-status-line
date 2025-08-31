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

# Get version function
get_version() {
    local cmd="$1"
    local version_output
    version_output=$($cmd 2>/dev/null || echo "Not installed")
    echo "$version_output"
}

# Display version change
show_version_change() {
    local tool_name="$1"
    local old_version="$2"
    local new_version="$3"
    
    if [[ "$old_version" == "Not installed" ]]; then
        echo -e "${GREEN}📊 ${tool_name} version: ${BOLD}${new_version} (newly installed)${NC}"
    elif [[ "$old_version" != "$new_version" ]]; then
        echo -e "${GREEN}📊 ${tool_name} version: ${BOLD}${old_version} → ${new_version}${NC}"
    else
        echo -e "${MAGENTA}📊 ${tool_name} version: ${BOLD}${new_version} (no change)${NC}"
    fi
}

# Check if uv is installed
echo -e "${CYAN}🔍 Checking for uv installation...${NC}"
if ! command -v uv &> /dev/null; then
    handle_error "uv is not installed. Please install uv first to continue."
fi

# Install claude-monitor
echo -e "${CYAN}📦 Installing Claude Code Monitor...${NC}"

# Capture current version before update
old_version=$(get_version "claude-monitor --version")

# Check if claude-monitor is already installed
if command -v claude-monitor &> /dev/null; then
    echo -e "${YELLOW}🔄 Claude Code Monitor is already installed. Updating to latest version...${NC}"
else
    echo -e "${YELLOW}🚀 Installing Claude Code Monitor...${NC}"
fi

# Install/update claude-monitor via uv
execute_command "uv tool install claude-monitor" "Failed to install claude-monitor. Please check your uv installation and try again."

# Capture new version after update
new_version=$(get_version "claude-monitor --version")

# Display version change
show_version_change "Claude Code Monitor" "$old_version" "$new_version"

echo -e "${GREEN}${BOLD}✨ All done! Claude Code Monitor has been installed successfully.${NC}" 