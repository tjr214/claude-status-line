#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
RED_BOLD='\033[1;31m'
GREEN_BOLD='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Function to print colored messages
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_step() {
    echo -e "${PURPLE}🚀 $1${NC}"
}

print_important() {
    echo -e "${CYAN}🔥 $1${NC}"
}

# Function to check command success
check_command() {
    if [ $? -eq 0 ]; then
        print_success "$1"
    else
        print_error "$2"
        exit 1
    fi
}

# Check first parameter for update mode
UPDATE_MODE=false
if [ $# -gt 0 ]; then
    case "$1" in
        "update"|"Update"|"upgrade"|"up"|"u")
            UPDATE_MODE=true
            print_info "Running in UPDATE mode - skipping project setup questions"
            ;;
        *)
            print_error "Invalid parameter: '$1'"
            print_error "Valid parameters are: update, Update, upgrade, up, u"
            print_error "Or run without parameters for normal installation"
            exit 1
            ;;
    esac
fi

# Start installation
echo -e "\n"
if [ "$UPDATE_MODE" = true ]; then
    print_step "Starting Repository Update..."
else
    print_step "Starting New Project Setup..."
fi
echo -e "\n"

# Remove existing git directory...
print_info "Removing existing .git directory..."
rm -rf .git
check_command "Git directory removed successfully" "Failed to remove .git directory"

# If in UPDATE mode, skip the following steps
if [ "$UPDATE_MODE" = true ]; then
    print_info "Skipping git init (UPDATE mode)"
else
    # ...and create a new one!
    print_info "Creating new .git directory..."
    git init
    check_command "Git directory created successfully" "Failed to create .git directory"
fi

