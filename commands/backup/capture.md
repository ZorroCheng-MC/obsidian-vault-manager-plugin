---
description: Smart capture command with intelligent routing
argument-hint: [content to capture]
allowed-tools:
  - Write(*)
  - Read(*)
  - Bash(date:*)
---

## Context

- **Today's Date:** !`date "+%Y-%m-%d"`
- **User Input:** `$ARGUMENTS`
- **Available Commands:**
  - **Idea Command:** .claude/commands/idea.md
  - **YouTube Command:** .claude/commands/youtube-note.md
  - **GitIngest Command:** .claude/commands/gitingest.md
  - **Study Guide Command:** .claude/commands/study-guide.md

## Your Task

Create a smart capture item that automatically routes to the appropriate Obsidian base using intelligent categorization.

### Mode 1: Idea Capture
When input contains idea-related keywords (idea, concept, thought, insight, brainstorm, inspiration):

**Route to:** .claude/commands/idea.md

### Mode 2: YouTube Capture
When input contains YouTube URLs (youtube.com, youtu.be):

**Route to:** .claude/commands/youtube-note.md

### Mode 3: Repository Analysis
When input contains:
- Git repository URLs (github.com, gitlab.com, bitbucket.org, git@)
- Repository keywords (repo, repository, codebase, git clone, analyze code)
- Local directory paths for code analysis
- Requests for LLM context generation

**Route to:** .claude/commands/gitingest.md

### Mode 4: Study Guide Creation
When input contains:
- Study-related keywords (study, learn, guide, tutorial, course, education)
- Document/content URLs for analysis
- File paths to documents or articles
- Requests for comprehensive learning materials
- Educational content processing

**Route to:** .claude/commands/study-guide.md

### Mode 5: Default Processing
When input doesn't match specific patterns above:
1. Analyze the content type and intent
2. Suggest the most appropriate command
3. If no clear match, process as a general capture with basic structure