#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
rm -f prompts/vsa_prompt.md prompts/vta_prompt.md prompts/vae_prompt.md prompts/vte_prompt.md prompts/README.md
rmdir --ignore-fail-on-non-empty prompts || true
echo "prompts/ removed (if existed)"
