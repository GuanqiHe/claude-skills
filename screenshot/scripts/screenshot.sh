#!/bin/bash
# Screenshot script - supports full screen, window, and region capture

SCREENSHOT_DIR="${HOME}/.claude/screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Generate timestamped filename
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="screenshot_${TIMESTAMP}.png"
FILEPATH="${SCREENSHOT_DIR}/${FILENAME}"

# Parse arguments
MODE="${1:-full}"  # full, window, region

case "$MODE" in
    full)
        # Full screen capture
        screencapture -x "$FILEPATH"
        ;;
    window)
        # Window capture (interactive selection)
        screencapture -w "$FILEPATH"
        ;;
    region)
        # Region capture (interactive selection)
        screencapture -s "$FILEPATH"
        ;;
    *)
        echo "Unknown mode: $MODE"
        echo "Usage: screenshot.sh [full|window|region]"
        exit 1
        ;;
esac

if [ -f "$FILEPATH" ]; then
    echo "Screenshot saved: $FILEPATH"
    echo "$FILEPATH"
else
    echo "Screenshot failed"
    exit 1
fi
