#!/bin/bash
# Sync plugin components from local working environment
# This script updates the plugin folder with the latest versions from:
#   - Vault .claude/commands/ (70%)
#   - ~/.claude/skills/obsidian-vault-manager/ (25%)

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source locations
VAULT_PATH="/Users/zorro/Documents/Obsidian/Claudecode"
SKILLS_PATH="$HOME/.claude/skills/obsidian-vault-manager"

echo -e "${BLUE}=== Syncing Plugin Components ===${NC}"
echo "Plugin root: $PLUGIN_ROOT"
echo "Vault path: $VAULT_PATH"
echo "Skills path: $SKILLS_PATH"
echo ""

# Check if source directories exist
if [ ! -d "$VAULT_PATH/.claude/commands" ]; then
    echo -e "${YELLOW}Warning: Vault .claude/commands not found at $VAULT_PATH/.claude/commands${NC}"
    exit 1
fi

if [ ! -d "$SKILLS_PATH" ]; then
    echo -e "${YELLOW}Warning: Skills directory not found at $SKILLS_PATH${NC}"
    exit 1
fi

# Function to sync files
sync_file() {
    local src="$1"
    local dest="$2"

    if [ -f "$src" ]; then
        # Create destination directory if needed
        mkdir -p "$(dirname "$dest")"

        # Copy file
        cp "$src" "$dest"
        echo -e "  ${GREEN}✓${NC} $(basename "$dest")"
    else
        echo -e "  ${YELLOW}⚠${NC} Source not found: $src"
    fi
}

# Function to sync directory
sync_directory() {
    local src="$1"
    local dest="$2"

    if [ -d "$src" ]; then
        # Create destination directory
        mkdir -p "$dest"

        # Copy all files
        rsync -av --delete "$src/" "$dest/"
        echo -e "  ${GREEN}✓${NC} $(basename "$dest")/ (directory)"
    else
        echo -e "  ${YELLOW}⚠${NC} Source directory not found: $src"
    fi
}

# ===========================
# PART 1: Sync Commands (70%)
# ===========================
echo -e "${BLUE}[1/2] Syncing commands from vault .claude/commands/${NC}"

# Main command files
COMMANDS=(
    "capture.md"
    "publish.md"
    "idea.md"
    "youtube-note.md"
    "study-guide.md"
    "semantic-search.md"
    "bulk-auto-tag.md"
    "gitingest.md"
)

for cmd in "${COMMANDS[@]}"; do
    sync_file "$VAULT_PATH/.claude/commands/$cmd" "$PLUGIN_ROOT/commands/$cmd"
done

# Backup files
if [ -f "$VAULT_PATH/.claude/commands/capture.md.backup" ]; then
    sync_file "$VAULT_PATH/.claude/commands/capture.md.backup" "$PLUGIN_ROOT/commands/capture.md.backup"
fi

if [ -f "$VAULT_PATH/.claude/commands/gitingest.md.backup" ]; then
    sync_file "$VAULT_PATH/.claude/commands/gitingest.md.backup" "$PLUGIN_ROOT/commands/gitingest.md.backup"
fi

# Backup directory
if [ -d "$VAULT_PATH/.claude/commands/backup" ]; then
    echo -e "  Syncing backup directory..."
    sync_directory "$VAULT_PATH/.claude/commands/backup" "$PLUGIN_ROOT/commands/backup"
fi

echo ""

# ===============================
# PART 2: Sync Skill Package (25%)
# ===============================
echo -e "${BLUE}[2/2] Syncing skill package from ~/.claude/skills/obsidian-vault-manager/${NC}"

# SKILL.md and README.md
sync_file "$SKILLS_PATH/SKILL.md" "$PLUGIN_ROOT/obsidian-vault-manager/SKILL.md"
sync_file "$SKILLS_PATH/README.md" "$PLUGIN_ROOT/obsidian-vault-manager/README.md"

# Scripts directory
echo -e "  Syncing scripts/core/..."
sync_directory "$SKILLS_PATH/scripts/core" "$PLUGIN_ROOT/obsidian-vault-manager/scripts/core"

echo -e "  Syncing scripts/validation/..."
sync_directory "$SKILLS_PATH/scripts/validation" "$PLUGIN_ROOT/obsidian-vault-manager/scripts/validation"

# Templates directory
echo -e "  Syncing templates/..."
sync_directory "$SKILLS_PATH/templates" "$PLUGIN_ROOT/obsidian-vault-manager/templates"

echo ""

# ===============================
# Summary
# ===============================
echo -e "${GREEN}=== Sync Complete! ===${NC}"
echo ""
echo "Updated components:"
echo "  ✅ Commands (from vault .claude/commands/)"
echo "  ✅ Skill package (from ~/.claude/skills/obsidian-vault-manager/)"
echo ""
echo "Next steps:"
echo "  1. Review changes: cd $PLUGIN_ROOT && git diff"
echo "  2. Test commands work correctly"
echo "  3. Commit changes: git add -A && git commit -m 'Sync from local environment'"
echo "  4. Push to GitHub: git push origin main"
