#!/bin/bash
# cognitive-os Setup Script
# Initializes the cognitive structure in your Cursor workspace

set -e

echo "🧠 cognitive-os Setup"
echo "===================="
echo ""

# Detect if we're in the right directory
if [ ! -f ".cursor/rules/cognitive-l3-auto-log.mdc" ]; then
    echo "❌ Error: Please run this script from the cognitive-os repository root."
    echo "   Expected to find: .cursor/rules/cognitive-l3-auto-log.mdc"
    exit 1
fi

echo "✅ Detected cognitive-os repository"
echo ""

# Check if cognitive/ already exists in target workspace
TARGET_DIR="${1:-$(pwd)}"

if [ "$TARGET_DIR" = "$(pwd)" ]; then
    echo "📁 Setting up in current directory: $(pwd)"
else
    echo "📁 Target workspace: $TARGET_DIR"
    if [ ! -d "$TARGET_DIR" ]; then
        echo "❌ Error: Target directory does not exist: $TARGET_DIR"
        exit 1
    fi
fi

echo ""
echo "This will create the following structure:"
echo "  cognitive/           — Your cognitive structure"
echo "  cognitive/L0_brain_map.md"
echo "  cognitive/L1.5_principles/"
echo "  cognitive/L1_knowledge/"
echo "  cognitive/L2_fragments/"
echo "  cognitive/L3_logs/"
echo "  logs/task_log.md"
echo "  .cursor/ (if not exists)"
echo ""

read -p "Continue? (y/N): " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Setup cancelled."
    exit 0
fi

echo ""
echo "📦 Creating directory structure..."

# Create cognitive structure directories
mkdir -p "$TARGET_DIR/cognitive/L1.5_principles"
mkdir -p "$TARGET_DIR/cognitive/L1_knowledge"
mkdir -p "$TARGET_DIR/cognitive/L2_fragments/reflections"
mkdir -p "$TARGET_DIR/cognitive/L3_logs"
mkdir -p "$TARGET_DIR/logs"

# Copy template files (only if they don't exist)
copy_if_missing() {
    local src="$1"
    local dst="$2"
    if [ ! -f "$dst" ]; then
        cp "$src" "$dst"
        echo "  ✅ Created: $dst"
    else
        echo "  ⏭️  Skipped (exists): $dst"
    fi
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

copy_if_missing "$REPO_ROOT/cognitive/L0_brain_map.md" "$TARGET_DIR/cognitive/L0_brain_map.md"
copy_if_missing "$REPO_ROOT/cognitive/maintenance_protocol.md" "$TARGET_DIR/cognitive/maintenance_protocol.md"
copy_if_missing "$REPO_ROOT/cognitive/document_catalog.md" "$TARGET_DIR/cognitive/document_catalog.md"
copy_if_missing "$REPO_ROOT/cognitive/knowledge_graph.md" "$TARGET_DIR/cognitive/knowledge_graph.md"
copy_if_missing "$REPO_ROOT/cognitive/work_domains.md" "$TARGET_DIR/cognitive/work_domains.md"
copy_if_missing "$REPO_ROOT/cognitive/L1.5_principles/principles.md" "$TARGET_DIR/cognitive/L1.5_principles/principles.md"
copy_if_missing "$REPO_ROOT/cognitive/L1_knowledge/README.md" "$TARGET_DIR/cognitive/L1_knowledge/README.md"
copy_if_missing "$REPO_ROOT/cognitive/L2_fragments/fragment_index.md" "$TARGET_DIR/cognitive/L2_fragments/fragment_index.md"
copy_if_missing "$REPO_ROOT/cognitive/L2_fragments/reflections/reflections.md" "$TARGET_DIR/cognitive/L2_fragments/reflections/reflections.md"
copy_if_missing "$REPO_ROOT/cognitive/L3_logs/system_log.md" "$TARGET_DIR/cognitive/L3_logs/system_log.md"
copy_if_missing "$REPO_ROOT/cognitive/L3_logs/todo.md" "$TARGET_DIR/cognitive/L3_logs/todo.md"
copy_if_missing "$REPO_ROOT/cognitive/L3_logs/consistency_record.md" "$TARGET_DIR/cognitive/L3_logs/consistency_record.md"
copy_if_missing "$REPO_ROOT/logs/task_log.md" "$TARGET_DIR/logs/task_log.md"

echo ""
echo "📋 Setting up .cursor Skills, Agents, and Rules..."

# Create .cursor directories
mkdir -p "$TARGET_DIR/.cursor/skills"
mkdir -p "$TARGET_DIR/.cursor/agents"
mkdir -p "$TARGET_DIR/.cursor/rules"

# Copy Skills
for skill_dir in "$REPO_ROOT/.cursor/skills"/cognitive-*; do
    skill_name=$(basename "$skill_dir")
    mkdir -p "$TARGET_DIR/.cursor/skills/$skill_name"
    copy_if_missing "$skill_dir/SKILL.md" "$TARGET_DIR/.cursor/skills/$skill_name/SKILL.md"
done

# Copy Agents
for agent in "$REPO_ROOT/.cursor/agents"/cognitive-*.md; do
    copy_if_missing "$agent" "$TARGET_DIR/.cursor/agents/$(basename $agent)"
done

# Copy Rules
for rule in "$REPO_ROOT/.cursor/rules"/*.mdc; do
    copy_if_missing "$rule" "$TARGET_DIR/.cursor/rules/$(basename $rule)"
done

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Open $TARGET_DIR in Cursor"
echo "  2. Edit cognitive/work_domains.md to define your work areas"
echo "  3. Say 'Let's set up my cognitive structure' in Cursor chat"
echo "     → The AI will guide you using cognitive-reorganize Skill"
echo "  4. Start capturing thoughts with: 'Record a fragment: [your idea]'"
echo ""
echo "Full documentation: https://github.com/TashanGKD/cognitive-os"
