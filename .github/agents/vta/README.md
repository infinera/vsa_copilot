# VTA Agent — Canonical Locations

This README documents the canonical file locations the VTA agent uses as grounding.

Canonical locations:
- Top-level templates: `PRD/`, `SRDs/`, `Architecture/`, `APIs/`, `TestPlan/`, `Scopes/`, `ExternalDocs/`, `Wireframes/`.
- Agent-local templates: `.github/agents/vta/templates/` — prefer agent-local templates when present.
- Agent-local snippets: `.github/agents/vta/snippets/`.

Guidance:
- Keep a single canonical copy of a template. Use top-level folders for shared templates and copy into `.github/agents/vta/templates/` only when agent-local grounding is necessary.

References:
- `manifest.json` — lists files included during packaging.
- `.github/agents/vta/prompt.md` — agent grounding and template lookup order.
# VTA — Virtual Test Architect

Description: Agent for producing test plans, harnesses, and verification criteria.

Usage:
- Run `tools/agent-register.sh vta` to show `agent.yml` for registration.
- Or copy `.github/agents/vta/prompt.md` into the Copilot agent UI.

Files:
- `prompt`: `.github/agents/vta/prompt.md`
- `templates`: `.github/agents/vta/templates/`
- `snippets`: `.github/agents/vta/snippets/vta_snippets.code-snippets`

Notes:
- Run `./tools/validate-agents.js` after editing prompts.
