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

# Display usage information
display_usage() {
    echo -e "${CYAN}${BOLD}📋 Update Packages Script${NC}"
    echo
    echo -e "${YELLOW}Usage:${NC}"
    echo -e "  ${BOLD}./update_packages.sh <package-type>${NC}"
    echo
    echo -e "${YELLOW}Available package types:${NC}"
    echo -e "  ${GREEN}base${NC}         - REQ: Update all npm-based MCP tools, CLI apps, and needed packages"
    echo -e "  ${GREEN}repo${NC}         - OPTIONAL: Update this repository with the latest upgrades to the Template"
    echo -e "  ${GREEN}all${NC}          - Update everything: the repo, the base requirements, the NPM and Python packages"
    echo -e "  ${GREEN}npm${NC}          - Update npm packages using pnpm"
    echo -e "  ${GREEN}python${NC}       - Update Python packages using pip"
    echo -e "  ${GREEN}repomix${NC}      - Update Repomix CLI tool"
    echo -e "  ${GREEN}gemini${NC}       - Update Gemini CLI tool"
    echo -e "  ${GREEN}claude${NC}       - Update Claude Code CLI tool"
    echo -e "  ${GREEN}ccm${NC}          - Update Claude Code Monitor CLI tool"
    echo -e "  ${GREEN}hello${NC}        - Run the 'dramatic hello world' script"
    echo
    echo -e "${YELLOW}Example:${NC}"
    echo -e "  ${BOLD}./update_packages.sh npm${NC}"
    echo
}

# Check if we're in the project root
check_project_root() {
    if [ ! -d "scripts/update_scripts" ]; then
        handle_error "This script must be run from the project root directory where 'scripts/update_scripts' exists."
    fi
}

