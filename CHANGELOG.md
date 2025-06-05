# Changelog

All notable changes to Claude Auth CLI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.1.0] - 2024-03-06

### Added
- Dual authentication support: OAuth and API Key
- Interactive auth type selection during setup
- API key workflow template using Anthropic's `claude-code-action@beta`
- `--auth-type` parameter for non-interactive setup
- Automatic auth type detection in test and uninstall commands

### Changed
- Renamed from "Claude OAuth CLI" to "Claude Auth CLI"
- Updated help text to reflect dual auth support
- Enhanced test command to detect and validate auth type
- Installer now downloads both workflow templates

### Improved
- Clear instructions for API key setup with manual steps
- Better error messages for auth type validation
- Smarter uninstall that removes correct secrets based on auth type

## [2.0.0] - 2024-03-06

### Changed
- Complete redesign: Removed slash command dependency
- Created unified `claude-oauth` CLI tool
- Simplified installation to standard CLI pattern
- Direct execution without Claude Code requirement
- System-wide installation to /usr/local/bin

### Added
- Standalone CLI with subcommands (setup, install, test, uninstall)
- Built-in help system
- Direct workflow management
- Improved error messages and validation

### Removed
- `.claude/commands/` directory structure
- `.claude/tools/` directory structure
- Dependency on Claude Code for OAuth setup
- Complex multi-step installation process

### Improved
- Installation now takes seconds instead of multiple steps
- Better user experience with clear command structure
- Standard CLI patterns familiar to developers

## [1.0.0] - 2024-03-06

### Added
- Initial release of Claude Code OAuth tools
- OAuth setup tool for GitHub integration
- Automated installer script
- Uninstaller script for clean removal
- GitHub Actions workflow template with advanced features
- Support for macOS Keychain and Linux credential storage
- Comprehensive documentation
- Test suite for verification
- Configuration file support

### Security
- Secure credential storage using platform-specific methods
- No credentials stored in repository
- GitHub secrets integration for CI/CD

### Features
- Auto-detection of Claude credentials
- Automatic GitHub secrets configuration
- Advanced workflow with full repository permissions
- Support for Issues and Pull Requests
- Intelligent label and milestone management
- Auto-PR creation for issue fixes

[2.1.0]: https://github.com/hikarubw/claude-code-oauth/releases/tag/v2.1.0
[2.0.0]: https://github.com/hikarubw/claude-code-oauth/releases/tag/v2.0.0
[1.0.0]: https://github.com/hikarubw/claude-code-oauth/releases/tag/v1.0.0