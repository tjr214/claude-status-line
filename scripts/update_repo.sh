#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Counters for summary
SUCCESS_COUNT=0
FAILED_COUNT=0
SKIPPED_COUNT=0

# Arrays to track operations
SUCCESSFUL_ITEMS=()
FAILED_ITEMS=()
SKIPPED_ITEMS=()

# Function to print colored messages
print_status() {
    local status="$1"
    local message="$2"
    case "$status" in
        "success")
            echo -e "${GREEN}✅ $message${NC}"
            ;;
        "error")
            echo -e "${RED}❌ $message${NC}"
            ;;
        "warning")
            echo -e "${YELLOW}⚠️  $message${NC}"
            ;;
        "info")
            echo -e "${CYAN}ℹ️  $message${NC}"
            ;;
        "header")
            echo -e "\n${BLUE}🚀 $message${NC}"
            ;;
    esac
}

# Function to get file type emoji
get_file_emoji() {
    local item="$1"
    case "$item" in
        .claude|.cursor|.gemini|scripts|dev-journal)
            echo "📁"
            ;;
        *.json)
            echo "⚙️"
            ;;
        *.md)
            echo "📄"
            ;;
        *.py)
            echo "🐍"
            ;;
        *.sh)
            echo "📜"
            ;;
        .*)
            echo "⚙️"
            ;;
        *)
            echo "📄"
            ;;
    esac
}

# Function to safely copy with error checking
safe_copy() {
    local source="$1"
    local dest="$2"
    local item_name="$3"
    local emoji=$(get_file_emoji "$item_name")
    
    if [ ! -e "$source" ]; then
        print_status "error" "$emoji $item_name - Source not found"
        FAILED_ITEMS+=("$item_name")
        ((FAILED_COUNT++))
        return 1
    fi
    
    if cp -Rf "$source" "$dest" 2>/dev/null; then
        print_status "success" "$emoji $item_name - Copied successfully"
        SUCCESSFUL_ITEMS+=("$item_name")
        ((SUCCESS_COUNT++))
        return 0
    else
        print_status "error" "$emoji $item_name - Copy failed"
        FAILED_ITEMS+=("$item_name")
        ((FAILED_COUNT++))
        return 1
    fi
}

# Get directory paths
CURRENT_REPO_ROOT=$(pwd)
TEMPLATE_REPO_ROOT=$CURRENT_REPO_ROOT/nr

# Get the absolute path of the current working directory
CURRENT_REPO_ROOT="$(realpath $CURRENT_REPO_ROOT)"
TEMPLATE_REPO_ROOT="$(realpath $TEMPLATE_REPO_ROOT)"

print_status "header" "Repository Update Script Starting"

print_status "info" "Current repository root: $CURRENT_REPO_ROOT"
print_status "info" "Template repository root: $TEMPLATE_REPO_ROOT"

# Check if template directory exists
if [ ! -d "$TEMPLATE_REPO_ROOT" ]; then
    print_status "error" "Template directory '$TEMPLATE_REPO_ROOT' not found!"
    exit 1
fi

# Check write permissions
if [ ! -w "$CURRENT_REPO_ROOT" ]; then
    print_status "error" "No write permission in current directory!"
    exit 1
fi

# Change to template directory
if ! cd "$TEMPLATE_REPO_ROOT" 2>/dev/null; then
    print_status "error" "Failed to access template directory!"
    exit 1
fi

print_status "header" "Copying Template Files"

# Copy directories
safe_copy ".claude" "../" ".claude"
safe_copy ".cursor" "../" ".cursor"
safe_copy ".gemini" "../" ".gemini"
safe_copy "scripts" "../" "scripts"

# Copy JSON configuration files
safe_copy ".mcp.example.json" "../" ".mcp.example.json"
safe_copy ".mcp.json" "../" ".mcp.json"

# Copy ignore files
safe_copy ".repomixignore" "../" ".repomixignore"
safe_copy ".gitignore" "../" ".gitignore"
safe_copy ".cursorignore" "../" ".cursorignore"

# Copy Python files
safe_copy "dramatic_hello.py" "../" "dramatic_hello.py"

# Copy shell scripts
safe_copy "update_packages.sh" "../" "update_packages.sh"

# Copy documentation
safe_copy "GEMINI.md" "../" "GEMINI.md"
safe_copy "CLAUDE.md" "../" "CLAUDE.md"

# Check if dev-journal directory exists, if not, copy it in
if [ ! -d "$CURRENT_REPO_ROOT/dev-journal" ]; then
    print_status "info" "📁 dev-journal directory not found, copying it in..."
    safe_copy "dev-journal" "../" "dev-journal"
else
    print_status "warning" "📁 dev-journal - Already exists, skipping"
    SKIPPED_ITEMS+=("dev-journal")
    ((SKIPPED_COUNT++))
fi

# Cleanup the template repository
cd "$CURRENT_REPO_ROOT"
if rm -rf "$TEMPLATE_REPO_ROOT" 2>/dev/null; then
    print_status "success" "🗑️  Template directory cleaned up"
else
    print_status "warning" "🗑️  Could not remove template directory"
fi

# Print summary
print_status "header" "Operation Summary"
echo -e "${GREEN}✅ Successful: $SUCCESS_COUNT items${NC}"
echo -e "${RED}❌ Failed: $FAILED_COUNT items${NC}"
echo -e "${YELLOW}⚠️  Skipped: $SKIPPED_COUNT items${NC}"

if [ ${#SUCCESSFUL_ITEMS[@]} -gt 0 ]; then
    echo -e "\n${GREEN}Successfully copied:${NC}"
    for item in "${SUCCESSFUL_ITEMS[@]}"; do
        echo -e "  ${GREEN}✓${NC} $item"
    done
fi

if [ ${#FAILED_ITEMS[@]} -gt 0 ]; then
    echo -e "\n${RED}Failed to copy:${NC}"
    for item in "${FAILED_ITEMS[@]}"; do
        echo -e "  ${RED}✗${NC} $item"
    done
fi

if [ ${#SKIPPED_ITEMS[@]} -gt 0 ]; then
    echo -e "\n${YELLOW}Skipped items:${NC}"
    for item in "${SKIPPED_ITEMS[@]}"; do
        echo -e "  ${YELLOW}—${NC} $item"
    done
fi

echo -e "\n${BLUE}🎉 Repository update completed!${NC}"

# Exit with error code if any operations failed
if [ $FAILED_COUNT -gt 0 ]; then
    exit 1
else
    exit 0
fi
