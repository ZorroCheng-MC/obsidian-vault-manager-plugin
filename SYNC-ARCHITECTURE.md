# Plugin Sync Architecture

> **Understanding the mapping between local `.claude` directories and the plugin repository**

This document explains how your working environment (home `~/.claude` and vault `.claude`) maps to the plugin repository, and how to keep them in sync.

---

## 📂 Three-Directory Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  LOCAL WORKING ENVIRONMENT                                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. ~/.claude/skills/obsidian-vault-manager/                    │
│     ├── SKILL.md                   System-wide skill package    │
│     ├── scripts/core/              Shared across all vaults     │
│     ├── scripts/validation/                                     │
│     └── templates/                                              │
│                                                                  │
│  2. /path/to/vault/.claude/commands/                            │
│     ├── capture.md                 Vault-specific commands      │
│     ├── publish.md                 Tested and working           │
│     ├── idea.md                                                 │
│     └── [other commands]                                        │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
                            ↓
                      SYNC SCRIPT
                            ↓
┌─────────────────────────────────────────────────────────────────┐
│  PLUGIN REPOSITORY (GitHub Distribution)                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  obsidian-vault-manager-plugin/                                 │
│  ├── commands/               ← FROM: vault .claude/commands/    │
│  │   ├── capture.md                                             │
│  │   ├── publish.md                                             │
│  │   └── [...]                                                  │
│  │                                                               │
│  └── obsidian-vault-manager/ ← FROM: ~/.claude/skills/          │
│      ├── SKILL.md                                               │
│      ├── scripts/                                               │
│      └── templates/                                             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🗺️ Detailed Mapping

### Part 1: Vault Commands (70% of plugin content)

**Source**: `/Users/zorro/Documents/Obsidian/Claudecode/.claude/commands/`

**Destination**: `obsidian-vault-manager-plugin/commands/`

**What gets synced**:

| Vault .claude/commands/ | → | Plugin commands/ |
|-------------------------|---|------------------|
| `capture.md` | → | `capture.md` |
| `publish.md` | → | `publish.md` |
| `idea.md` | → | `idea.md` |
| `youtube-note.md` | → | `youtube-note.md` |
| `study-guide.md` | → | `study-guide.md` |
| `semantic-search.md` | → | `semantic-search.md` |
| `bulk-auto-tag.md` | → | `bulk-auto-tag.md` |
| `gitingest.md` | → | `gitingest.md` |
| `capture.md.backup` | → | `capture.md.backup` |
| `gitingest.md.backup` | → | `gitingest.md.backup` |
| `backup/*.md` | → | `backup/*.md` |

**Why from vault?**
- These are your actively developed and tested commands
- You edit them in your vault context where you can test immediately
- Vault `.claude/commands/` represents your "production-ready" versions

---

### Part 2: Skill Package (25% of plugin content)

**Source**: `~/.claude/skills/obsidian-vault-manager/`

**Destination**: `obsidian-vault-manager-plugin/obsidian-vault-manager/`

**What gets synced**:

| ~/.claude/skills/obsidian-vault-manager/ | → | Plugin obsidian-vault-manager/ |
|------------------------------------------|---|--------------------------------|
| `SKILL.md` | → | `SKILL.md` |
| `README.md` | → | `README.md` |
| `scripts/core/publish.sh` | → | `scripts/core/publish.sh` |
| `scripts/core/fetch-youtube-transcript.sh` | → | `scripts/core/fetch-youtube-transcript.sh` |
| `scripts/validation/*.py` | → | `scripts/validation/*.py` |
| `scripts/validation/*.sh` | → | `scripts/validation/*.sh` |
| `templates/idea-template.md` | → | `templates/idea-template.md` |
| `templates/youtube-note-template.md` | → | `templates/youtube-note-template.md` |
| `templates/study-guide-template.md` | → | `templates/study-guide-template.md` |

**Why from ~/.claude/skills/?**
- This is the system-wide installation used by all vaults
- Contains the actual execution logic (scripts, templates)
- Represents the "runtime environment"

---

### Part 3: Plugin Infrastructure (5% - Not Synced)

**Manually maintained in plugin repository**:

