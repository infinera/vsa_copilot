# vsa_copilot

Lightweight repository for VSA Copilot users: contains role-specific system prompts and workspace snippets to quickly onboard VSA/VTA/VAE/VTE agents.

- Structure
- `.github/agents/` — per-agent folders containing `agent.yml` and `prompt.md` (e.g. `.github/agents/vsa/prompt.md`).
- `snippets/` — copy-ready VS Code snippets for common prompts and templates.
- `manifest.json` — simple manifest describing entries and usage.
- `snippets/` — copy-ready VS Code snippets for common prompts and templates.
- `manifest.json` — simple manifest describing entries and usage.

Usage
1. Copy needed prompt text into Copilot Labs system prompt field.
2. Import snippets into VS Code user or workspace snippets.

Contributions
- Keep prompts concise and include grounding references where applicable.

Agent documentation

Each agent has a short, per-agent README visible under `.github/agents/<role>/README.md`.

Quick view:
```bash
ls -R .github/agents
sed -n '1,120p' .github/agents/vsa/README.md
```
