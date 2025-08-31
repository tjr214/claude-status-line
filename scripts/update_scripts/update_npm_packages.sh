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

echo -e "${CYAN}🔍 Checking for pnpm installation...${NC}"

# Capture current pnpm version before update
old_pnpm_version=$(get_version "pnpm --version")

if ! command -v pnpm &> /dev/null; then
    echo -e "${YELLOW}🚀 pnpm not found. Installing pnpm...${NC}"
    # Install pnpm using npm
    execute_command "npm install -g pnpm" "Failed to install pnpm. Please check your npm installation and try again."
    echo -e "${GREEN}✅ pnpm installed successfully!${NC}"
else
    echo -e "${YELLOW}🔄 pnpm is already installed. Updating pnpm...${NC}"
    # Update pnpm to latest version
    execute_command "npm install -g pnpm@latest" "Failed to update pnpm. Please check your npm installation and try again."
    echo -e "${GREEN}✅ pnpm updated successfully!${NC}"
fi

# Capture new pnpm version after update
new_pnpm_version=$(get_version "pnpm --version")

# Display pnpm version change
show_version_change "pnpm" "$old_pnpm_version" "$new_pnpm_version"

# Update packages
echo -e "${CYAN}📦 Updating packages...${NC}"

# Check if package.json exists
if [ ! -f "package.json" ]; then
    handle_error "package.json not found in current directory. Please run this script from your project root."
fi

execute_command "pnpm update" "Failed to update packages. Please check your project configuration and try again."

echo -e "${GREEN}${BOLD}✨ All done! packages have been updated.${NC}"

