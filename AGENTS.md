# Agents Guide

This guide explains how to register and manage GitHub Copilot custom agents in this repository.

Quick summary
- Agent profiles: `.github/agents/<agent-name>.md` — required by GitHub for repository-level custom agents. These files contain YAML frontmatter (`name`, `description`) and the agent prompt body.
- Agent assets: `.github/agents/<agent>/templates/`, `.github/agents/<agent>/snippets/`, and `.github/agents/<agent>/examples/` are used to ground agent prompts.

Registering an agent via GitHub UI
1. Open the repository on GitHub.com.
2. Go to the **Agents** tab in the repo (or the Copilot Agents UI where custom agents are configured).
3. Choose **Create new agent** and select the option to upload or paste an agent profile.
4. Open the corresponding `.github/agents/<agent-name>.md` file in this repository and copy the full contents (including YAML frontmatter) into the UI.
5. Save the agent. The agent will now be available in the repo for issues, PRs, and the Copilot UI.

Best practices
- Keep the agent profile and prompt short and focused; use templates under `.github/agents/<agent>/templates/` for long artefacts.
- Use relative file references (e.g., `PRD/PRD-template.md`) inside prompts so the agent can cite repo files.
- Run `./tools/validate-agents.js` and `./tools/validate-snippets.js` before opening a PR to ensure manifest and snippet validity.

Maintainer notes
- `agent.yml` files are kept for internal tooling but the authoritative agent profile for GitHub is the `.github/agents/<agent-name>.md` file.
- `manifest.json` lists files packaged by tooling — update it when adding new agent files.
