# Obsidian Vault Manager for Claude Code

> **AI-powered knowledge management plugin for Obsidian vaults using Claude Code**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/v/release/ZorroCheng-MC/obsidian-vault-manager-plugin)](https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin/releases)
[![GitHub Actions](https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin/workflows/Release/badge.svg)](https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin/actions)

## What This Plugin Does

This plugin supercharges your Obsidian vault with AI-powered automation through Claude Code:

- 📝 **Universal Content Capture** - Save YouTube videos, GitHub repos, web articles, and quick ideas with a single command
- 🏷️ **AI Auto-Tagging** - Automatically categorize notes using smart tags (no manual tagging needed)
- 📚 **Study Guide Generation** - Turn any content into structured learning materials
- 🔍 **Semantic Search** - Find notes by meaning, not just keywords
- 🌐 **GitHub Pages Publishing** - Publish notes to the web with password protection
- 🎯 **Smart Templates** - Pre-built templates for videos, articles, ideas, and repositories

**[See Full Feature List & Examples →](PLUGIN_FEATURES.md)**

---

## Quick Start (3 Steps)

### 1️⃣ Install Required MCP Server & Obsidian Plugin

**Install MCP Docker** (provides GitHub, YouTube, Firecrawl, and more):
```bash
claude mcp add docker
```

**Install Obsidian MCP Tools Plugin:**
1. Open **Obsidian** → Settings → Community Plugins
2. Search for **"MCP Tools"**
3. Install and enable
4. Click **"Install Server"** button in plugin settings

### 2️⃣ Install Claude Code Plugin

```bash
# Install from Claude Code marketplace
claude plugin add obsidian-vault-manager
```

### 3️⃣ Run Setup in Your Vault

```bash
# Go to your vault directory
cd /Users/yourname/Documents/Obsidian/YourVault

# Start Claude Code
claude

# Run setup wizard
/setup
```

The setup wizard will:
- ✅ Detect your vault path automatically
- ✅ Check for required dependencies (git, jq)
- ✅ Generate configuration files
- ✅ Validate everything works

**That's it!** You're ready to use the plugin.

---

## Basic Usage

### Capture Content

**Capture anything with one command:**

```bash
# YouTube video
/capture https://youtube.com/watch?v=abc123

# GitHub repository
/capture https://github.com/user/repo

# Web article
/capture https://medium.com/article-url

# Quick idea
/capture Use AI to automatically organize my notes
```

The plugin will:
1. Analyze the content type
2. Fetch the content (transcript, code, article text)
3. Generate a formatted note with frontmatter
4. Apply AI-powered tags automatically
5. Save to your vault

### Publish to Web

```bash
# Publish a note to GitHub Pages
/publish my-article.md

# Publish with password protection
# (Just add "access: private" to frontmatter)
```

### Generate Study Guides

```bash
# Create a study guide from a note
/study-guide my-note.md

# Or from a URL
/study-guide https://example.com/article
```

### Semantic Search

```bash
# Find notes by meaning
/semantic-search "notes about productivity workflows"
```

**[See More Examples & Commands →](PLUGIN_FEATURES.md)**

---

## How It Works

This plugin adds **slash commands** to Claude Code that work inside your Obsidian vault:

```
Your Vault/
├── .claude/
│   ├── settings.local.json  ← Plugin configuration (auto-generated)
│   └── config.sh            ← Script settings (auto-generated)
└── your-notes.md
```

When you run `/capture` or other commands, Claude Code:
1. Uses AI to understand the content
2. Fetches data (transcripts, code, articles)
3. Applies smart templates
4. Tags automatically using predefined taxonomy
5. Saves to your vault in markdown format

**No manual work needed** - just run the command and get organized notes!

---

## Requirements

### Essential Requirements

- **Claude Code** (version 2.0.36+)
- **Obsidian** (any recent version)

### Required MCP Server

**MCP Docker** - The ONLY MCP server you need:

```bash
claude mcp add docker
```

This single MCP server provides all the tools this plugin uses:
- ✅ GitHub tools (repository analysis, file reading, commits)
- ✅ YouTube tools (video info, transcripts)
- ✅ Firecrawl (web scraping and article fetching)
- ✅ Memory/knowledge graph
- ✅ Obsidian integration
- ✅ Perplexity AI search
- ✅ And more...

**No other MCP servers needed!**

### Required Obsidian Plugin

**Obsidian MCP Tools** (for vault operations):

