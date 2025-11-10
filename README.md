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

## Requirements (Install These First!)

Before installing this plugin, make sure you have:

### 1. Docker Desktop with MCP Toolkit

**Install Docker Desktop:**
- Download from [docker.com](https://www.docker.com/products/docker-desktop/)
- Install and start Docker Desktop

**Connect Claude Code to MCP Toolkit:**
1. Open **Docker Desktop**
2. Go to **MCP Toolkit** (in left sidebar)
3. Click **Clients** tab
4. Find **Claude Code** → Click **Disconnect** (if already connected) then reconnect
5. This gives Claude Code access to all MCP Docker servers

**What you get:** GitHub Official, YouTube Transcripts, Firecrawl, Obsidian, Context7, Fetch, Memory, and Perplexity tools!

### 2. Obsidian MCP Tools Plugin

**Install in Obsidian:**
1. Open **Obsidian** → Settings → Community Plugins
2. Browse and search for **"MCP Tools"**
3. Install and enable
4. Click **"Install Server"** button in the plugin settings

### 3. System Tools

**Required for publishing feature:**
```bash
# macOS
brew install git jq

# Linux
sudo apt install git jq
```

---

## Installation

Now that you have the requirements, install the plugin:

```bash
# Install from Claude Code marketplace
claude plugin add obsidian-vault-manager
```

---

## Quick Start

### 1️⃣ Navigate to Your Vault

```bash
# Go to your Obsidian vault directory
cd /Users/yourname/Documents/Obsidian/YourVault

# Start Claude Code
claude
```

### 2️⃣ Run Setup Wizard

```bash
# Inside Claude Code, run:
/setup
```

The setup wizard will:
- ✅ Detect your vault path automatically
- ✅ Check for required dependencies (git, jq)
- ✅ Generate configuration files (.claude/settings.local.json, .claude/config.sh)
- ✅ Validate everything works

### 3️⃣ Start Using Commands!

```bash
# Capture a YouTube video
/capture https://youtube.com/watch?v=abc123

# Analyze a GitHub repository
/gitingest https://github.com/user/repo

# Publish a note to GitHub Pages
/publish my-note.md
```

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

## Detailed Requirements

### Essential Software

- **Claude Code** (version 2.0.36+)
- **Obsidian** (any recent version)
- **Docker Desktop** (for MCP Toolkit)

### MCP Docker Servers (via Docker Desktop MCP Toolkit)

Connect Claude Code to Docker Desktop's MCP Toolkit to get access to:

- ✅ **GitHub Official** (10 tools) - Repository analysis, file reading, commits, PRs
- ✅ **YouTube Transcripts** (3 tools) - Video info, transcripts with timestamps
- ✅ **Firecrawl** (5 tools) - Web scraping, article fetching, crawling
- ✅ **Obsidian** (12 tools) - Vault file operations, search, note management
- ✅ **Context7** (2 tools) - Library documentation lookup
- ✅ **Fetch (Reference)** (1 tool) - General web fetching
- ✅ **Memory (Reference)** (9 tools) - Knowledge graph for note relationships
- ✅ **Perplexity** (3 tools) - AI-powered web search

**How to connect:** Docker Desktop → MCP Toolkit → Clients tab → Connect Claude Code

### Required Obsidian Plugin

**Obsidian MCP Tools** - For vault file operations

Install via: Obsidian → Settings → Community Plugins → Search "MCP Tools" → Install → Enable → Click "Install Server"

### Optional (For Advanced Features)

**For Semantic Search:**
- [Smart Connections](https://smartconnections.app/) - Install via Obsidian Community Plugins

**For Publishing:**
- GitHub account (free)
- GitHub Pages repository configured

### System Tools

Required for the `/publish` command:
```bash
# macOS
brew install git jq

# Linux
sudo apt install git jq
```

The `/setup` wizard will automatically check for these and guide you if missing.

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
