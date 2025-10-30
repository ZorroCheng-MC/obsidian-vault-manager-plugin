---
description: Efficiently analyze GitHub repositories using GitIngest for AI-friendly text extraction without full cloning
argument-hint: [repository-url] [focus:code|docs|config|all] [max-size-kb:50] [branch] [token] [output-file]
allowed-tools:
  - Bash(gitingest:*)
  - Bash(python3:*)
  - Write(*)
  - Read(*)
---

## Context
- **Today's Date:** !`date "+%Y-%m-%d"`
- **Input:** `$ARGUMENTS`
- **Purpose:** Analyze repositories efficiently using GitIngest for LLM consumption

## Your Task
Use GitIngest to analyze a repository without full cloning, providing smart filtering and focused analysis.

### Parameters
- **Argument 1 (Required):** Repository URL or local path
- **Argument 2 (Optional):** Focus type - `code` (default), `docs`, `config`, or `all`
- **Argument 3 (Optional):** Max file size in KB (default: 50)
- **Argument 4 (Optional):** Branch name
- **Argument 5 (Optional):** GitHub token for private repos
- **Argument 6 (Optional):** Output file path (default: stdout)

### Step 1: Validate GitIngest Installation
```bash
if ! command -v gitingest &> /dev/null; then
    echo "❌ GitIngest not installed. Installing now..."
    pipx install gitingest || pip install gitingest
    if ! command -v gitingest &> /dev/null; then
        echo "❌ Failed to install GitIngest. Please install manually:"
        echo "   pipx install gitingest"
        echo "   # or"
        echo "   pip install gitingest"
        exit 1
    fi
fi
```

### Step 2: Parse Arguments and Set Defaults
```bash
REPO_URL="$1"
FOCUS="${2:-code}"
MAX_SIZE_KB="${3:-50}"
BRANCH="$4"
TOKEN="$5"
OUTPUT_FILE="$6"

if [[ -z "$REPO_URL" ]]; then
    echo "❌ Error: Repository URL is required"
    echo "Usage: gitingest <repo-url> [focus] [max-size-kb] [branch] [token] [output-file]"
    echo "Focus options: code, docs, config, all"
    exit 1
fi

# Convert KB to bytes
MAX_SIZE_BYTES=$((MAX_SIZE_KB * 1024))

echo "🔍 Analyzing repository: $REPO_URL"
echo "📋 Focus: $FOCUS"
echo "📏 Max file size: ${MAX_SIZE_KB}KB"
[[ -n "$BRANCH" ]] && echo "🌿 Branch: $BRANCH"
[[ -n "$TOKEN" ]] && echo "🔐 Using authentication token"
echo ""
```

