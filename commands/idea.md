---
description: Create an idea file with AI-powered smart tagging for Bases filtering
argument-hint: [idea-text] (Your idea or concept to capture)
allowed-tools:
  - Skill(obsidian-vault-manager)
  - Bash(*)
  - mcp__obsidian-mcp-tools__create_vault_file
---

## Task

Execute the `obsidian-vault-manager` skill for idea capture.

**Input**: `$ARGUMENTS` (Plain text idea or concept)
**Operation**: Idea note creation
**Today's Date**: Run `date "+%Y-%m-%d"` to get current date

## Process

The skill will:
1. Analyze idea content and determine main concepts
2. Apply bundled template: `templates/idea-template.md`
3. Analyze content and apply AI-powered smart tagging (using tag taxonomy)
4. Generate smart filename: `{date}-{3-5-word-idea-name}.md`
5. Substitute all template variables with analyzed data
6. Create note in vault using MCP Obsidian tools

## Tag Taxonomy Reference

**Topics:** AI, productivity, knowledge-management, development, learning, research, writing, tools, business, design, automation, data-science, web-development, personal-growth, finance
**Status:** inbox (default for new ideas)
**Metadata:** actionable, conceptual, inspiration, high-priority

## Expected Output

A comprehensive idea note with:
- Proper frontmatter (title, tags, date, type, status, priority)
- Core idea explanation
- Why it matters section
- Related concepts
- Next steps (if actionable)
- Tags analysis and filtering suggestions
- Semantic search suggestions

**File naming format**: `[date]-[3-5-word-idea-name].md`
**Tag count**: 5-8 tags total

## Examples

**Input**: "Use AI to automatically categorize notes"
→ `2025-10-23-ai-note-categorization.md`

**Input**: "Knowledge compounds when connected properly"
→ `2025-10-23-knowledge-compound-connections.md`
