# VSA Agent — Canonical Locations

This README documents the canonical file locations the VSA agent uses as grounding.

Canonical locations:
- Top-level templates: `PRD/`, `SRDs/`, `Architecture/`, `APIs/`, `TestPlan/`, `Scopes/`, `ExternalDocs/`, `Wireframes/`.
- Agent-local templates: `.github/agents/vsa/templates/` — prefer agent-local templates when present.
- Agent-local snippets: `.github/agents/vsa/snippets/`.

Guidance:
- Keep a single canonical copy of a template. Use top-level folders for shared templates and copy into `.github/agents/vsa/templates/` only when agent-local grounding is necessary.
- OpenAPI template filename should be `openapi-template.yaml` across the repo.

References:
- `manifest.json` — lists files included during packaging.
- `.github/agents/vsa/prompt.md` — agent grounding and template lookup order.
# VSA — Virtual System Architect

Description: Lightweight agent that helps design system-level features and PRDs.

Usage:
- Use `tools/agent-register.sh vsa` to print `agent.yml` for copy/paste into the Copilot Agents UI.
- Or open `.github/agents/vsa/prompt.md` and copy the prompt into the UI.

Files:
- `prompt`: `.github/agents/vsa/prompt.md`
- `templates`: `.github/agents/vsa/templates/`
- `snippets`: `.github/agents/vsa/snippets/vsa_snippets.code-snippets`

Notes:
- Keep prompts concise. Run `./tools/validate-agents.js` before pushing changes.
