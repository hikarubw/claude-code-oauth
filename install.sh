#!/bin/bash
# Claude OAuth - Quick Installer
# Downloads and sets up the claude-oauth CLI tool

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
REPO="hikarubw/claude-code-oauth"
BRANCH="main"
INSTALL_DIR="$HOME/.local/bin"
TOOL_NAME="claude-oauth"

echo -e "${BLUE}Claude OAuth Installer${NC}"
echo ""

# Check if running with curl pipe
if [ -t 0 ]; then
    # Running directly
    INSTALL_MODE="local"
else
    # Running from curl pipe
    INSTALL_MODE="remote"
fi

# Function to install locally
install_local() {
    if [ ! -f "claude-oauth" ]; then
        echo -e "${RED}Error: claude-oauth not found in current directory${NC}"
        exit 1
    fi
    
    echo "Installing claude-oauth to $INSTALL_DIR..."
    
    # Create directory if it doesn't exist
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Creating directory: $INSTALL_DIR"
        mkdir -p "$INSTALL_DIR"
    fi
    
    # Install the tool
    cp claude-oauth "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/claude-oauth"
    
    # Also download the workflow templates
    echo "Downloading workflow templates..."
    local template_dir="$HOME/.claude-oauth"
    mkdir -p "$template_dir"
    
    if [ -f "templates/claude.yml" ]; then
        cp templates/claude.yml "$template_dir/claude.yml"
        cp templates/claude-api.yml "$template_dir/claude-api.yml" 2>/dev/null || true
    else
        curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/templates/claude.yml" \
            -o "$template_dir/claude.yml" 2>/dev/null
        curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/templates/claude-api.yml" \
            -o "$template_dir/claude-api.yml" 2>/dev/null
    fi
}

# Function to install remotely
install_remote() {
    echo "Downloading claude-oauth..."
    
    # Create temp directory
    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT
    
    # Download the tool
    if ! curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/claude-oauth" \
        -o "$TEMP_DIR/claude-oauth" 2>/dev/null; then
        echo -e "${RED}Failed to download claude-oauth${NC}"
        exit 1
    fi
    
    chmod +x "$TEMP_DIR/claude-oauth"
    
    # Download workflow templates
    echo "Downloading workflow templates..."
    local template_dir="$HOME/.claude-oauth"
    mkdir -p "$template_dir"
    
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/templates/claude.yml" \
        -o "$template_dir/claude.yml" 2>/dev/null
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/templates/claude-api.yml" \
        -o "$template_dir/claude-api.yml" 2>/dev/null
    
    # Install to system
    echo "Installing to $INSTALL_DIR..."
    
    # Create directory if it doesn't exist
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Creating directory: $INSTALL_DIR"
        mkdir -p "$INSTALL_DIR"
    fi
    
    mv "$TEMP_DIR/claude-oauth" "$INSTALL_DIR/"
}

# Check for custom install directory
if [ -n "$1" ]; then
    INSTALL_DIR="$1"
fi

# Perform installation
if [ "$INSTALL_MODE" = "local" ]; then
    install_local
else
    install_remote
fi

# Verify installation
if command -v claude-oauth &> /dev/null; then
    echo ""
    echo -e "${GREEN}✅ Installation successful!${NC}"
    echo ""
    echo "Claude OAuth CLI has been installed to: $INSTALL_DIR/claude-oauth"
    echo ""
    echo "To get started:"
    echo "1. cd into your project directory"
    echo "2. Run: claude-oauth setup"
    echo ""
    echo "For help: claude-oauth help"
else
    echo ""
    echo -e "${YELLOW}Installation complete!${NC}"
    echo ""
    echo "Claude OAuth CLI has been installed to: $INSTALL_DIR/claude-oauth"
    echo ""
    echo "To use claude-oauth, add this to your ~/.bashrc or ~/.zshrc:"
    echo -e "${GREEN}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
    echo ""
    echo "Then reload your shell:"
    echo "  source ~/.bashrc  # for bash"
    echo "  source ~/.zshrc   # for zsh"
    echo ""
    echo "Or run directly: $INSTALL_DIR/claude-oauth"
fi