# Get input from the user for dash-separated-project-name which will be used for .python-version env name
validate_project_name() {
    local name="$1"
    
    # Check if empty
    if [ -z "$name" ]; then
        return 1
    fi
    
    # Check length (3-50 characters seems reasonable)
    if [ ${#name} -lt 3 ] || [ ${#name} -gt 50 ]; then
        return 1
    fi
    
    # Check for valid characters (alphanumeric and dashes only)
    if [[ ! "$name" =~ ^[a-zA-Z0-9-]+$ ]]; then
        return 1
    fi
    
    # Check for consecutive dashes
    if [[ "$name" =~ -- ]]; then
        return 1
    fi
    
    # Check for dashes at start or end
    if [[ "$name" =~ ^- ]] || [[ "$name" =~ -$ ]]; then
        return 1
    fi
    
    return 0
}

format_project_name() {
    local name="$1"
    # Replace dashes with spaces and capitalize first letter of each word
    echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1'
}

# Get project name from user (skip in update mode)
if [ "$UPDATE_MODE" = false ]; then
    while true; do
        echo ""
        echo -ne "\033[1;37m"
        read -p $'\033[33m🔥 Enter your project name (dash-separated, e.g., \033[1;32mmy-awesome-project\033[33m): \033[1;37m' project_name
        echo -ne "\033[0m"
        
        if validate_project_name "$project_name"; then
            formatted_name=$(format_project_name "$project_name")
            echo ""
            print_info "Project name will be formatted as: '$formatted_name'"
            read -p "Is this correct? (Y/n): " confirm
            
            if [[ "$confirm" =~ ^[Nn]$ ]]; then
                print_info "Let's try again..."
            else
                print_success "Project name confirmed: $project_name"
                break
            fi
        else
            print_error "Invalid project name. Requirements:"
            print_error "- 3-50 characters long"
            print_error "- Only alphanumeric characters and dashes"
            print_error "- No consecutive dashes (--)"
            print_error "- No dashes at start or end"
            print_info "Please try again..."
        fi
    done
else
    print_info "Skipping project name setup (UPDATE mode)"
fi

# Update PROJECT-DESCRIPTION.md with the formatted project name (skip in update mode)
if [ "$UPDATE_MODE" = false ]; then
    print_info "Updating PROJECT-DESCRIPTION.md with project name..."
    if [ -f "dev-journal/PROJECT-DESCRIPTION.md" ]; then
        # Cross-platform sed command (handles macOS and Linux differences)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS requires backup extension argument
            sed -i '' "s/UNTITLED PROJECT/$formatted_name/" "dev-journal/PROJECT-DESCRIPTION.md"
        else
            # Linux and other Unix systems
            sed -i "s/UNTITLED PROJECT/$formatted_name/" "dev-journal/PROJECT-DESCRIPTION.md"
        fi
        check_command "PROJECT-DESCRIPTION.md updated successfully" "Failed to update PROJECT-DESCRIPTION.md"
    else
        print_warning "dev-journal/PROJECT-DESCRIPTION.md not found, skipping update"
    fi

    # Update OUR-PLAN.md with the formatted project name
    print_info "Updating OUR-PLAN.md with project name..."
    if [ -f "dev-journal/OUR-PLAN.md" ]; then
        # Cross-platform sed command (handles macOS and Linux differences)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS requires backup extension argument
            sed -i '' "s/PROJECT NAME GOES HERE WHEN READY/$formatted_name/" "dev-journal/OUR-PLAN.md"
        else
            # Linux and other Unix systems
            sed -i "s/PROJECT NAME GOES HERE WHEN READY/$formatted_name/" "dev-journal/OUR-PLAN.md"
        fi
        check_command "OUR-PLAN.md updated successfully" "Failed to update OUR-PLAN.md"
    else
        print_warning "dev-journal/OUR-PLAN.md not found, skipping update"
    fi
else
    print_info "Skipping project name file updates (UPDATE mode)"
fi

# Update pyproject.toml with the dashed project name (skip in update mode)
if [ "$UPDATE_MODE" = false ]; then
    print_info "Updating pyproject.toml with project name..."
    if [ -f "pyproject.toml" ]; then
        # Cross-platform sed command (handles macOS and Linux differences)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS requires backup extension argument
            sed -i '' "s/new-repo-template/$project_name/" "pyproject.toml"
        else
            # Linux and other Unix systems
            sed -i "s/new-repo-template/$project_name/" "pyproject.toml"
        fi
        check_command "pyproject.toml updated successfully" "Failed to update pyproject.toml"
    else
        print_warning "pyproject.toml not found, skipping update"
    fi
else
    print_info "Skipping pyproject.toml update (UPDATE mode)"
fi

# Ask if this is a Python project before setting up Python environment (skip in update mode)
if [ "$UPDATE_MODE" = false ]; then
    echo -e "\n"
    echo -ne "\033[1;37m"
    read -p $'\033[33m🔥 Is this a Python project or does this project use Python in any way? (Y/n): \033[1;37m' is_python_project
    echo -ne "\033[0m"

    case "$is_python_project" in
        [Nn]|[Nn][Oo])
            print_info "Skipping Python environment setup (not a Python project)"
            ;;
        *)
            # Update .i_use_python file with the dash-separated project name
            print_info "Updating .i_use_python file with project name..."
            touch .i_use_python
            if [ -f ".i_use_python" ]; then
                echo "$project_name" > .i_use_python
                check_command ".i_use_python updated successfully" "Failed to update .i_use_python"
            else
                print_warning ".i_use_python file not found, skipping update"
            fi

            # Create the new python environment
            # print_info "Creating the new python environment..."
            # ./scripts/create_python_env.sh
            # check_command "Python environment created successfully" "Failed to create python environment"

            # Re-Switch into active directory to activate the new python environment
            print_info "Re-Switching into active directory to activate the new python environment..."
            cd .
            check_command "Re-Switched into active directory successfully" "Failed to re-switch into active directory"

            # Update uv
            print_info "Updating uv..."
            uv self update
            check_command "uv updated successfully" "Failed to update uv"

            # Remove the existing .venv directory
            print_info "Removing the existing .venv directory..."
            rm -rf .venv
            check_command ".venv directory removed successfully" "Failed to remove .venv directory"

            # Remove the new_repo_template.egg-info directory if it exists
            if [ -d "new_repo_template.egg-info" ]; then
                print_info "Removing new_repo_template.egg-info directory..."
                rm -rf new_repo_template.egg-info
                check_command "new_repo_template.egg-info directory removed successfully" "Failed to remove new_repo_template.egg-info directory"
            fi

            # Install requirements.txt if it exists
            if [ -f "pyproject.toml" ]; then
                print_info "Installing Python packages from pyproject.toml..."
                uv sync
                check_command "Python packages installed successfully" "Failed to install Python packages"
            else
                print_warning "pyproject.toml not found, skipping Python package installation"
            fi
            ;;
    esac
