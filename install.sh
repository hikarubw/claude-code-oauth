#!/bin/bash
# Claude Action Auth - Quick Installer
# Downloads and sets up the claude-auth CLI tool

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
REPO="hikarubw/claude-action-auth"
BRANCH="main"
INSTALL_DIR="$HOME/.local/bin"
TOOL_NAME="claude-auth"

echo -e "${BLUE}Claude Action Auth Installer${NC}"
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
    if [ ! -f "claude-auth" ]; then
        echo -e "${RED}Error: claude-auth not found in current directory${NC}"
        exit 1
    fi
    
    echo "Installing claude-auth to $INSTALL_DIR..."
    
    # Create directory if it doesn't exist
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Creating directory: $INSTALL_DIR"
        mkdir -p "$INSTALL_DIR"
    fi
    
    # Install the tool
    cp claude-auth "$INSTALL_DIR/"
    chmod +x "$INSTALL_DIR/claude-auth"
    
    # Also download the workflow templates
    echo "Downloading workflow templates..."
    local template_dir="$HOME/.claude-action-auth"
    mkdir -p "$template_dir"
    
    if [ -f "templates/claude-advanced.yml" ]; then
        cp templates/claude-advanced.yml "$template_dir/claude-advanced.yml"
        cp templates/claude-advanced-api.yml "$template_dir/claude-advanced-api.yml" 2>/dev/null || true
    else
        curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/templates/claude-advanced.yml" \
            -o "$template_dir/claude-advanced.yml" 2>/dev/null
        curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/templates/claude-advanced-api.yml" \
            -o "$template_dir/claude-advanced-api.yml" 2>/dev/null
    fi
}

# Function to install remotely
install_remote() {
    echo "Downloading claude-auth..."
    
    # Create temp directory
    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT
    
    # Download the tool
    if ! curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/claude-auth" \
        -o "$TEMP_DIR/claude-auth" 2>/dev/null; then
        echo -e "${RED}Failed to download claude-auth${NC}"
        exit 1
    fi
    
    chmod +x "$TEMP_DIR/claude-auth"
    
    # Download workflow templates
    echo "Downloading workflow templates..."
    local template_dir="$HOME/.claude-action-auth"
    mkdir -p "$template_dir"
    
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/templates/claude-advanced.yml" \
        -o "$template_dir/claude-advanced.yml" 2>/dev/null
    curl -fsSL "https://raw.githubusercontent.com/$REPO/$BRANCH/templates/claude-advanced-api.yml" \
        -o "$template_dir/claude-advanced-api.yml" 2>/dev/null
    
    # Install to system
    echo "Installing to $INSTALL_DIR..."
    
    # Create directory if it doesn't exist
    if [ ! -d "$INSTALL_DIR" ]; then
        echo "Creating directory: $INSTALL_DIR"
        mkdir -p "$INSTALL_DIR"
    fi
    
    mv "$TEMP_DIR/claude-auth" "$INSTALL_DIR/"
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
if command -v claude-auth &> /dev/null; then
    echo ""
    echo -e "${GREEN}✅ Installation successful!${NC}"
    echo ""
    echo "Claude Action Auth has been installed to: $INSTALL_DIR/claude-auth"
    echo ""
    echo "To get started:"
    echo "1. cd into your project directory"
    echo "2. Run: claude-auth setup"
    echo ""
    echo "For help: claude-auth help"
else
    echo ""
    echo -e "${YELLOW}Installation complete!${NC}"
    echo ""
    echo "Claude Action Auth has been installed to: $INSTALL_DIR/claude-auth"
    echo ""
    echo "To use claude-auth, add this to your ~/.bashrc or ~/.zshrc:"
    echo -e "${GREEN}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
    echo ""
    echo "Then reload your shell:"
    echo "  source ~/.bashrc  # for bash"
    echo "  source ~/.zshrc   # for zsh"
    echo ""
    echo "Or run directly: $INSTALL_DIR/claude-auth"
fi