```
obsidian-vault-manager-plugin/
├── .claude-plugin/marketplace.json    ← Plugin metadata
├── .github/workflows/release.yml      ← Automation
├── examples/.claude/*.template        ← Config templates
├── scripts/sync-from-local.sh         ← This sync script
├── scripts/setup.sh                   ← Setup wizard
├── commands/setup.md                  ← Setup command
├── README.md                          ← User docs
├── DEVELOPER.md                       ← Dev docs
├── CHANGELOG.md                       ← Version history
├── LICENSE                            ← License
└── .gitignore                         ← Git config
```

**These files don't come from ~/.claude or vault .claude** - they're specific to plugin distribution.

---

## 🔄 Sync Workflow

### When to Sync

Run the sync script when you've made changes to:

1. ✅ **Command definitions** in vault `.claude/commands/`
   - Updated capture logic
   - Changed tag taxonomy
   - Fixed command bugs
   - Added new command arguments

2. ✅ **Skill scripts** in `~/.claude/skills/obsidian-vault-manager/`
   - Updated publish.sh
   - Modified YouTube transcript fetching
   - Changed templates
   - Added validation scripts

3. ✅ **SKILL.md configuration** in `~/.claude/skills/`
   - Updated allowed-tools
   - Changed trigger conditions
   - Modified skill description

---

## 📝 Update Procedures

### Scenario 1: You Updated a Command in Vault

**Example**: You edited `/capture` command to add new tag categories

**Steps**:

```bash
# 1. Edit command in vault
cd /Users/zorro/Documents/Obsidian/Claudecode
# Edit .claude/commands/capture.md
# Test the command: /capture <your test content>

# 2. Verify it works correctly in your vault

# 3. Sync to plugin repository
cd obsidian-vault-manager-plugin
./scripts/sync-from-local.sh

# 4. Review changes
git diff commands/capture.md

# 5. Commit and push
git add commands/capture.md
git commit -m "Update /capture: Add new tag categories"
git push origin main
```

---

### Scenario 2: You Updated a Script in ~/.claude/skills/

**Example**: You improved the `publish.sh` script

**Steps**:

```bash
# 1. Edit script in ~/.claude/skills/
nano ~/.claude/skills/obsidian-vault-manager/scripts/core/publish.sh

# 2. Test by running /publish command in your vault
cd /Users/zorro/Documents/Obsidian/Claudecode
claude
/publish test-note.md

# 3. Verify it works correctly

# 4. Sync to plugin repository
cd /Users/zorro/Documents/Obsidian/Claudecode/obsidian-vault-manager-plugin
./scripts/sync-from-local.sh

# 5. Review changes
git diff obsidian-vault-manager/scripts/core/publish.sh

# 6. Commit and push
git add obsidian-vault-manager/scripts/core/publish.sh
git commit -m "Improve publish.sh: Better error handling"
git push origin main
```

---

### Scenario 3: You Updated Both Commands and Scripts

**Example**: You added a new feature that requires both command and script changes

**Steps**:

```bash
# 1. Edit vault command
# Edit /Users/zorro/Documents/Obsidian/Claudecode/.claude/commands/youtube-note.md

# 2. Edit skill script
# Edit ~/.claude/skills/obsidian-vault-manager/scripts/core/fetch-youtube-transcript.sh

# 3. Test the complete feature
cd /Users/zorro/Documents/Obsidian/Claudecode
claude
/youtube-note https://youtube.com/watch?v=test123

# 4. Sync everything
cd obsidian-vault-manager-plugin
./scripts/sync-from-local.sh

# 5. Review all changes
git status
git diff

# 6. Commit all changes together
git add -A
git commit -m "Add chapter timestamps to YouTube notes

- Update /youtube-note command with chapter support
- Enhance fetch-youtube-transcript.sh to extract chapters
- Add chapter template to youtube-note-template.md"
git push origin main
```

---

### Scenario 4: Bulk Update After Major Changes

**Example**: You spent a week improving multiple commands and scripts

**Steps**:

```bash
# 1. After all your changes are tested and working

# 2. Sync everything
cd /Users/zorro/Documents/Obsidian/Claudecode/obsidian-vault-manager-plugin
./scripts/sync-from-local.sh

# 3. Review comprehensive changes
git status
git diff --stat

# 4. Review each file individually
git diff commands/capture.md
git diff commands/bulk-auto-tag.md
git diff obsidian-vault-manager/SKILL.md

# 5. Commit with detailed message
git add -A
git commit -m "Major update: Enhanced taxonomy and MCP integration

Commands:
- Update /capture with expanded tag taxonomy
- Add Claude, Gemini, product, marketing topics
- Fix /bulk-auto-tag reference to /capture

Skill Package:
- Update SKILL.md with allowed-tools configuration
- Add MCP Docker tool references
- Improve publish.sh error handling
- Add validate-mcp-tools.sh for dependency checking"

git push origin main
```

