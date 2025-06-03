# Setup OAuth for Claude GitHub Action

Configure Claude Code GitHub Action to use OAuth authentication instead of API keys.

Usage: /user:setup-oauth [options]

Arguments: $ARGUMENTS

## What This Does

1. **Creates or Updates Workflow**
   - Modifies `.github/workflows/claude.yml` to use OAuth
   - Or creates new workflow if it doesn't exist

2. **Sets GitHub Secrets**
   - Reads your Claude credentials automatically
   - Creates repository secrets:
     - `CLAUDE_ACCESS_TOKEN`
     - `CLAUDE_REFRESH_TOKEN`
     - `CLAUDE_EXPIRES_AT`

3. **Platform Support**
   - macOS: Reads from Keychain
   - Linux: Reads from `~/.claude/.credentials.json`

## Options
- `--basic` - Use simpler workflow template
- Default uses advanced template with full features

## Prerequisites Check
I'll verify you have:
- Git repository with GitHub remote
- GitHub CLI (`gh`) authenticated
- `jq` installed
- Claude credentials available

## Example
```
Setting up OAuth authentication...
✓ Created .github/workflows/claude.yml
✓ Set CLAUDE_ACCESS_TOKEN secret
✓ Set CLAUDE_REFRESH_TOKEN secret
✓ Set CLAUDE_EXPIRES_AT secret

OAuth setup complete! 
Push the workflow file to activate:
  git add .github/workflows/claude.yml
  git commit -m "Add Claude OAuth workflow"
  git push
```