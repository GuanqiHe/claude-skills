---
name: arxiv
description: Download papers from arXiv by ID or search query.
argument-hint: "<arxiv_id> | search <query>"
allowed-tools: Bash, WebSearch, WebFetch, Read, Write
---

# arXiv Paper Downloader

Download papers from arXiv by ID or search query.

## Usage

```
/arxiv <arxiv_id>           # Download by arXiv ID (e.g., 2510.08022)
/arxiv search <query>       # Search and download paper
```

## Instructions

When this skill is invoked:

1. **If an arXiv ID is provided** (format: `YYMM.NNNNN` or `YYMM.NNNNNvN`):
   - Download the PDF using: `curl -L -o <output_path> "https://arxiv.org/pdf/<arxiv_id>.pdf"`
   - Default output path: `paper-reading/<arxiv_id>.pdf`
   - Fetch paper metadata from arXiv to get the title
   - If title is found, rename file to a readable name

2. **If "search" is specified with a query**:
   - Use WebSearch to find the paper on arXiv
   - Present the found paper(s) to the user
   - Ask which one to download
   - Download the selected paper

3. **After downloading**:
   - Verify the PDF is valid using `file` command
   - Report the file size and page count if possible
   - Optionally create a notes template in `paper-reading/` directory

## Examples

```
/arxiv 2510.08022
# Downloads https://arxiv.org/pdf/2510.08022.pdf to paper-reading/

/arxiv search FastUMI robot manipulation
# Searches for the paper, then downloads it

/arxiv 2409.19499 --notes
# Downloads and creates a notes template
```

## Output Directory

Papers are saved to: `paper-reading/`

Create this directory in your project if it doesn't exist.
