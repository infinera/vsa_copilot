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

Registering Copilot Agents

Quick steps:
- Agent metadata live in `.github/agents/<name>/agent.yml` and point to `.github/agents/<name>/prompt.md` and per-agent snippets/templates.
- Use the GitHub Copilot Agents UI to create a new agent and paste the contents of the agent's `agent.yml` (or upload `prompt.md`).

Helper script:
- Run `./tools/agent-register.sh` to list agents.
- Run `./tools/agent-register.sh <agent>` to print the agent's `agent.yml` for copy/paste.

Verify:
```bash
ls -R .github/agents
./tools/agent-register.sh
python -m json.tool manifest.json | sed -n '1,240p'
```