---

## 🎯 Best Practices

### Development Workflow

1. **Develop in Vault**
   - Edit commands in vault `.claude/commands/`
   - Test immediately in your vault context
   - Iterate until working perfectly

2. **Test Thoroughly**
   - Run commands multiple times
   - Test edge cases
   - Verify with different content types

3. **Sync to Plugin**
   - Run `./scripts/sync-from-local.sh`
   - Review changes with `git diff`
   - Commit with descriptive messages

4. **Version Control**
   - Use semantic versioning for releases
   - Update CHANGELOG.md for significant changes
   - Tag releases on GitHub

---

### When NOT to Sync

Don't run the sync script if you're:

- ❌ Experimenting with commands (not yet tested)
- ❌ Testing breaking changes
- ❌ Working on unfinished features
- ❌ Making vault-specific customizations that shouldn't be in the plugin

**Rule of Thumb**: Only sync when your changes are production-ready and should be shared with all plugin users.

---

## 🔍 Verification

After syncing, verify what changed:

```bash
# Check git status
git status

# See statistics
git diff --stat

# Review specific files
git diff commands/capture.md
git diff obsidian-vault-manager/SKILL.md

# See all changes in detail
git diff
```

---

## 🐛 Troubleshooting

### Sync Script Not Finding Source

**Problem**: Script says "Source not found"

**Solution**: Check paths in `sync-from-local.sh`:

```bash
# Edit these variables if your paths differ
VAULT_PATH="/Users/zorro/Documents/Obsidian/Claudecode"
SKILLS_PATH="$HOME/.claude/skills/obsidian-vault-manager"
```

---

### Files Not Syncing

**Problem**: A file exists in vault but didn't sync

**Solution**: Check if it's listed in the sync script's `COMMANDS` array:

```bash
# Edit scripts/sync-from-local.sh
COMMANDS=(
    "capture.md"
    "publish.md"
    # Add your command here
    "your-new-command.md"
)
```

---

### Merge Conflicts

**Problem**: Git shows conflicts after sync

**Solution**: Review and resolve:

```bash
# See conflicting files
git status

# Edit and resolve conflicts
git diff

# After resolving
git add <resolved-files>
git commit -m "Resolve sync conflicts"
```

---

## 📋 Quick Reference

### Common Commands

```bash
# Sync from local environment
cd obsidian-vault-manager-plugin
./scripts/sync-from-local.sh

# Review changes
git status
git diff

# Commit changes
git add -A
git commit -m "Description of changes"
git push origin main

# Check what will be synced (dry run - add this feature if needed)
git diff HEAD -- commands/ obsidian-vault-manager/
```

---

## 🎓 Understanding the Flow

```
┌─────────────────────────────────────────────────────────────────┐
│  YOUR DEVELOPMENT CYCLE                                          │
└─────────────────────────────────────────────────────────────────┘

1. Edit commands in vault .claude/commands/
   ↓
2. Test commands in your vault
   ↓
3. Edit scripts in ~/.claude/skills/ (if needed)
   ↓
4. Test again
   ↓
5. Run sync-from-local.sh
   ↓
6. Review with git diff
   ↓
7. Commit and push to GitHub
   ↓
8. GitHub Actions creates release
   ↓
9. Users can install/update plugin
   ↓
10. Their ~/.claude/skills/ gets updated
```

---

## 📚 Related Documentation

- **README.md** - User installation and usage guide
- **DEVELOPER.md** - Plugin development guide
- **CHANGELOG.md** - Version history and changes
- **SYNC-ARCHITECTURE.md** (this file) - Sync architecture and procedures

---

## ✨ Summary

**Key Points**:

1. **Vault `.claude/commands/`** → **Plugin `commands/`** (70%)
   - Your actively developed commands
   - Test here first

2. **`~/.claude/skills/obsidian-vault-manager/`** → **Plugin `obsidian-vault-manager/`** (25%)
   - System-wide skill package
   - Scripts and templates

3. **Sync workflow**: Develop → Test → Sync → Review → Commit → Push

4. **Best practice**: Only sync production-ready changes

5. **Tool**: `./scripts/sync-from-local.sh` automates the entire process

---

*Last updated: 2025-11-12*
