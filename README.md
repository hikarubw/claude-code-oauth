# Claude OAuth CLI

> Simple OAuth setup tool for Claude Code GitHub integration

A streamlined CLI tool that configures OAuth authentication for Claude Code to interact with your GitHub repositories through Issues and Pull Requests.

## Features

- 🔐 Secure OAuth authentication (no API keys)
- 🤖 Automated GitHub Actions setup
- 💬 @claude mentions in Issues and PRs
- 🔀 Auto-PR creation from Issues
- 🏷️ Intelligent label and project management

## Quick Start

```bash
# Install the CLI tool
curl -fsSL https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/install.sh | bash

# Setup OAuth in your project
cd your-project
claude-oauth setup

# That's it! Claude will now respond to @claude mentions
```

## Installation

### Option 1: Quick Install (Recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/install.sh | bash
```

### Option 2: Manual Install
```bash
git clone https://github.com/hikarubw/claude-code-oauth.git
cd claude-code-oauth
./install.sh
```

### Option 3: Custom Directory
```bash
# Install to a custom directory
curl -fsSL https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/install.sh | bash -s -- ~/bin
```

## Usage

### Setup OAuth
```bash
# Full setup (recommended)
claude-oauth setup

# Just install the workflow
claude-oauth install

# Test your configuration
claude-oauth test

# Remove OAuth setup
claude-oauth uninstall
```

### How It Works

1. **Reads Claude credentials** from your local machine (via `claude login`)
2. **Configures GitHub secrets** automatically using GitHub CLI
3. **Installs GitHub Action** that responds to @claude mentions
4. **No manual configuration** required

## Requirements

- Git repository
- GitHub CLI (`gh`) authenticated
- `jq` installed
- Claude Code logged in (`claude login`)

## Security

- Credentials stored in macOS Keychain or Linux secure storage
- Never committed to repository
- OAuth tokens managed as GitHub secrets
- Workflow restricted to repository collaborators

## Advanced Features

The installed GitHub Action includes:

- **Issue Management**: Auto-labels, milestones, project boards
- **PR Automation**: Creates PRs from Issues with fixes
- **Security Checks**: Validates permissions before execution
- **Rich Context**: Provides Claude with full repository context

## Commands

| Command | Description |
|---------|-------------|
| `claude-oauth setup` | Complete OAuth setup |
| `claude-oauth install` | Install workflow only |
| `claude-oauth test` | Verify configuration |
| `claude-oauth uninstall` | Remove OAuth setup |
| `claude-oauth help` | Show help message |

## Troubleshooting

### Missing Dependencies
```bash
# macOS
brew install gh jq

# Ubuntu/Debian
sudo apt install gh jq
```

### GitHub CLI Not Authenticated
```bash
gh auth login
```

### Claude Not Logged In
```bash
claude login
```

## License

MIT License - See [LICENSE](LICENSE) file for details.