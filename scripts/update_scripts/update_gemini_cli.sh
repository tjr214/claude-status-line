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

# Check if npm is installed
echo -e "${CYAN}🔍 Checking for npm installation...${NC}"
if ! command -v npm &> /dev/null; then
    handle_error "npm is not installed. Please install npm first to continue."
fi

# Install gemini-cli
echo -e "${CYAN}📦 Installing gemini-cli...${NC}"

# Check if gemini-cli is already installed
if command -v gemini &> /dev/null; then
    echo -e "${YELLOW}🔄 gemini is already installed. Updating to latest version...${NC}"
else
    echo -e "${YELLOW}🚀 Installing gemini...${NC}"
fi

# Install/update gemini globally
execute_command "npm install -g @google/gemini-cli@latest" "Failed to install gemini. Please check your npm installation and try again."

# Display gemini version
echo -e "${MAGENTA}📊 gemini version: ${BOLD}$(gemini --version 2>/dev/null || echo 'Unable to determine version')${NC}"

echo -e "${GREEN}${BOLD}✨ All done! gemini has been installed successfully.${NC}" 