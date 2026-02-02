---
name: screenshot
description: Capture screenshots on macOS. Use when you need to see the user's desktop, application interfaces, or perform GUI-related tasks.
argument-hint: "[full|window|region]"
allowed-tools: Bash, Read
---

# Screenshot Skill

Capture and analyze user's screen content.

## Usage

### 1. Capture Screen

Run the screenshot script:

```bash
~/.claude/skills/screenshot/scripts/screenshot.sh $ARGUMENTS
```

Arguments:
- `full` (default) - Capture entire screen
- `window` - Let user select a window to capture
- `region` - Let user select a region to capture

### 2. Read Screenshot

The script outputs the screenshot file path. Use the Read tool to view the image content.

### 3. Analyze and Respond

Based on the screenshot content:
- Describe what you see on the interface
- If the user has a specific task (e.g., fill a form, click a button), provide specific guidance
- If multiple screenshots are needed to complete a task, inform the user to call /screenshot again after the next action

## Notes

- Screenshots are saved to `~/.claude/screenshots/`
- First use on macOS may require Screen Recording permission (System Settings > Privacy & Security > Screen Recording)
- Screenshot files are retained; users can clean them up manually