else
    print_info "Skipping Python environment setup (UPDATE mode)"
    # Set is_python_project to a default value for later use in the script
    is_python_project="n"
fi

# Creating directories for unit and integration tests
print_info "Creating directories for unit and integration tests..."
./scripts/make_test_dirs.sh
check_command "Test directories created successfully" "Failed to create test directories"

# Update packages
if [ "$UPDATE_MODE" = false ]; then
    print_info "Updating and installing base packages..."
    ./update_packages.sh base
    check_command "Packages updated successfully" "Failed to update packages"
else
    print_info "Skipping package updates (UPDATE mode)"
fi

# Modify .gitignore to uncomment `.env`
print_info "Uncommenting .env in .gitignore..."
if [ -f .gitignore ]; then
    # Cross-platform sed command (handles macOS and Linux differences)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS requires backup extension argument
        sed -i '' 's/^#\.env$/.env/' .gitignore
    else
        # Linux and other Unix systems
        sed -i 's/^#\.env$/.env/' .gitignore
    fi
    check_command ".env uncommented in .gitignore successfully" "Failed to uncomment .env in .gitignore"
else
    print_warning ".gitignore file not found, skipping .env uncomment"
fi

# Modify .gitignore to uncomment `.mcp.json` (Claude Code)
print_info "Uncommenting .mcp.json in .gitignore..."
if [ -f .gitignore ]; then
    # Cross-platform sed command (handles macOS and Linux differences)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS requires backup extension argument
        sed -i '' 's/^#\.mcp.json$/.mcp.json/' .gitignore
    else
        # Linux and other Unix systems
        sed -i 's/^#\.mcp.json$/.mcp.json/' .gitignore
    fi
    check_command ".mcp.json uncommented in .gitignore successfully" "Failed to uncomment .mcp.json in .gitignore"
else
    print_warning ".gitignore file not found, skipping .mcp.json uncomment"
fi

# Modify .gitignore to uncomment `.gemini/settings.json`
print_info "Uncommenting .gemini/settings.json in .gitignore..."
if [ -f .gitignore ]; then
    # Cross-platform sed command (handles macOS and Linux differences)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS requires backup extension argument
        sed -i '' 's/^#\.gemini\/settings.json$/.gemini\/settings.json/' .gitignore
    else
        # Linux and other Unix systems
        sed -i 's/^#\.gemini\/settings.json$/.gemini\/settings.json/' .gitignore
    fi
    check_command ".gemini/settings.json uncommented in .gitignore successfully" "Failed to uncomment .gemini/settings.json in .gitignore"
else
    print_warning ".gitignore file not found, skipping .gemini/settings.json uncomment"
fi

# Modify .gitignore to uncomment `.cursor/mcp.json`
print_info "Uncommenting .cursor/mcp.json in .gitignore..."
if [ -f .gitignore ]; then
    # Cross-platform sed command (handles macOS and Linux differences)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS requires backup extension argument
        sed -i '' 's/^#\.cursor\/mcp.json$/.cursor\/mcp.json/' .gitignore
    else
        # Linux and other Unix systems
        sed -i 's/^#\.cursor\/mcp.json$/.cursor\/mcp.json/' .gitignore
    fi
    check_command ".cursor/mcp.json uncommented in .gitignore successfully" "Failed to uncomment .cursor/mcp.json in .gitignore"
else
    print_warning ".gitignore file not found, skipping .cursor/mcp.json uncomment"
fi

# Creating the `docs/plan_from_gemini.md` file
print_info 'Creating the `dev-journal/plan_from_gemini.md` file...'
touch dev-journal/plan_from_gemini.md
check_command "dev-journal/plan_from_gemini.md file created successfully" "Failed to create dev-journal/plan_from_gemini.md file"

