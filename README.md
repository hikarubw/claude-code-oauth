# Claude Auth CLI

> Simple authentication setup tool for Claude Code GitHub integration

A streamlined CLI tool that configures authentication (OAuth or API Key) for Claude Code to interact with your GitHub repositories through Issues and Pull Requests.

## Features

- 🔐 **Dual Authentication**: OAuth (recommended) or API Key
- 🤖 Automated GitHub Actions setup
- 💬 @claude mentions in Issues and PRs
- 🔀 Auto-PR creation from Issues (OAuth only)
- 🏷️ Intelligent label and project management (OAuth only)

## Quick Start

```bash
# Install the CLI tool
curl -fsSL https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/install.sh | bash

# Setup authentication in your project
cd your-project
claude-oauth setup  # Interactive - choose OAuth or API Key

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

### Setup Authentication
```bash
# Interactive setup (recommended)
claude-oauth setup

# OAuth setup (uses Claude login)
claude-oauth setup --auth-type=oauth

# API key setup (uses Anthropic API key)
claude-oauth setup --auth-type=api

# Just install the workflow
claude-oauth install
claude-oauth install --auth-type=api

# Test your configuration
claude-oauth test

# Remove setup
claude-oauth uninstall
```

### Authentication Methods

#### OAuth (Recommended)
- Uses your existing `claude login` credentials
- Supports advanced features (auto-PR, labels, projects)
- Fully automated setup
- No API key needed

#### API Key
- Uses Anthropic API key from console
- Basic Claude Code features
- Requires manual secret configuration
- Simpler workflow file

## Requirements

- Git repository
- GitHub CLI (`gh`) authenticated
- `jq` installed
- For OAuth: Claude Code logged in (`claude login`)
- For API Key: Anthropic API key

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
| `claude-oauth setup` | Interactive authentication setup |
| `claude-oauth setup --auth-type=oauth` | OAuth setup |
| `claude-oauth setup --auth-type=api` | API key setup |
| `claude-oauth install` | Install workflow only |
| `claude-oauth test` | Verify configuration |
| `claude-oauth uninstall` | Remove setup |
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