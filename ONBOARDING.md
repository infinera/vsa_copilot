# Onboarding: Using VSA and helpers

This repo is a template for R&D engineers to use the VSA family of agents (VSA, VTA, VAE, VTE). The guide below explains how to register agents, run quick local checks, and includes example prompts for an optical network planning use case.

Quick start
- Register the agent profile(s) from `.github/agents/*.md` into the GitHub Copilot Agents UI (see `AGENTS.md`).
- Use the `tools/agent-register.sh <agent>` helper to print `agent.yml` for tooling or copy/paste into the UI.
- Validate files before committing:

```bash
./tools/validate-agents.js && ./tools/validate-snippets.js
```

Sample workflow (optical network example)
1. Product defines feature: "Add automated wavelength provisioning for new ROADM sites" (PRD-level requirement FR-OPT-001).
2. Use VSA to generate a PRD skeleton and SRD items.
3. Use VTA to produce component architecture and OpenAPI for the provisioning API.
4. Use VAE to generate backlog and stories from the PRD/SRD.
5. Use VTE to generate test plan and test cases.

Example prompts

- VSA (Generate PRD skeleton):

```
Generate a PRD for FR-OPT-001: "Automated wavelength provisioning for new ROADM sites". Use `.github/agents/vsa/templates/PRD.md` and include acceptance criteria and a traceability matrix.
```

- VSA (Create SRD items from FR):

```
Create SRD-FR items for FR-OPT-001 covering APIs, data models, and NFRs. Reference `APIs/openapi.yaml` for API skeleton.
```

- VTA (Architecture + OpenAPI):

```
Produce a component architecture for automated wavelength provisioning; include an OpenAPI skeleton for `/api/v1/provision` and security considerations.
```

- VAE (Backlog generation):

```
Create an epic and a prioritized backlog from FR-OPT-001 with user stories formatted as: "As a [persona], I want to [action], so that [benefit]". Provide story points and DoR/DoD.
```

- VTE (Test Plan):

```
Generate a test plan for FR-OPT-001 including functional test cases for provisioning success/failure, and non-functional tests for p95 provisioning latency < 2s.
```

Tips
- Keep prompts specific and cite the template path you want to use (e.g., `.github/agents/vsa/templates/PRD.md`).
- Run validators after edits and before creating a PR.

If you want, I can add a tiny CLI script that wraps these prompts and posts them to an MCP server or a mock runner for local testing.
