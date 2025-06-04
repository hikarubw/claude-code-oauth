# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Testing and Development
```bash
# Run the complete test suite
./test.sh

# Test the CLI locally
./claude-oauth help
./claude-oauth --version

# Verify script syntax
bash -n claude-oauth
bash -n install.sh
bash -n uninstall.sh
```

### Installation
```bash
# Install from local repository
./install.sh

# Install to custom directory
./install.sh ~/bin

# Uninstall
./uninstall.sh
```

## Architecture

### Simplified CLI Design (v2.0.0)
This tool has been redesigned from a slash-command based system to a standard CLI tool:

1. **Single Binary Approach** (`claude-oauth`)
   - Self-contained CLI with subcommands
   - No dependency on Claude Code for execution
   - Standard Unix tool patterns

2. **Installation Flow**
   - Remote: `curl | bash` downloads and installs to `/usr/local/bin`
   - Local: `./install.sh` detects local mode and copies files
   - Template stored in `~/.claude-oauth/` for offline use

3. **OAuth Configuration**
   - Reads credentials from Claude's standard locations:
     - macOS: Keychain `Claude Code-credentials`
     - Linux: `~/.claude/.credentials.json`
   - Uses GitHub CLI for secret management
   - No manual token handling required

### Key Components

**claude-oauth**: Main CLI tool
- `setup`: Full OAuth configuration
- `install`: Just workflow installation
- `test`: Configuration verification
- `uninstall`: Clean removal

**install.sh**: Smart installer
- Detects local vs remote execution
- Handles sudo when needed
- Downloads workflow template

**templates/claude.yml**: GitHub Action workflow
- 986 lines of advanced automation
- Issue and PR handling
- Security restrictions

## Version Management

Version defined in two places that must stay synchronized:
- `VERSION` file: `2.0.0`
- `claude-oauth` script: `VERSION="2.0.0"`

## Design Decisions

1. **No Slash Commands**: Removed `.claude/commands/` structure for simplicity
2. **System Installation**: Uses standard `/usr/local/bin` instead of project-specific installation
3. **Template Caching**: Stores workflow template locally for offline use
4. **Unified Tool**: Single `claude-oauth` command instead of multiple scripts