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

# Check if npm is installed
echo -e "${CYAN}🔍 Checking for npm installation...${NC}"
if ! command -v npm &> /dev/null; then
    handle_error "npm is not installed. Please install npm first to continue."
fi

# Install repomix
echo -e "${CYAN}📦 Installing repomix...${NC}"

# Capture current version before update
old_version=$(get_version "repomix --version")

# Check if repomix is already installed
if command -v repomix &> /dev/null; then
    echo -e "${YELLOW}🔄 repomix is already installed. Updating to latest version...${NC}"
else
    echo -e "${YELLOW}🚀 Installing repomix...${NC}"
fi

# Install/update repomix globally
execute_command "npm install -g repomix" "Failed to install repomix. Please check your npm installation and try again."

# Capture new version after update
new_version=$(get_version "repomix --version")

# Display version change
show_version_change "repomix" "$old_version" "$new_version"

echo -e "${GREEN}${BOLD}✨ All done! repomix has been installed successfully.${NC}" 