---
description: Smart capture with AI-powered auto-tagging for Bases filtering
argument-hint: [content to capture]
allowed-tools:
  - Bash(*)
  - Read(*)
  - Write(*)
  - WebFetch
  - mcp__MCP_DOCKER__fetch
  - mcp__MCP_DOCKER__firecrawl_scrape
  - mcp__MCP_DOCKER__firecrawl_map
  - mcp__MCP_DOCKER__firecrawl_search
  - mcp__MCP_DOCKER__get_video_info
  - mcp__MCP_DOCKER__get_transcript
  - mcp__MCP_DOCKER__get_timed_transcript
  - mcp__MCP_DOCKER__obsidian_append_content
  - mcp__MCP_DOCKER__obsidian_get_file_contents
  - mcp__MCP_DOCKER__obsidian_batch_get_file_contents
  - mcp__MCP_DOCKER__obsidian_list_files_in_dir
  - mcp__MCP_DOCKER__obsidian_list_files_in_vault
  - mcp__MCP_DOCKER__obsidian_simple_search
  - mcp__MCP_DOCKER__obsidian_complex_search
  - mcp__MCP_DOCKER__obsidian_patch_content
  - mcp__MCP_DOCKER__obsidian_delete_file
  - mcp__MCP_DOCKER__obsidian_get_periodic_note
  - mcp__MCP_DOCKER__obsidian_get_recent_changes
  - mcp__MCP_DOCKER__obsidian_get_recent_periodic_notes
  - mcp__MCP_DOCKER__get_file_contents
  - mcp__MCP_DOCKER__search_repositories
  - mcp__MCP_DOCKER__search_code
  - mcp__MCP_DOCKER__list_commits
  - mcp__MCP_DOCKER__list_branches
  - mcp__MCP_DOCKER__get_commit
  - mcp__MCP_DOCKER__resolve-library-id
  - mcp__MCP_DOCKER__get-library-docs
  - mcp__MCP_DOCKER__perplexity_ask
  - mcp__MCP_DOCKER__perplexity_research
---

## Task

Capture content to Obsidian vault with AI-powered smart tagging.

**Input**: `$ARGUMENTS`
**Today's Date**: Run `date "+%Y-%m-%d"` to get current date

## Content Routing

Analyze the input and process according to content type. **Check patterns in this exact order**:

| Priority | Content Type | Pattern | Processing |
|----------|--------------|---------|------------|
| 1 | **YouTube** | Domain is `youtube.com` or `youtu.be` | YouTube video note |
| 2 | **GitHub** | Domain is `github.com` | Repository analysis note |
| 3 | **Web Article + Video** | HTTP/HTTPS URL with `?y=` param (non-YouTube domain) | Study guide WITH video transcript |
| 4 | **Web Article** | Other `http://` or `https://` URL | Study guide note |
| 5 | **Plain Text** | No URL pattern | Idea note |

**IMPORTANT**: A URL like `https://example.com/page?y=VIDEO_ID` is a **Web Article + Video** (Priority 3), NOT a YouTube video. The `?y=` param indicates an embedded video to include in the study guide.

---

## YouTube Video Processing

**ONLY for URLs where domain is `youtube.com` or `youtu.be`**:

1. Extract video ID from URL
2. Use `mcp__MCP_DOCKER__get_video_info` for metadata (title, channel, duration)
3. Use `mcp__MCP_DOCKER__get_transcript` for transcript
4. Read template: `cat ~/.claude/skills/obsidian-vault-manager/templates/youtube-note-template.md`
5. Create note with `mcp__MCP_DOCKER__obsidian_append_content` (creates new file)

**Note**: URLs like `https://othersite.com/page?y=VIDEO_ID` are NOT YouTube - use "Web Article + Video" processing instead.

**Filename**: `{date}-{channel-name}-{descriptive-title}-{video_id}.md`
**CRITICAL**: Include video ID in filename to ensure each video gets a separate note file.

**Required sections**:
- Frontmatter with cover, url, channel, video_date, duration
- Clickable YouTube thumbnail
- Description and learning objectives
- Structured curriculum with timestamps
- Key takeaways
- Rating section

---

## Web Article + Video Processing (Priority 3)

**For URLs with `?y=VIDEO_ID` param on NON-YouTube domains** (e.g., `https://agenticengineer.com/page?y=abc123`):

This is a web article with an embedded video. Create a **study guide** that includes BOTH:

1. Fetch article content using `mcp__MCP_DOCKER__firecrawl_scrape` or `WebFetch`
2. Extract video ID from `?y=` parameter
3. Use `mcp__MCP_DOCKER__get_video_info` for video metadata
4. Use `mcp__MCP_DOCKER__get_transcript` for video transcript
5. Create comprehensive study guide combining article + video content:
   - Learning objectives (checkboxed)
   - Key concepts from article AND video
   - Course structure (if applicable)
   - Study strategies
   - Self-assessment questions
   - Progress tracking
6. Create note with `mcp__MCP_DOCKER__obsidian_append_content` (creates new file)

**Filename**: `{date}-{source-name}-{topic}-study-guide.md`
**Type**: `study-guide`
**Status**: `processing`

---

## Web Article / Study Guide Processing (Priority 4)

For other non-YouTube, non-GitHub URLs (no `?y=` param):

1. Fetch content using `WebFetch` or `mcp__MCP_DOCKER__fetch` or `mcp__MCP_DOCKER__firecrawl_scrape`
2. Analyze content and create comprehensive study guide with:
   - Learning objectives (checkboxed)
   - Key concepts breakdown
   - Study strategies
   - Self-assessment questions
   - Progress tracking
3. Create note with `mcp__MCP_DOCKER__obsidian_append_content` (creates new file)

**Filename**: `{date}-{source-name}-{topic}-study-guide.md`
**Status**: `processing` (active study material)

---

## Idea Processing

For plain text (no URL):

1. Analyze the text for main concepts
2. Generate smart tags from taxonomy
3. Create note with sections:
   - Core idea explanation
   - Why it matters
   - Related concepts
   - Next steps (if actionable)
4. Create note with `mcp__MCP_DOCKER__obsidian_append_content` (creates new file)

**Filename**: `{date}-{3-5-word-idea-name}.md`
**Status**: `inbox`

---

## Tag Taxonomy

**Content Types**: video, article, study-guide, idea, repository
**Topics**: AI, Claude, productivity, knowledge-management, development, learning, research, writing, tools, business, design, automation, data-science, web-development, personal-growth, finance, coding, architecture
**Status**: inbox (default), processing (for study guides)
**Metadata**: tutorial, deep-dive, quick-read, technical, conceptual, actionable, inspiration

## Critical Requirements

1. **MUST call `mcp__MCP_DOCKER__obsidian_append_content`** to save the file (creates new file if doesn't exist)
2. Use 6-8 tags total from the taxonomy
3. Include proper frontmatter with all required fields
4. For YouTube: include clickable thumbnail and structured curriculum
5. For articles with embedded videos: capture BOTH article content AND video transcript
