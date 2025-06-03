# Claude Code OAuth

> ⚠️ **Private Repository**: This contains OAuth setup tools for Claude Code GitHub integration.

OAuth configuration and GitHub Action templates for Claude Code projects.

## What This Does

Sets up GitHub OAuth for Claude Code to:
- Read repository contents
- Create/update pull requests
- Manage issues
- Run GitHub Actions

## Installation

```bash
# In your project directory
curl -fsSL https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/install.sh | bash
```

Then in Claude Code:
```bash
/project:setup-oauth
```

## What Gets Installed

```
your-project/
├── .claude/
│   ├── tools/
│   │   └── oauth-setup    # OAuth configuration tool
│   └── commands/
│       └── setup-oauth.md # Command documentation
└── .github/
    └── workflows/
        └── claude.yml     # GitHub Action template
```

## Security Notes

- Credentials are stored in macOS Keychain or Linux secure storage
- Never commit tokens to repository
- GitHub Action uses repository secrets

## Manual Setup Required

After running setup:
1. Go to your repo's Settings → Secrets
2. Add the secrets shown by the tool
3. Enable GitHub Actions

## License

MIT License - Private use only.