1. Open Obsidian → Settings → Community Plugins
2. Search for **"MCP Tools"**
3. Install and enable
4. Click **"Install Server"** button in plugin settings

### Optional (For Advanced Features)

**For Semantic Search:**
- [Smart Connections](https://smartconnections.app/) - Install via Obsidian Community Plugins

**For Publishing:**
- GitHub account (free)
- GitHub Pages repository configured

**For Local REST API (Alternative to MCP Tools):**
- [Local REST API](https://github.com/coddingtonbear/obsidian-local-rest-api) - Configure API key

### System Tools (Auto-checked by Setup Wizard)

The `/setup` wizard will check for:
- `git` (for publishing)
- `jq` (for JSON processing)
- `bash` (pre-installed on macOS/Linux)

**Install if missing:**
```bash
# macOS
brew install git jq

# Linux
sudo apt install git jq
```

---

## Advanced Features (Optional)

This plugin also serves as a **reference implementation** for Claude Code plugin development:

- ✅ Automated releases via GitHub Actions
- ✅ Configuration pattern for portability
- ✅ Interactive setup wizards
- ✅ Conversational development with Claude

**For plugin developers:** See [DEVELOPER.md](DEVELOPER.md) for the full technical guide.

## Installation & Usage

### For End Users (Just Want to Use the Plugin)

```bash
# 1. Install
claude plugin add obsidian-vault-manager

# 2. Go to your vault
cd /path/to/vault

# 3. Start Claude and run setup
claude
/setup

# 4. Start using commands!
/capture https://youtube.com/watch?v=abc123
```

**[Full User Guide with Examples →](PLUGIN_FEATURES.md)**

### For Developers (Want to Build Your Own Plugin)

This repository is also a **template for building Claude Code plugins**. See [DEVELOPER.md](DEVELOPER.md) for:

- How to use this as a template
- Automated release workflow with GitHub Actions
- Configuration patterns and best practices
- Conversational development approach

---

## Available Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/setup` | Interactive setup wizard | `/setup` |
| `/capture` | Save content (YouTube, GitHub, articles, ideas) | `/capture https://youtube.com/watch?v=abc` |
| `/publish` | Publish note to GitHub Pages | `/publish my-note.md` |
| `/study-guide` | Generate study guide from content | `/study-guide my-note.md` |
| `/semantic-search` | Find notes by meaning | `/semantic-search "productivity tips"` |
| `/youtube-note` | Capture YouTube video with transcript | `/youtube-note https://youtube.com/watch?v=abc` |
| `/idea` | Quick idea capture | `/idea Use AI to organize notes` |
| `/gitingest` | Analyze GitHub repository | `/gitingest https://github.com/user/repo` |

**[See detailed command documentation →](PLUGIN_FEATURES.md)**

---

## Troubleshooting

### Plugin not found
```bash
# Make sure you're using Claude Code 2.0+
claude --version

# Try reinstalling
claude plugin remove obsidian-vault-manager
claude plugin add obsidian-vault-manager
```

### Commands not working
```bash
# Run setup wizard again
cd /path/to/vault
claude
/setup
```

### Need help?
- [Open an issue](https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin/issues)
- [Check full documentation](PLUGIN_FEATURES.md)
- [See developer guide](DEVELOPER.md)

---

## Contributing & Support

**Found a bug?** [Open an issue](https://github.com/ZorroCheng-MC/obsidian-vault-manager-plugin/issues)

**Want to contribute?** PRs welcome! See [CONTRIBUTING.md](CONTRIBUTING.md)

**Need help?** Check [PLUGIN_FEATURES.md](PLUGIN_FEATURES.md) for detailed documentation

---

## For Plugin Developers

This repository is also a **reference implementation** for building Claude Code plugins. It demonstrates:

- ✅ Automated releases with GitHub Actions (no manual publishing)
- ✅ Configuration patterns for cross-platform compatibility
- ✅ Interactive setup wizards for great UX
- ✅ Conversational development approach

**Want to build your own plugin?** See [DEVELOPER.md](DEVELOPER.md) for the complete technical guide.

---

## License & Credits

**License:** [MIT License](LICENSE) - Free to use and modify

**Created by:** [Zorro Cheng](https://github.com/ZorroCheng-MC)

**Built with:**
- [Claude Code](https://claude.ai/code) - AI-powered development
- [GitHub Actions](https://github.com/features/actions) - Automated releases
- [MCP (Model Context Protocol)](https://modelcontextprotocol.io/) - Tool integration

---

**⭐ If this plugin helps you, consider starring the repo!**
