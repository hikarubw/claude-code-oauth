#!/bin/bash
# Claude Code OAuth - Installer
# Sets up OAuth tools for GitHub integration

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}Claude Code OAuth Installer${NC}"
echo ""

# Check if in git repo
if [ ! -d ".git" ]; then
    echo "Error: Not in a git repository"
    echo "Please run from your project root"
    exit 1
fi

# Create directories
mkdir -p .claude/{tools,commands} .github/workflows

# Download OAuth tool
echo "Installing OAuth setup tool..."
curl -fsSL "https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/tools/oauth-setup" \
    -o ".claude/tools/oauth-setup" 2>/dev/null
chmod +x .claude/tools/oauth-setup

# Download command docs
curl -fsSL "https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/commands/setup-oauth.md" \
    -o ".claude/commands/setup-oauth.md" 2>/dev/null

# Check if GitHub workflow exists
if [ -f ".github/workflows/claude.yml" ]; then
    echo -e "${YELLOW}GitHub workflow already exists${NC}"
else
    echo "Creating GitHub Action template..."
    curl -fsSL "https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/templates/claude.yml" \
        -o ".github/workflows/claude.yml" 2>/dev/null
fi

echo ""
echo -e "${GREEN}✅ OAuth tools installed!${NC}"
echo ""
echo "Next steps:"
echo "1. Run in Claude Code: /project:setup-oauth"
echo "2. Follow the instructions to configure GitHub OAuth"
echo ""
echo "This will:"
echo "- Store credentials securely"
echo "- Set up GitHub Action"
echo "- Configure repository secrets"