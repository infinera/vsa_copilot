# VAE Agent — Canonical Locations

This README documents the canonical file locations the VAE agent uses as grounding.

Canonical locations:
- Top-level templates: `PRD/`, `SRDs/`, `Architecture/`, `APIs/`, `TestPlan/`, `Scopes/`, `ExternalDocs/`, `Wireframes/`.
- Agent-local templates: `.github/agents/vae/templates/` — prefer agent-local templates when present.
- Agent-local snippets: `.github/agents/vae/snippets/`.

Guidance:
- Keep a single canonical copy of a template. Use top-level folders for shared templates and copy into `.github/agents/vae/templates/` only when agent-local grounding is necessary.

References:
- `manifest.json` — lists files included during packaging.
- `.github/agents/vae/prompt.md` — agent grounding and template lookup order.
# VAE — Virtual Agile Engineer

Description: Agent for writing user stories, sprint plans, and agile artifacts.

Usage:
- Run `tools/agent-register.sh vae` to show `agent.yml` for registration.
- Or copy `.github/agents/vae/prompt.md` into the Copilot agent UI.

Files:
- `prompt`: `.github/agents/vae/prompt.md`
- `templates`: `.github/agents/vae/templates/`
- `snippets`: `.github/agents/vae/snippets/vae_snippets.code-snippets`

Notes:
- Run `./tools/validate-agents.js` after editing prompts.