# Main execution function
update_packages() {
    local package_type="$1"
    local script_path=""
    
    case "$package_type" in
        "npm")
            script_path="scripts/update_scripts/update_npm_packages.sh"
            ;;
        "python")
            script_path="scripts/update_scripts/update_python_packages.sh"
            ;;
        "repomix")
            script_path="scripts/update_scripts/update_repomix.sh"
            ;;
        "gemini")
            script_path="scripts/update_scripts/update_gemini_cli.sh"
            ;;
        "claude")
            script_path="scripts/update_scripts/update_claude_code.sh"
            ;;
        "ccm")
            script_path="scripts/update_scripts/update_claude_code_monitor.sh"
            ;;
        "hello")
            execute_command "python scripts/dramatic_hello.py" "Failed to run the 'dramatic hello world' script."
            return
            ;;
        "all")
            echo -e "\n"
            echo -e "${MAGENTA}${BOLD}Updating AI features from Template and updating base requirements...${NC}"
            echo -e "${CYAN}${BOLD}--------------------------------${NC}"
            execute_command "./update_packages.sh repo" "Failed to update AI features in this repo."
            execute_command "./update_packages.sh base" "Failed to update base requirements."

            # Check if this is a Python project and update Python packages if needed
            if [ -f "dev-journal/.i_use_python" ]; then
                # echo -e "\n"
                # echo -e "${CYAN}${BOLD}--------------------------------${NC}"
                # echo -e "\n"
                # echo -e "${MAGENTA}${BOLD}🚀 Running Python packages update script...${NC}"
                execute_command "uv self update" "Failed to update uv."
                execute_command "./update_packages.sh python" "Failed to update Python packages."
            fi

            # Check if this is a Node.js project and update Node.js packages if needed
            if [ -f "package.json" ] || [ -f "yarn.lock" ] || [ -f "pnpm-lock.yaml" ] || [ -f "bun.lockb" ] || [ -f "node_modules" -a -d "node_modules" ]; then
                # echo -e "\n"
                # echo -e "${CYAN}${BOLD}--------------------------------${NC}"
                # echo -e "\n"
                # echo -e "${MAGENTA}${BOLD}🚀 Running Node.js packages update script...${NC}"
                execute_command "./update_packages.sh npm" "Failed to update Node.js packages."
            fi

            return
            ;;
        "repo")
            echo -e "\n"
            echo -e "${MAGENTA}${BOLD}🚀 Upgrading AI features in this repo to the latest versions 🦾...${NC}"
            echo -e "${CYAN}${BOLD}--------------------------------${NC}"
            echo -e "${MAGENTA}${BOLD}🚀 Cloning the latest template repo...${NC}"
            execute_command "git clone https://github.com/tjr214/new-repo-template.git nr" "Failed to clone template repo."
            cd nr
            execute_command "./install.sh update" "Failed to update template repo."
            cd ..
            # echo -e "\n"
            echo -e "${CYAN}${BOLD}--------------------------------${NC}"
            
            # Execute the appropriate update script
            script_path="scripts/update_repo.sh"
            execute_command "cp -Rf nr/scripts/update_repo.sh scripts/update_repo.sh" "Failed to copy the new update_repo.sh script."
            echo -e "${MAGENTA}${BOLD}🚀 Upgrading current repo's AI features...${NC}"
            execute_command "./$script_path" "Failed to execute the ${package_type} update script."
            return
            ;;
        "base")
            echo -e "${CYAN}${BOLD}--------------------------------${NC}"
            echo -e "\n"
            
            # If successful, run repomix update
            echo -e "${MAGENTA}${BOLD}🚀 Running repomix update script...${NC}"
            execute_command "./scripts/update_scripts/update_repomix.sh" "Failed to execute the repomix update script."

            echo -e "\n"
            echo -e "${CYAN}${BOLD}--------------------------------${NC}"
            echo -e "\n"
            
            # If successful, run gemini update
            echo -e "${MAGENTA}${BOLD}🚀 Running gemini update script...${NC}"
            execute_command "./scripts/update_scripts/update_gemini_cli.sh" "Failed to execute the gemini update script."
            
            echo -e "\n"
            echo -e "${CYAN}${BOLD}--------------------------------${NC}"
            echo -e "\n"
            
            # If successful, run claude update
            echo -e "${MAGENTA}${BOLD}🚀 Running Claude Code update script...${NC}"
            execute_command "./scripts/update_scripts/update_claude_code.sh" "Failed to execute the Claude Code update script."

            echo -e "\n"
            echo -e "${CYAN}${BOLD}--------------------------------${NC}"
            echo -e "\n"

            # If successful, run claude-monitor update
            echo -e "${MAGENTA}${BOLD}🚀 Running Claude Code Monitor update script...${NC}"
            execute_command "./scripts/update_scripts/update_claude_code_monitor.sh" "Failed to execute the Claude Code Monitor update script."

            echo -e "\n"
            echo -e "${CYAN}${BOLD}--------------------------------${NC}"
            echo -e "\n"
            
            # Return early as we've handled all scripts
            return
            ;;
        *)
            display_usage
            handle_error "Invalid package type: ${package_type}. Please use 'base', 'repo', 'all', 'npm', 'python', 'repomix', 'gemini', 'claude', or 'hello'."
            ;;
    esac
    
    # Check if the script exists
    if [ ! -f "$script_path" ]; then
        handle_error "Update script not found: $script_path"
    fi
    
    # Make sure the script is executable
    chmod +x "$script_path"
    
    # Execute the appropriate update script
    echo -e "${MAGENTA}${BOLD}🚀 Running ${package_type} update script...${NC}"
    execute_command "./$script_path" "Failed to execute the ${package_type} update script."
}

# Main script logic
main() {
    # Check if running from project root
    check_project_root
    
    # Check if a package type was provided
    if [ $# -eq 0 ]; then
        display_usage
        exit 0
    fi
    
    update_packages "$1"
    echo -e "${GREEN}${BOLD}✨ Update complete for: $1${NC}"
}

# Call the main function with all script arguments
main "$@"

