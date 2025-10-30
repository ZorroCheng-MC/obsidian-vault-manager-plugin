---
description: Smart capture with AI-powered auto-tagging for Bases filtering
argument-hint: [content to capture]
allowed-tools:
  - Skill(obsidian-vault-manager)
  - Bash(*)
  - mcp__fetch__fetch
  - mcp__gitingest__gitingest-analyze
  - mcp__obsidian-mcp-tools__create_vault_file
---

## Task

Execute the `obsidian-vault-manager` skill for universal content capture.

**Input**: `$ARGUMENTS` (YouTube URL, GitHub URL, web article, or plain text)
**Operation**: Intelligent routing with AI-powered tagging

## Process

The skill will:
1. **Analyze content type** from input
   - YouTube URL → Video capture workflow
   - GitHub URL → Repository analysis workflow
   - HTTP/HTTPS URL → Article capture workflow
   - Plain text → Idea capture workflow

2. **Apply AI-powered tagging** from predefined taxonomy
   - Content type tags (video, idea, article, repository)
   - Topic tags (2-4 relevant topics: AI, productivity, development, etc.)
   - Status tags (inbox for new captures)
   - Metadata tags (actionable, technical, tutorial, etc.)

3. **Create properly formatted note** using bundled templates
   - Smart filename generation
   - Comprehensive frontmatter
   - Structured content sections
   - Tag analysis and Bases filtering suggestions

## Content Routing

The skill automatically routes based on input:

**YouTube Videos:**
- Pattern: `youtube.com/watch?v=` or `youtu.be/`
- Fetches transcript and metadata
- Template: `templates/youtube-note-template.md`
- Tags: `[video, {topics}, inbox, {metadata}]`

**GitHub Repositories:**
- Pattern: `github.com/owner/repo`
- Uses gitingest for analysis
- Creates repository overview
- Tags: `[repository, {language}, {topics}, inbox, technical]`

**Web Articles:**
- Pattern: HTTP/HTTPS URLs (not YouTube/GitHub)
- Fetches and summarizes content
- Extracts key takeaways
- Tags: `[article, {topics}, inbox, quick-read]`

**Ideas & Thoughts:**
- Pattern: Plain text without URL
- Template: `templates/idea-template.md`
- Smart filename from content
- Tags: `[idea, {topics}, inbox, {metadata}]`

## Tag Taxonomy

All tags come from the predefined taxonomy in the skill:

### Content Type (1 tag)
video, idea, article, study-guide, repository, reference, project

### Topics (2-4 tags)
AI, productivity, knowledge-management, development, learning, research,
writing, tools, business, design, automation, data-science, web-development,
personal-growth, finance

### Status (1 tag)
inbox, processing, evergreen, published, archived, needs-review

### Metadata (0-2 tags)
high-priority, quick-read, deep-dive, technical, conceptual,
actionable, tutorial, inspiration

## Expected Output

After successful capture:
- ✅ Content analyzed and type detected
- ✅ Smart tags applied (6-8 total)
- ✅ Note created with proper filename
- ✅ Template populated with content
- ✅ Tag analysis section added
- ✅ Bases filtering suggestions included

## Examples

**YouTube video:**
```
/capture https://youtube.com/watch?v=abc123
```
→ Creates video note with transcript, learning objectives, curriculum

**GitHub repo:**
```
/capture https://github.com/anthropics/claude-code
```
→ Creates repository analysis with architecture overview

**Article:**
```
/capture https://medium.com/article-about-ai
```
→ Creates article summary with key takeaways

**Quick idea:**
```
/capture Use AI to automatically categorize notes
```
→ Creates idea note with smart filename and tags

## Integration with Bases

Tags enable powerful Bases filtering:
- `type = video AND tags contains "AI"`
- `tags contains "inbox" AND tags contains "high-priority"`
- `tags contains "actionable" AND status = "processing"`
- `type = repository AND tags contains "development"`
