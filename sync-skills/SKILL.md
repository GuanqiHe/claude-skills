---
name: sync-skills
description: Sync local Claude Code skills to remote GitHub repository with sensitive information filtering.
argument-hint: "[--check-only]"
allowed-tools: Bash, Read, Glob, Grep, AskUserQuestion
---

# Sync Skills to GitHub

Push local Claude Code skills to the remote repository after checking for sensitive information.

## Usage

```
/sync-skills              # Check and push skills
/sync-skills --check-only # Only check for sensitive info, don't push
```

## Workflow

When this skill is invoked, follow these steps **in order**:

### Step 1: Locate Skills Repository

```bash
SKILLS_REPO="$HOME/Documents/wuji/claude-skills"
cd "$SKILLS_REPO"
```

### Step 2: Scan for Sensitive Information

**CRITICAL**: Before pushing, you MUST read and analyze ALL files for sensitive information.

Use Glob to find all files:
```bash
find "$SKILLS_REPO" -type f \( -name "*.md" -o -name "*.sh" -o -name "*.py" -o -name "*.json" \) ! -path "*/.git/*"
```

For each file, use Read tool to check content and look for:

#### Sensitive Patterns to Detect

| Category | Patterns | Example |
|----------|----------|---------|
| **Hardcoded usernames** | `/Users/<username>/`, `/home/<username>/` | `/Users/john/` |
| **API Keys** | `sk-`, `api_key=`, `token=`, `ANTHROPIC_API_KEY` | `sk-ant-xxx` |
| **Passwords** | `password=`, `passwd`, `secret=` | `password=123456` |
| **Email addresses** | `*@*.com`, `*@*.cn` | `john@example.com` |
| **Phone numbers** | Regex: `\d{11}`, `\d{3}-\d{4}-\d{4}` | `13812345678` |
| **Private IPs** | `192.168.*`, `10.*`, `172.16-31.*` | `192.168.1.100` |
| **Internal URLs** | Company internal domains | `internal.company.com` |

### Step 3: Report Findings

Present a summary table:

```
## Sensitive Information Scan Results

| File | Issue | Line | Content |
|------|-------|------|---------|
| ... | ... | ... | ... |

Total files scanned: X
Issues found: Y
```

### Step 4: Decision Point

**If issues found:**
- List all issues with file paths and line numbers
- Ask user: "Found X potential sensitive items. How to proceed?"
  - Option A: Show details and let me fix manually
  - Option B: Auto-redact (replace with placeholders like `$HOME`, `<EMAIL>`)
  - Option C: Abort push

**If no issues found:**
- Report: "No sensitive information detected in X files."
- Proceed to push

### Step 5: Push to Remote (if approved)

```bash
cd "$SKILLS_REPO"
git add .
git status
git diff --cached --stat
```

Show the user what will be committed, then:

```bash
git commit -m "Update skills"
git push origin main
```

## Safe Patterns (Ignore These)

These patterns are safe and should NOT be flagged:
- `$HOME` or `~` (environment variables)
- `${HOME}` (shell expansion)
- `<username>` as placeholder text
- Example emails in documentation: `user@example.com`
- Localhost: `127.0.0.1`, `localhost`

## Example Output

```
🔍 Scanning 4 files for sensitive information...

✅ README.md - Clean
✅ screenshot/SKILL.md - Clean
✅ screenshot/scripts/screenshot.sh - Clean
✅ arxiv/SKILL.md - Clean

📊 Scan complete: 4 files checked, 0 issues found.

📤 Ready to push to origin/main
```
