#!/usr/bin/env bash
# Simple helper to list agent metadata and show agent.yml for registration
set -euo pipefail

ROOT="$PWD"
AGENTS_DIR="$ROOT/.github/agents"

echo "Available agents:"
ls -1 "$AGENTS_DIR" | sed -e 's/\/agent.yml$//' || true

if [ "$#" -eq 1 ]; then
  AGENT="$1"
  YML="$AGENTS_DIR/$AGENT/agent.yml"
  if [ -f "$YML" ]; then
    echo "---\n# agent.yml for $AGENT ---"
    sed -n '1,240p' "$YML"
  else
    echo "Agent '$AGENT' not found under $AGENTS_DIR" >&2
    exit 2
  fi
else
  echo "To show an agent's metadata: $0 <agent-name>"
fi
