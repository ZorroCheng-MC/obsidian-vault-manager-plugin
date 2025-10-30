---
description: Fetch YouTube video transcript and create comprehensive material entry with AI-powered smart tagging
argument-hint: [youtube-url-or-video-id] (YouTube URL or video ID to process)
allowed-tools:
  - Skill(obsidian-vault-manager)
  - Bash(*)
  - mcp__obsidian-mcp-tools__create_vault_file
  - mcp__fetch__fetch
---

## Task

Execute the `obsidian-vault-manager` skill for YouTube note capture.

**Input**: `$ARGUMENTS` (YouTube URL or video ID)
**Operation**: YouTube video note creation
**Today's Date**: Run `date "+%Y-%m-%d"` to get current date

## Process

The skill will:
1. Extract video ID from URL/argument
2. Use bundled script: `scripts/core/fetch-youtube-transcript.sh` to fetch transcript
3. Fetch video metadata from YouTube page
4. Apply bundled template: `templates/youtube-note-template.md`
5. Analyze content and apply AI-powered smart tagging (using tag taxonomy)
6. Substitute all template variables with analyzed data
7. Create note in vault using MCP Obsidian tools

## Tag Taxonomy Reference

**Topics:** AI, productivity, knowledge-management, development, learning, research, writing, tools, business, design, automation, data-science, web-development, personal-growth, finance
**Status:** inbox (default for new videos)
**Metadata:** tutorial, deep-dive, quick-read, technical, conceptual, actionable, inspiration

## Expected Output

A comprehensive video note with:
- Proper frontmatter (title, tags, url, cover, date, type, status, priority, duration, channel)
- Clickable YouTube thumbnail
- Description and learning objectives
- Structured curriculum with timestamps
- Key takeaways and insights
- Rating section
- Tags analysis and filtering suggestions
- Related topics

**File naming format**: `[date]-[creator-name]-[descriptive-title].md`
**Tag count**: 6-8 tags total
