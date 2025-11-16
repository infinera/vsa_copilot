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
- This repository includes agent metadata files at `.github/agents/<name>/agent.yml` that point to prompt files under `.github/agents/<name>/prompt.md` and optional snippets.
- To register a custom Copilot coding agent using the GitHub UI:
	1. Open GitHub -> Settings -> Copilot -> Agents (or the Copilot Agents management UI in your organization).
 2. Choose "Create agent" and provide a `display_name` and short `description`.
 3. Paste the contents of `.github/agents/<name>/agent.yml` or upload the corresponding prompt file when prompted. Ensure the `prompt:` path in `agent.yml` points to the correct `.github/agents/<name>/prompt.md` file.
4. Optionally attach snippet files from `snippets/` or reference per-agent templates under `.github/agents/<role>/templates/` used by prompts.

Verification commands (local checks)
- List agent metadata files:
```bash
ls -R .github/agents
```
- Validate `manifest.json` contains the agent entries:
```bash
python -m json.tool manifest.json | sed -n '1,240p'
```

If you want, I can add a small validation script `tools/validate-agents.js` to ensure every `.github/agents/*/agent.yml` references an existing prompt file and is listed in `manifest.json`.
