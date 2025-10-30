#!/bin/bash
# Publish Obsidian note to GitHub Pages
# Handles image copying and path conversion
# Usage: ./publish.sh NOTE_FILE

set -e  # Exit on error

NOTE_FILE="$1"

# Try to load configuration from vault's .claude directory
if [[ -f "$PWD/.claude/config.sh" ]]; then
    source "$PWD/.claude/config.sh"
fi

# Use environment variables with sensible defaults
VAULT_PATH="${OBSIDIAN_VAULT_PATH:-$PWD}"
GITHUB_PAGES_PATH="${GITHUB_PAGES_PATH:-$HOME/Dev/github-pages}"
GITHUB_PAGES_URL="${GITHUB_PAGES_URL:-https://user.github.io/repo}"
GITHUB_PAGES_REPO_NAME="${GITHUB_PAGES_REPO_NAME:-repo}"

# Add .md extension if not provided
if [[ ! "$NOTE_FILE" =~ \.md$ ]]; then
    NOTE_FILE="${NOTE_FILE}.md"
fi

# Check if file exists in vault
if [[ ! -f "$VAULT_PATH/$NOTE_FILE" ]]; then
    echo "❌ Error: File not found: $NOTE_FILE"
    echo "Looking in: $VAULT_PATH/"
    exit 1
fi

echo "✅ Found note: $NOTE_FILE"
echo ""

# Extract and copy referenced images
cd "$VAULT_PATH"

# Find all image references (macOS compatible)
IMAGE_PATHS=$(grep -o '!\[[^]]*\]([^)]*\.\(jpg\|jpeg\|png\|gif\|svg\|webp\))' "$NOTE_FILE" | sed 's/.*(\(.*\))/\1/' || true)

if [[ -n "$IMAGE_PATHS" ]]; then
    echo "📸 Found images to copy:"
    echo "$IMAGE_PATHS"
    echo ""

    # Copy each image to GitHub Pages repo
    while IFS= read -r IMG_PATH; do
        # Skip if empty or URL (http/https)
        if [[ -z "$IMG_PATH" ]] || [[ "$IMG_PATH" =~ ^https?:// ]]; then
            continue
        fi

        # Normalize path (remove leading ./)
        CLEAN_PATH="${IMG_PATH#./}"

        # Source path in vault
        SRC="$VAULT_PATH/$CLEAN_PATH"

        # Destination path in GitHub Pages repo (preserve directory structure)
        DEST="$GITHUB_PAGES_PATH/$CLEAN_PATH"
        DEST_DIR=$(dirname "$DEST")

        if [[ -f "$SRC" ]]; then
            # Create destination directory if needed
            mkdir -p "$DEST_DIR"

            # Copy image
            cp "$SRC" "$DEST"
            echo "  ✅ Copied: $CLEAN_PATH"
        else
            echo "  ⚠️  Not found: $SRC"
        fi
    done <<< "$IMAGE_PATHS"
    echo ""
else
    echo "ℹ️  No local images found in note"
    echo ""
fi

# Read note content
NOTE_CONTENT=$(cat "$NOTE_FILE")

# Convert image paths for GitHub Pages using Python for reliable regex
# ./images/file.jpg → /repo-name/images/file.jpg
# images/file.jpg → /repo-name/images/file.jpg
CONVERTED_CONTENT=$(echo "$NOTE_CONTENT" | python3 -c "
import sys, re
import os

content = sys.stdin.read()
repo_name = os.environ.get('GITHUB_PAGES_REPO_NAME', 'repo')

# Pattern 1: ./path/to/image.ext -> /repo-name/path/to/image.ext
content = re.sub(r'!\[([^\]]*)\]\(\./([^)]+\.(jpg|jpeg|png|gif|svg|webp))\)', rf'![\1](/{repo_name}/\2)', content, flags=re.IGNORECASE)

# Pattern 2: path/to/image.ext (no leading ./) -> /repo-name/path/to/image.ext
# But skip URLs (http:// or https://)
content = re.sub(r'!\[([^\]]*)\]\((?!https?://|/)([^)]+\.(jpg|jpeg|png|gif|svg|webp))\)', rf'![\1](/{repo_name}/\2)', content, flags=re.IGNORECASE)

print(content, end='')
")

echo "📝 Image path conversion complete"
echo ""

# Write converted content to GitHub Pages repo
DEST_NOTE="$GITHUB_PAGES_PATH/documents/$NOTE_FILE"
echo "$CONVERTED_CONTENT" > "$DEST_NOTE"

echo "✅ Copied note to: documents/$NOTE_FILE"
echo ""

# Git operations
cd "$GITHUB_PAGES_PATH"

echo "📋 Git status:"
git status --short
echo ""

# Add all changes (document + images)
git add "documents/$NOTE_FILE"
git add images/ 2>/dev/null || true

# Get note title from frontmatter for commit message
NOTE_TITLE=$(grep -m1 '^title:' "documents/$NOTE_FILE" | sed 's/title: *["'"'"']*//;s/["'"'"']*$//' || echo "$NOTE_FILE")

# Commit
git commit -m "Publish: $NOTE_TITLE

- Published documents/$NOTE_FILE
- Copied associated images
- Converted image paths for GitHub Pages

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

# Push to GitHub
echo "🚀 Pushing to GitHub..."
git push origin main

echo ""
echo "✅ Published successfully!"
echo ""
echo "📄 Document: ${GITHUB_PAGES_URL}/documents/${NOTE_FILE%.md}.html"
echo "⏱️  GitHub Pages will deploy in ~60 seconds"
echo ""

exit 0
