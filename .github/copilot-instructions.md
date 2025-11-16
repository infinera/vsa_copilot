<!-- Copilot instructions for vsa_copilot workspace -->
# vsa_copilot — Copilot agent instructions

Purpose: give AI coding agents the minimal, actionable orientation so they can be productive in this repository.

1. Big picture
- **Repo role:** A small prompt/snippet library for VSA/VTA/VAE/VTE system prompts and VS Code snippets. Key files live under `prompts/` and `snippets/`.
- **Primary audience:** prompt authors and agents that generate structured artifacts (PRDs, SRDs, user stories, sprint plans).

2. Search order & grounding
- When asked to produce deliverables, prefer sources in this order: `.github/agents/<role>/prompt.md`, `snippets/`, `manifest.json`, `README.md`, then any referenced `copilot/` templates mentioned inside prompts.
- Example: `.github/agents/vsa/prompt.md` explicitly expects outputs grounded by files like `PRD/`, `SRDs/`, `Architecture/` (these may be external to this repo — cite them when present and avoid inventing content).

3. Output shape & ID conventions (use these exactly when producing VSA outputs)
- VSA outputs must include: Context, Deliverable, Assumptions, Open Questions (only one if essential), References.
- ID patterns used in prompts: `FR-###`, `SRD-FR-###`, `TC-###`, `NTC-###`, `DFSEC-###`. Use these formats when generating or mapping IDs.

4. Project-specific patterns & examples
- Use snippets in `snippets/vsa_snippets.code-snippets` as examples for prompt templates (e.g. `vsa-prd` skeleton).
- Prompts are concise system prompts — maintain short grounding lines and explicit templates (see `.github/agents/vsa/prompt.md`, `.github/agents/vae/prompt.md`).

5. Developer workflows & commands
- This repository is content-only (markdown + snippets). There are no build/test commands here. Typical workflows:
  - To add a new prompt: create `.github/agents/<role>/prompt.md` using existing files as templates.
  - To add snippets: update `snippets/*.code-snippets` with VS Code snippet JSON.

6. Integration & external dependencies
- The manifest `manifest.json` lists entry points and files used for packaging or publishing. Update it when adding/removing prompt/snippet files.
- Many prompts reference external directories (`PRD/`, `Architecture/`) — always include explicit citations to the referenced file or URL in the Context section and do not fabricate content.

7. Editing & review guidance for agents
- Preserve the explicit output shapes in each prompt. When refactoring prompts, keep examples and the grounding/search order intact.
- When asked to expand a prompt into a template, include a short example invocation and the corresponding expected output snippet.

8. What not to do
- Do not invent FR/TC IDs or claim access to files not present in the repo. If required sources are missing, produce a skeleton, list assumptions, and a single open question.

9. Where to look for patterns
- `prompts/vsa_prompt.md` — VSA role: output shape and ID conventions.
- `prompts/vae_prompt.md` — VAE role: story format and sprint planning outputs.
- `snippets/vsa_snippets.code-snippets` — concrete prompt templates used by authors.
- `manifest.json` — entry points and files to include when packaging.

If anything in this file is unclear or you want more examples (e.g., a filled PRD sample), tell me which role or template to expand and I will add one.

---

**Filled PRD example (uses `vsa-prd` snippet shape)**

# PRD - QuickSearch Feature

Context:
- Source: `PRD/quicksearch_prd.md` (external). Task: produce a compact PRD for a developer-facing quick search across docs.

Deliverable:
- Summary: Add a lightweight QuickSearch endpoint that searches `Documentation/` and `Prompts/` markdown by title and body text.
- Success criteria: average response < 200ms for 95th percentile on typical dataset; results ranked by relevance; includes snippet preview.

Assumptions:
- Indexing will run as a nightly batch job.
- Documents are stored as plain Markdown in a mount accessible to the service.

Open Questions:
- Should search support fuzzy matching or only exact/token matches?

References:
- `prompts/` (search targets), `snippets/vsa_snippets.code-snippets` (prompt template example)

---

