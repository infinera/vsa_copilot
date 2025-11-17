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
