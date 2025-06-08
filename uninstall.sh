#!/bin/bash
# Claude Action Auth - Uninstaller
# Removes the claude-auth CLI tool

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Default install location
INSTALL_DIR="$HOME/.local/bin"
TOOL_NAME="claude-auth"

echo -e "${RED}Claude Action Auth Uninstaller${NC}"
echo ""

# Check for custom install directory
if [ -n "$1" ]; then
    INSTALL_DIR="$1"
fi

TOOL_PATH="$INSTALL_DIR/$TOOL_NAME"

# Check if tool exists
if [ ! -f "$TOOL_PATH" ]; then
    echo "Claude Action Auth not found at: $TOOL_PATH"
    echo ""
    echo "Checking common locations..."
    
    # Check other common locations
    for dir in ~/.local/bin ~/bin /usr/local/bin /usr/bin; do
        # Expand the tilde
        expanded_dir=$(eval echo "$dir")
        if [ -f "$expanded_dir/$TOOL_NAME" ]; then
            echo "Found at: $expanded_dir/$TOOL_NAME"
            TOOL_PATH="$expanded_dir/$TOOL_NAME"
            INSTALL_DIR="$expanded_dir"
            break
        fi
    done
    
    if [ ! -f "$TOOL_PATH" ]; then
        echo -e "${RED}Claude Action Auth not found in system${NC}"
        exit 1
    fi
fi

# Confirm uninstallation
echo -e "${YELLOW}This will remove:${NC}"
echo "- $TOOL_PATH"
echo "- ~/.claude-action-auth/ (template directory)"
echo ""
echo "Note: This will NOT remove:"
echo "- GitHub workflows in your projects"
echo "- GitHub secrets in your repositories"
echo ""
read -p "Continue with uninstallation? (y/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstallation cancelled"
    exit 0
fi

# Remove the tool
echo "Removing $TOOL_NAME..."
rm -f "$TOOL_PATH"

# Remove template directory
if [ -d "$HOME/.claude-action-auth" ]; then
    echo "Removing template directory..."
    rm -rf "$HOME/.claude-action-auth"
fi

echo ""
echo -e "${GREEN}✅ Claude Action Auth uninstalled!${NC}"
echo ""
echo "To remove authentication from a project:"
echo "1. cd into the project"
echo "2. Delete .github/workflows/claude.yml"
echo "3. Remove GitHub secrets:"
echo "   - CLAUDE_ACCESS_TOKEN"
echo "   - CLAUDE_REFRESH_TOKEN"
echo "   - CLAUDE_EXPIRES_AT"