### Step 3: Build GitIngest Command Based on Focus
```bash
# Base command
CMD="gitingest '$REPO_URL' -s $MAX_SIZE_BYTES"

# Add common exclude patterns (always exclude these)
CMD="$CMD -e 'node_modules/*' -e 'dist/*' -e 'build/*' -e '__pycache__/*'"
CMD="$CMD -e '.git/*' -e '.venv/*' -e 'venv/*' -e '*.log' -e '*.lock'"
CMD="$CMD -e '*.min.js' -e '*.min.css' -e '*.bundle.*' -e '*.map'"
CMD="$CMD -e '.DS_Store' -e 'Thumbs.db' -e '.cache/*' -e 'coverage/*'"

# Add include patterns based on focus
case "$FOCUS" in
    "code")
        CMD="$CMD -i '*.py' -i '*.js' -i '*.ts' -i '*.jsx' -i '*.tsx'"
        CMD="$CMD -i '*.go' -i '*.rs' -i '*.java' -i '*.cpp' -i '*.c' -i '*.h'"
        CMD="$CMD -i '*.cs' -i '*.php' -i '*.rb' -i '*.kt' -i '*.swift'"
        CMD="$CMD -i '*.scala' -i '*.clj' -i '*.hs' -i '*.dart' -i '*.lua'"
        CMD="$CMD -i '*.r' -i '*.m' -i '*.sql' -i '*.sh' -i '*.bash'"
        ;;
    "docs")
        CMD="$CMD -i '*.md' -i '*.txt' -i '*.rst' -i '*.adoc' -i '*.tex'"
        CMD="$CMD -i 'README*' -i 'CHANGELOG*' -i 'LICENSE*' -i 'CONTRIBUTING*'"
        CMD="$CMD -i 'INSTALL*' -i 'USAGE*' -i '*.wiki' -i 'docs/*'"
        ;;
    "config")
        CMD="$CMD -i '*.json' -i '*.yaml' -i '*.yml' -i '*.toml' -i '*.ini'"
        CMD="$CMD -i '*.cfg' -i '*.conf' -i 'Dockerfile' -i 'docker-compose.*'"
        CMD="$CMD -i 'Makefile' -i '*.cmake' -i 'package.json' -i 'requirements.txt'"
        CMD="$CMD -i 'Cargo.toml' -i 'go.mod' -i 'pyproject.toml' -i '.env*'"
        CMD="$CMD -i '*.properties' -i '*.xml' -i '*.plist'"
        ;;
    "all")
        # No include patterns - analyze all files (subject to excludes and size limits)
        ;;
    *)
        echo "❌ Invalid focus '$FOCUS'. Use: code, docs, config, or all"
        exit 1
        ;;
esac

# Add optional parameters
[[ -n "$BRANCH" ]] && CMD="$CMD -b '$BRANCH'"
[[ -n "$TOKEN" ]] && CMD="$CMD -t '$TOKEN'"

# Set output
if [[ -n "$OUTPUT_FILE" ]]; then
    CMD="$CMD -o '$OUTPUT_FILE'"
else
    CMD="$CMD -o -"  # stdout
fi
```

### Step 4: Execute GitIngest Analysis
```bash
echo "🚀 Starting GitIngest analysis..."
echo "Command: gitingest [options...]"
echo ""

# Execute the command
eval "$CMD"
EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
    echo ""
    echo "✅ Analysis completed successfully!"
    [[ -n "$OUTPUT_FILE" ]] && echo "📄 Output saved to: $OUTPUT_FILE"
else
    echo ""
    echo "❌ Analysis failed with exit code: $EXIT_CODE"
    echo ""
    echo "💡 Troubleshooting tips:"
    echo "   • Check if the repository URL is accessible"
    echo "   • For private repos, ensure you have a valid GitHub token"
    echo "   • Verify the branch name if specified"
    echo "   • Try with a larger max file size if files are being skipped"
fi
```

### Step 5: Usage Examples
```bash
# Show usage examples on success
if [[ $EXIT_CODE -eq 0 && -z "$OUTPUT_FILE" ]]; then
    echo ""
    echo "💡 Usage examples:"
    echo "   gitingest https://github.com/owner/repo"
    echo "   gitingest https://github.com/owner/repo docs"
    echo "   gitingest https://github.com/owner/repo code 100"
    echo "   gitingest https://github.com/owner/repo config 50 main"
    echo "   gitingest https://github.com/owner/repo all 50 main token analysis.txt"
fi
```

## Key Features

### Smart Focus Modes
- **code**: Source files (.py, .js, .ts, .go, .rs, etc.)
- **docs**: Documentation (.md, README, LICENSE, etc.)
- **config**: Configuration files (.json, .yaml, Dockerfile, etc.)
- **all**: All files (subject to size limits and common excludes)

### Intelligent Filtering
- Automatically excludes common noise (node_modules, build artifacts, logs)
- Configurable file size limits (default 50KB per file)
- Branch-specific analysis
- Private repository support with tokens

### Efficient Processing
- No full repository cloning
- Streaming output for immediate use
- Memory-efficient for large repositories
- Token-aware content extraction

This enhanced command provides focused, efficient repository analysis perfect for AI-assisted development without the overhead of full cloning.
