#!/usr/bin/env bash
# Initialize an agent into a target repository by copying agent profile, prompt, templates, snippets and README.

set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <agent> <target-repo-path> [--git] [--dry-run]
  Example: $0 vsa ../my-project (uses local relative path to target repo)"
  exit 1
fi

AGENT="$1"
TARGET="$2"
DO_GIT=false
DRY_RUN=false
shift 2
for arg in "$@"; do
  case "$arg" in
    --git) DO_GIT=true ;;
    --dry-run) DRY_RUN=true ;;
    *) echo "Unknown option: $arg" ;;
  esac
done

SRC_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENT_DIR="$SRC_ROOT/.github/agents/$AGENT"

if [ ! -d "$AGENT_DIR" ]; then
  echo "Agent '$AGENT' not found under .github/agents/"
  exit 2
fi

echo "Initializing agent '$AGENT' into target: $TARGET"
mkdir -p "$TARGET/.github/agents/$AGENT"
mkdir -p "$TARGET/.github/agents/$AGENT/templates"
mkdir -p "$TARGET/.github/agents/$AGENT/snippets"

copy_if_exists() {
  local src="$1" dst="$2"
  if [ -e "$src" ]; then
    if [ "$DRY_RUN" = true ]; then
      echo "Would copy: $src -> $dst"
    else
      mkdir -p "$(dirname "$dst")"
      cp -a "$src" "$dst"
      echo "Copied: $src -> $dst"
    fi
  fi
}

# Copy main agent profile (.md)
copy_if_exists "$AGENT_DIR.md" "$TARGET/.github/agents/$AGENT.md"

# Copy prompt
copy_if_exists "$AGENT_DIR/prompt.md" "$TARGET/.github/agents/$AGENT/prompt.md"

# Copy agent.yml
copy_if_exists "$AGENT_DIR/agent.yml" "$TARGET/.github/agents/$AGENT/agent.yml"

# Copy README
copy_if_exists "$AGENT_DIR/README.md" "$TARGET/.github/agents/$AGENT/README.md"

# Copy templates
if [ -d "$AGENT_DIR/templates" ]; then
  if [ "$DRY_RUN" = true ]; then
    echo "Would copy templates to $TARGET/.github/agents/$AGENT/templates/"
  else
    mkdir -p "$TARGET/.github/agents/$AGENT/templates"
    cp -a "$AGENT_DIR/templates/"* "$TARGET/.github/agents/$AGENT/templates/" 2>/dev/null || true
    echo "Copied templates to $TARGET/.github/agents/$AGENT/templates/"
  fi
fi

# Copy snippets
if [ -d "$AGENT_DIR/snippets" ]; then
  if [ "$DRY_RUN" = true ]; then
    echo "Would copy snippets to $TARGET/.github/agents/$AGENT/snippets/"
  else
    mkdir -p "$TARGET/.github/agents/$AGENT/snippets"
    cp -a "$AGENT_DIR/snippets/"* "$TARGET/.github/agents/$AGENT/snippets/" 2>/dev/null || true
    echo "Copied snippets to $TARGET/.github/agents/$AGENT/snippets/"
  fi
fi

echo
echo "DONE. Next steps to register the agent in the GitHub UI:"
echo "1) Commit and push the copied files in your target repo:"
echo "   cd $TARGET && git add .github/agents/$AGENT* && git commit -m \"chore: add $AGENT agent files\" && git push"
echo "2) On GitHub.com, open the target repo → Agents tab → Create new agent → Paste the contents of .github/agents/$AGENT.md into the profile field and save."
echo "3) (Optional) Enable any repo-level policies or visibility needed for the agent."

if [ "$DO_GIT" = true ]; then
  if [ "$DRY_RUN" = true ]; then
    echo "Would run git add/commit/push in $TARGET for .github/agents/$AGENT*"
  else
    pushd "$TARGET" >/dev/null
    git add .github/agents/$AGENT* || true
    git commit -m "chore: add $AGENT agent files" || true
    git push || true
    popd >/dev/null
  fi
fi

exit 0