**Contributor checklist — editing `prompts/` or `snippets/`**
- **Run here:** No build/test step required; these are content files.
- **New prompt file:** Create `prompts/<role>_prompt.md`. Start with one-line grounding, explicit search order, and required output shape.
- **Snippet JSON:** Update `snippets/*.code-snippets` with valid JSON; keep existing keys and descriptions consistent.
- **Manifest:** If adding/removing files referenced by `manifest.json`, update the `files` array accordingly.
- **Preserve IDs:** When editing prompt ID conventions, keep existing formats (`FR-###`, `SRD-FR-###`, etc.) to avoid breaking downstream usage.
- **Review:** Provide at least one example invocation and expected output where applicable.
- **PR description:** Mention role (`VSA/VAE/VTA/VTE`), changed files, and a short example of generated output.

---

Implementation notes & Acceptance tests (QuickSearch)
- **Tech approach:** Implement a simple HTTP endpoint `/api/quicksearch` that queries a pre-built inverted index over Markdown files. Index format: JSON lines with fields `{id,title,body,tokens}` stored in an S3-like blob or repo mount.
- **Data pipeline:** Nightly batch job builds/updates the index from `Documentation/` and `Prompts/` markdown. Use a tokenizer that lowercases and splits on non-alphanumerics. Store trigram tokens if fuzzy matching is supported.
- **API contract:** `POST /api/quicksearch` with body `{query: string, fuzzy?: boolean, limit?: number}` returns `{results: [{id,title,snippet,score}], total}`.
- **Acceptance tests (examples):**
  - Given documents containing "deploy guide" and a user query "deploy guide", When calling the API, Then the top result must include the document with title containing "Deploy Guide" and `score >= 0.8`.
  - Given a query with typo "deplpy", When `fuzzy=true`, Then results should still return the "Deploy Guide" document in top 3.
  - Performance: For a sample index of 10k docs, 95th percentile latency must be < 200ms (measure in CI with a lightweight dataset).
- **Observability:** Emit metrics `quicksearch.requests`, `quicksearch.latency_ms`, `quicksearch.hits` and logs with trace id and query.

---

**VTA example PRD — Test Harness Runner**

Context:
- Source: `PRD/test_harness_prd.md` (external). Task: provide a PRD for a lightweight harness that runs prompt-driven tests against templates in `prompts/`.

Deliverable:
- Summary: Add a Test Harness that reads tests described in `prompts/` and executes them against agent outputs to validate format and IDs.
- Success criteria: harness can run a suite of 50 prompt tests, report pass/fail with diffs, and produce a simple JUnit XML report.

Assumptions:
- Tests are defined as Markdown blocks with expected JSON/YAML output examples.

Open Questions:
- Should the harness simulate multiple agent personas or only validate output formatting?

References:
- `prompts/`, `snippets/vsa_snippets.code-snippets`

Implementation notes & Acceptance tests (Test Harness)
- Tech approach: CLI runner `test-harness run --suite <path>` that invokes the agent (or a mock) and compares outputs using JSON schema or deterministic match rules.
- Acceptance tests:
  - Given a suite of 10 tests with known expected outputs, When running the harness, Then it must produce a JUnit XML with 10 results and zero unexpected exceptions.
  - Report must show diffs for failing tests and a summary with pass rate.

---

**VTE example PRD — Template Library & Publishing**

Context:
- Source: `PRD/template_library_prd.md` (external). Task: standardize prompt templates and provide a publishing workflow for `snippets/`.

Deliverable:
- Summary: Create a Template Library that validates snippet JSON, enforces naming conventions, and provides a `publish` flow updating `manifest.json`.
- Success criteria: all `snippets/*.code-snippets` validate as JSON, pass naming lint, and `manifest.json` can be programmatically updated.

Assumptions:
- Snippets are intended for VS Code and must be valid VS Code snippet JSON.

Open Questions:
- Do we want to version snippets independently from repo releases?

References:
- `snippets/vsa_snippets.code-snippets`, `manifest.json`

Implementation notes & Acceptance tests (Template Library)
- Tech approach: Add a small Node.js script `tools/validate-snippets.js` that reads all files in `snippets/` and validates JSON and naming.
- Acceptance tests:
  - Given `snippets/vsa_snippets.code-snippets` valid JSON, When validation runs, Then it exits 0 and prints a summary.
  - Given malformed JSON, validation should exit non-zero and list offending files.

---

Registering agents (quick note)
- Each agent has metadata under `.github/agents/<name>/agent.yml` pointing at a prompt file and optional snippets/templates. Example: `.github/agents/vsa/agent.yml` -> `prompts/vsa_prompt.md`.
- To register these as GitHub Copilot custom agents, follow GitHub's Copilot Agents UI and provide the `agent.yml` metadata or upload the prompt file contents where requested.



