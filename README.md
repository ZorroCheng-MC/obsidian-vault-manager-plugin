# Obsidian Vault Manager Plugin

AI-powered knowledge base management for Obsidian with Claude Code.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/v/release/ZorroCheng-MC/obsidian-vault-manager-plugin)](https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin/releases)

## Features

- 📝 **Smart Capture** - Universal content capture for YouTube, GitHub repos, articles, and ideas
- 🏷️ **AI-Powered Tagging** - Automatic taxonomy-based tagging for Obsidian Bases filtering
- 📚 **Study Guides** - Generate comprehensive study guides from any content
- 🔍 **Semantic Search** - Search your vault by meaning, not just keywords
- 🌐 **GitHub Pages Publishing** - One-command publishing with automatic image handling
- 🎯 **Bulk Operations** - Auto-tag existing notes in bulk

## Quick Start (5 Minutes)

### 1. Prerequisites

**Install Obsidian Plugins:**
1. Open Obsidian → Settings → Community Plugins
2. Install and enable:
   - [Local REST API](https://github.com/coddingtonbear/obsidian-local-rest-api) - Configure API key
   - [obsidian-mcp-tools](https://github.com/jacksteamdev/obsidian-mcp-tools) - Click "Install Server"
   - [Smart Connections](https://smartconnections.app/) (optional) - For semantic search

**Install MCP Servers:**
```bash
claude mcp add obsidian-mcp-tools
claude mcp add fetch
claude mcp add gitingest
```

**Install System Tools:**
```bash
# macOS
brew install uv jq git

# Linux
sudo apt install jq git
pip install uv
```

### 2. Install Plugin

```bash
claude plugin add obsidian-vault-manager
```

### 3. Navigate to Your Vault

```bash
cd /path/to/your/ObsidianVault
```

**Important:** You must run Claude Code from your vault directory!

### 4. Start Claude Code

```bash
claude
```

### 5. Run Setup

```
/setup
```

The setup wizard will:
- ✅ Detect your vault path automatically
- ✅ Check for required dependencies
- ✅ Configure GitHub Pages (optional)
- ✅ Create vault-specific configuration
- ✅ Test your setup

### 6. Start Using

```
/capture https://youtube.com/watch?v=abc123
/publish my-article.md
```

## Available Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/setup` | Interactive setup wizard | `/setup` |
| `/capture` | Universal content capture | `/capture https://youtube.com/watch?v=...` |
| `/publish` | Publish to GitHub Pages | `/publish my-note.md` |
| `/idea` | Quick idea capture | `/idea Use AI to categorize notes` |
| `/youtube-note` | YouTube video notes | `/youtube-note https://youtu.be/...` |
| `/study-guide` | Generate study guide | `/study-guide https://article-url.com` |
| `/semantic-search` | Semantic vault search | `/semantic-search AI productivity` |
| `/bulk-auto-tag` | Bulk tag existing notes | `/bulk-auto-tag` |

## Usage Examples

### Capture YouTube Video

```
/capture https://youtube.com/watch?v=abc123
```

Creates a comprehensive video note with:
- Transcript
- Learning objectives
- Structured curriculum
- Key takeaways
- AI-powered tags

### Capture GitHub Repository

```
/capture https://github.com/anthropics/claude-code
```

Creates repository analysis with:
- Architecture overview
- Key files and components
- Documentation summary
- Technical insights

### Quick Idea

```
/idea Use Claude to auto-generate study guides from any content
```

Creates idea note with:
- Smart filename
- AI-powered tags
- Related concepts
- Next steps

### Publish to GitHub Pages

```
/publish 2025-10-30-machine-learning-guide.md
```

Automatically:
- Copies referenced images
- Converts image paths
- Commits and pushes to GitHub
- Provides published URL

## Configuration

### Vault-Specific Settings

After running `/setup`, your vault will have:

```
your-vault/
└── .claude/
    ├── settings.local.json    # Claude Code configuration
    ├── config.sh              # Bash script configuration
    └── .gitignore             # Prevents committing personal paths
```

**settings.local.json:**
```json
{
  "env": {
    "OBSIDIAN_VAULT_PATH": "/path/to/vault",
    "GITHUB_PAGES_PATH": "/path/to/github-pages",
    "GITHUB_PAGES_URL": "https://you.github.io/repo",
    "GITHUB_PAGES_REPO_NAME": "repo"
  }
}
```

### Manual Configuration

If you prefer manual setup:

1. Copy template:
```bash
cp examples/.claude/settings.local.json.template .claude/settings.local.json
```

2. Edit paths:
```bash
vim .claude/settings.local.json
```

3. Restart Claude Code

## Tag Taxonomy

All content is automatically tagged using a predefined taxonomy:

**Content Types:** idea, video, article, study-guide, repository, reference, project

**Topics:** AI, productivity, knowledge-management, development, learning, research, writing, tools, business, design, automation, data-science, web-development, personal-growth, finance

**Status:** inbox, processing, evergreen, published, archived, needs-review

**Metadata:** high-priority, quick-read, deep-dive, technical, conceptual, actionable, tutorial, inspiration

This enables powerful Obsidian Bases filtering:
```
type = video AND tags contains "AI" AND status = inbox
tags contains "actionable" AND tags contains "high-priority"
```

## GitHub Pages Publishing

### Setup

1. Create GitHub Pages repository:
```bash
gh repo create my-knowledge-base --public
```

2. Enable GitHub Pages in repo settings

3. Run `/setup` and provide:
   - Repo path: `~/Dev/my-knowledge-base`
   - Pages URL: `https://you.github.io/my-knowledge-base`

### Publishing

```
/publish my-article.md
```

Automatically handles:
- Image copying from vault to repo
- Path conversion (`./images/` → `/repo-name/images/`)
- Git commit with proper message
- Push to GitHub
- Deployment verification

## Troubleshooting

### "Plugin not found"

```bash
# Install plugin
claude plugin add obsidian-vault-manager

# Verify installation
ls ~/.claude/plugins/marketplaces/
```

### "Not in vault directory"

```bash
# Check current directory
pwd

# Look for .obsidian folder
ls -la | grep obsidian

# Navigate to vault
cd /path/to/ObsidianVault
```

### "Missing dependencies"

```bash
# Check what's missing
which uv jq git python3

# Install on macOS
brew install uv jq git

# Install on Linux
sudo apt install jq git
pip install uv
```

### "MCP server not responding"

1. Check Obsidian Local REST API is running
2. Verify obsidian-mcp-tools is installed
3. Restart Obsidian
4. Re-run `/setup`

## Architecture

```
Plugin Installation (Global):
~/.claude/plugins/marketplaces/obsidian-vault-manager-plugin/
├── obsidian-vault-manager/    # The skill
│   ├── SKILL.md
│   ├── scripts/
│   │   ├── core/
│   │   │   ├── publish.sh
│   │   │   └── fetch-youtube-transcript.sh
│   │   └── setup.sh
│   └── templates/
├── commands/                   # Slash commands
│   ├── setup.md
│   ├── capture.md
│   └── publish.md
└── scripts/
    └── setup.sh

Vault Configuration (Project-Specific):
/path/to/vault/.claude/
├── settings.local.json         # Vault-specific config
├── config.sh                   # For bash scripts
└── .gitignore                  # Don't commit personal paths
```

## Development

### Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Local Development

```bash
# Clone repo
git clone https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin.git

# Link to Claude plugins
ln -s $(pwd)/obsidian-vault-manager ~/.claude/skills/

# Test in your vault
cd /path/to/vault
claude
/setup
```

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

## License

[MIT License](LICENSE)

## Support

- 🐛 [Report Issues](https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin/issues)
- 💬 [Discussions](https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin/discussions)
- 📖 [Documentation](docs/)

## Credits

Created by [Zorro Cheng](https://github.com/ZorroCheng-MC)

Built with:
- [Claude Code](https://claude.ai/code)
- [Obsidian](https://obsidian.md/)
- [MCP Tools for Obsidian](https://github.com/jacksteamdev/obsidian-mcp-tools)

---

Made with ❤️ for the Obsidian community
