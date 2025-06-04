#!/bin/bash
# Claude OAuth CLI - Uninstaller
# Removes the claude-oauth CLI tool

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Default install location
INSTALL_DIR="$HOME/.local/bin"
TOOL_NAME="claude-oauth"

echo -e "${RED}Claude OAuth CLI Uninstaller${NC}"
echo ""

# Check for custom install directory
if [ -n "$1" ]; then
    INSTALL_DIR="$1"
fi

TOOL_PATH="$INSTALL_DIR/$TOOL_NAME"

# Check if tool exists
if [ ! -f "$TOOL_PATH" ]; then
    echo "Claude OAuth CLI not found at: $TOOL_PATH"
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
        echo -e "${RED}Claude OAuth CLI not found in system${NC}"
        exit 1
    fi
fi

# Confirm uninstallation
echo -e "${YELLOW}This will remove:${NC}"
echo "- $TOOL_PATH"
echo "- ~/.claude-oauth/ (template directory)"
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
if [ -d "$HOME/.claude-oauth" ]; then
    echo "Removing template directory..."
    rm -rf "$HOME/.claude-oauth"
fi

echo ""
echo -e "${GREEN}✅ Claude OAuth CLI uninstalled!${NC}"
echo ""
echo "To remove OAuth from a project:"
echo "1. cd into the project"
echo "2. Delete .github/workflows/claude.yml"
echo "3. Remove GitHub secrets:"
echo "   - CLAUDE_ACCESS_TOKEN"
echo "   - CLAUDE_REFRESH_TOKEN"
echo "   - CLAUDE_EXPIRES_AT"