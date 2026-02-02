# Claude Code Skills

A collection of custom skills for [Claude Code](https://claude.ai/code).

## Skills

### screenshot

macOS screen capture utility with three modes:
- `full` - Capture entire screen
- `window` - Interactive window selection
- `region` - Interactive region selection

**Usage:**
```
/screenshot          # Full screen capture
/screenshot window   # Capture specific window
/screenshot region   # Capture selected region
```

### arxiv

Download papers from arXiv by ID or search query.

**Usage:**
```
/arxiv 2510.08022              # Download by arXiv ID
/arxiv search diffusion policy # Search and download
```

## Installation

Copy the desired skill folder to your Claude Code skills directory:

```bash
# Global installation (available in all projects)
cp -r screenshot ~/.claude/skills/
cp -r arxiv ~/.claude/skills/

# Project-specific installation
cp -r screenshot .claude/skills/
cp -r arxiv .claude/skills/
```

## Permissions

### screenshot
Requires macOS Screen Recording permission:
**System Settings > Privacy & Security > Screen Recording**

## License

MIT
