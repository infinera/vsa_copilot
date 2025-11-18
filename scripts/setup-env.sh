#!/usr/bin/env bash
set -euo pipefail

# scripts/setup-env.sh -- create venv and install tools requirements
# Usage: ./scripts/setup-env.sh [--no-activate]

ROOT=$(dirname "$(dirname "$0")")
VENV_DIR="$ROOT/.venv"

echo "Using project root: $ROOT"

if [ ! -x "$(command -v python3)" ]; then
  echo "python3 not found. Please install python3." >&2
  exit 1
fi

python3 -m venv "$VENV_DIR"
echo "Created venv at $VENV_DIR"

# shellcheck disable=SC1090
source "$VENV_DIR/bin/activate"
pip install --upgrade pip
pip install -r "$ROOT/tools/requirements.txt"

echo "Environment ready. To activate run: source $VENV_DIR/bin/activate"
if [ "${1:-}" != "--no-activate" ]; then
  echo "Activating venv in current shell..."
  # activate in current shell if script sourced
fi
