# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-30

### Added
- Initial release of Obsidian Vault Manager plugin
- Universal content capture (`/capture`) for YouTube, GitHub, articles, and ideas
- AI-powered auto-tagging using predefined taxonomy
- GitHub Pages publishing with automatic image handling (`/publish`)
- Study guide generation from any content (`/study-guide`)
- Semantic vault search (`/semantic-search`)
- Bulk auto-tagging for existing notes (`/bulk-auto-tag`)
- Interactive setup wizard (`/setup`)
- Comprehensive tag taxonomy for Obsidian Bases filtering
- Project-scoped configuration (vault-specific settings)
- YouTube transcript fetching via uvx
- Repository analysis via gitingest
- Template system for consistent note creation

### Features
- **Smart Capture**: Automatically routes content based on type (YouTube, GitHub, article, idea)
- **Tag Taxonomy**: 7 content types, 15 topics, 6 status tags, 8 metadata tags
- **Publishing**: One-command publish to GitHub Pages with image path conversion
- **Study Guides**: AI-generated learning plans with objectives and assessments
- **Semantic Search**: Search by meaning using Smart Connections
- **Bulk Operations**: Tag multiple notes in one operation

### Scripts
- `scripts/setup.sh` - Interactive setup wizard
- `scripts/core/publish.sh` - GitHub Pages publishing
- `scripts/core/fetch-youtube-transcript.sh` - YouTube transcript fetcher

### Commands
- `/setup` - Interactive configuration
- `/capture` - Universal content capture
- `/publish` - Publish to GitHub Pages
- `/idea` - Quick idea notes
- `/youtube-note` - YouTube video notes
- `/study-guide` - Study guide generation
- `/semantic-search` - Semantic search
- `/bulk-auto-tag` - Bulk tagging

### Documentation
- Comprehensive README with quick start guide
- Setup wizard with dependency checking
- Configuration templates for easy customization
- Troubleshooting section

### Dependencies
- Obsidian Local REST API plugin (required)
- obsidian-mcp-tools plugin (required)
- Smart Connections plugin (optional)
- MCP servers: obsidian-mcp-tools, fetch, gitingest
- System tools: uv, jq, git, python3

## [Unreleased]

### Planned
- Custom tag taxonomy support
- Template customization UI
- Export/import configuration
- Multi-vault management
- Advanced search filters
- Integration with more MCP servers

---

**Legend:**
- `Added` - New features
- `Changed` - Changes in existing functionality
- `Deprecated` - Soon-to-be removed features
- `Removed` - Removed features
- `Fixed` - Bug fixes
- `Security` - Security improvements
