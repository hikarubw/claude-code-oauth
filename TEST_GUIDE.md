# Claude OAuth Testing Guide

This guide walks through testing the Claude OAuth integration.

## Prerequisites
- GitHub CLI (`gh`) installed and authenticated
- `jq` installed
- Claude Code logged in (`claude login`)
- claude-oauth tool installed

## Step 1: Create Test Repository

```bash
# Create a new directory for testing
mkdir test-claude-oauth-demo
cd test-claude-oauth-demo

# Initialize git
git init

# Create test files
echo "# Test Repo" > README.md
echo "console.log('Hello World');" > main.js

# Initial commit
git add .
git commit -m "Initial commit"

# Create GitHub repo (private recommended for testing)
gh repo create test-claude-oauth-demo --private --source=. --remote=origin --push
```

## Step 2: Install Claude OAuth Tool

If not already installed:
```bash
curl -fsSL https://raw.githubusercontent.com/hikarubw/claude-code-oauth/main/install.sh | bash
```

## Step 3: Setup OAuth

```bash
# Run setup (choose option 1 for OAuth)
claude-oauth setup

# This will:
# 1. Install the GitHub Action workflow
# 2. Configure OAuth secrets automatically
# 3. Show you the next steps
```

## Step 4: Commit and Push Workflow

```bash
git add .github/workflows/claude.yml
git commit -m "Add Claude OAuth workflow"
git push
```

## Step 5: Create Test Issue

1. Go to your repository on GitHub
2. Create a new issue:
   - Title: "Test Claude Code Integration"
   - Body: 
   ```
   @claude Please add a multiply function to main.js that takes two numbers and returns their product.
   ```

## Step 6: Verify Claude Response

1. Claude should respond within a minute
2. Check the Actions tab to see the workflow running
3. Claude will create a PR with the requested changes

## Test Scenarios

### Basic Code Addition
```
@claude Add a divide function to main.js with error handling for division by zero
```

### Code Review
```
@claude Review main.js and suggest improvements
```

### Bug Fix
```
@claude There's a bug in the add function - it doesn't handle string inputs. Please fix it.
```

### Documentation
```
@claude Add JSDoc comments to all functions in main.js
```

## Troubleshooting

### Claude doesn't respond
1. Check Actions tab for workflow runs
2. Verify secrets are set: `gh secret list`
3. Check if workflow file exists: `ls .github/workflows/claude.yml`

### Authentication errors
1. Ensure `claude login` was successful
2. Check OAuth tokens: `claude-oauth test`
3. Verify GitHub CLI auth: `gh auth status`

### Workflow fails
1. Check the error in Actions tab
2. Common issues:
   - Expired OAuth tokens (run `claude login` again)
   - Missing permissions (check repository settings)
   - Workflow syntax errors (re-run `claude-oauth setup`)

## Cleanup

To remove the test repository:
```bash
# Delete from GitHub
gh repo delete test-claude-oauth-demo --yes

# Remove local directory
cd ..
rm -rf test-claude-oauth-demo
```

To uninstall Claude OAuth from a project:
```bash
claude-oauth uninstall
```