# Creating `previous-plans` directory
print_info 'Creating `previous-plans` directory...'
mkdir -p dev-journal/previous-plans
check_command "previous-plans directory created successfully" "Failed to create previous-plans directory"

# OPTIONAL BUT RECOMMENDED: Remove the .rulesets-backup directory, as there should be no need for it.
print_info "Removing the .rulesets-backup directory..."
rm -rf .rulesets-backup
check_command ".rulesets-backup directory removed successfully" "Failed to remove .rulesets-backup directory"

# Remove python test directories, if necessary
case "$is_python_project" in
    [Nn]|[Nn][Oo])
        print_info "Removing python test directories..."
        rm -rf tests/python
        check_command "Python test directories removed successfully" "Failed to remove python test directories"

        if [ -f .python-version ]; then
            print_info "Removing .python-version file..."
            rm -rf .python-version
            check_command ".python-version file removed successfully" "Failed to remove .python-version file"
        fi
        
        if [ -f .i_use_python ]; then
            print_info "Removing .i_use_python file..."
            rm -rf .i_use_python
            check_command ".i_use_python file removed successfully" "Failed to remove .i_use_python file"
        fi
        ;;
    *)
        # project uses python, moving on...
        ;;
esac

# Deleting template's CHANGELOG.md
print_info 'Deleting template CHANGELOG.md...'
rm -rf dev-journal/CHANGELOG.md
check_command "CHANGELOG.md deleted successfully" "Failed to delete CHANGELOG.md"

# Creating new CHANGELOG stub
print_info 'Creating new CHANGELOG.md file...'
touch dev-journal/CHANGELOG.md
check_command "CHANGELOG.md created successfully" "Failed to create CHANGELOG.md"

# Adding "# CHANGELOG" to the top of the new CHANGELOG.md file
print_info 'Adding "# CHANGELOG" to the top of the new CHANGELOG.md file...'
echo "# CHANGELOG\n" > dev-journal/CHANGELOG.md
check_command "CHANGELOG.md updated successfully" "Failed to update CHANGELOG.md"

# Deleting git-checkpoint file
print_info 'Deleting old git-checkpoint file...'
rm -rf .git-checkpoint
check_command "git-checkpoint file deleted successfully" "Failed to delete git-checkpoint file"

# Adding initial project text to git-checkpoint file
print_info 'Adding initial project text to git-checkpoint file...'
echo "New Project Started! 🚀" > .git-checkpoint
check_command "git-checkpoint file updated successfully" "Failed to update git-checkpoint file"

# If in UPDATE mode, skip the following steps
if [ "$UPDATE_MODE" = true ]; then
    print_info "Skipping git add and commit (UPDATE mode)"
else
    # Add all files to git
    print_info "Adding files to git repo..."
    git add .
    check_command "Files added to git successfully" "Failed to add files to git"

    # Create initial commit
    print_info "Creating initial commit..."
    git commit -m "Initial commit"
    check_command "Initial commit created successfully" "Failed to create initial commit"

    # Success message
    echo -e "\n"
    print_success "🎉 New Project setup completed successfully!"
    echo -e "\n"
    echo -e "💡 NEXT STEPS (OUTDATED -- NEEDS TO BE UPDATED ASAP!!):"
    echo -e "- Discuss your idea with AI and ask for a PRD using example_prd.txt, and save it to scripts/PRD.txt"
    echo -e "- Ask the AI agent to parse the PRD file and generate initial tasks: (parse_prd)"
    echo -e "- Now ask the Agent to analyze the complexity of the tasks in your PRD using research: (analyze_project_complexity)"
    echo -e "- Ask the Agent to expand all of your tasks using the complexity analysis"
    echo -e "- Ask the Agent to begin working on the next task"
    echo -e "\n"
    print_step "Let's get to work! 💪"
fi
echo -e "\n"

# Give a reminder to activate the new python environment if it was created
case "$is_python_project" in
    [Nn]|[Nn][Oo])
        ;;
    *)
        echo -e 'REMEMBER: to type `cd .` to activate the new python environment!'
        echo -e "\n"
        ;;
esac

# Clean up installer
print_info "Cleaning up installer..."
rm -rf install.sh
