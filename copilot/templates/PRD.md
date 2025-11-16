# PRD Template

## Context

## Deliverable

## Assumptions

## Open Questions

## References

---

# Example: VTA — Test Harness Runner (filled PRD)

## Context
- Source: `PRD/test_harness_prd.md` (external). Task: provide a PRD for a lightweight harness that runs prompt-driven tests against templates in `prompts/`.

## Deliverable
- Summary: Add a Test Harness CLI that reads test cases described as Markdown blocks in `tests/` or `prompts/`, executes them against agent outputs (real or mocked), validates output shape/IDs, and emits a JUnit XML report.
- Key features:
	- CLI `test-harness run --suite <path>`
	- Support for mock and live agent execution
	- Configurable comparison rules (JSON schema, field-level matchers)
	- Output: JUnit XML + human-readable diff summary

## Assumptions
- Tests are authored in Markdown with an upfront YAML header containing `id`, `role`, `expected` (JSON/YAML) or `schema`.
- The harness will run in CI using a headless runner and may call an HTTP mock instead of the external Copilot API.

## Open Questions
- Should the harness simulate multiple agent personas or only validate output formatting?

## References
- `prompts/`, `snippets/vsa_snippets.code-snippets`

## Acceptance Criteria
- Given a suite of 10 deterministic tests, `test-harness run` produces a valid JUnit XML with 10 testcases and exit code 0.
- When a test output differs, the harness returns non-zero and writes a diff file next to the test with context.

---

# Example: VTE — Template Library & Publishing (filled PRD)

## Context
- Source: `PRD/template_library_prd.md` (external). Task: standardize VS Code prompt templates in `snippets/` and provide a publish flow updating `manifest.json`.

## Deliverable
- Summary: Create a Template Library that validates snippet JSON, enforces naming conventions, provides a `tools/publish-snippets.js` script to update `manifest.json`, and adds CI validation.
- Key features:
	- `tools/validate-snippets.js` to check JSON and naming conventions
	- `tools/publish-snippets.js` to atomically update `manifest.json`
	- GitHub Action `validate-snippets.yml` to run on PRs

## Assumptions
- Snippets must be valid VS Code snippet JSON and use descriptive keys matching the `role` they target.

## Open Questions
- Do we want to version snippets independently from repo releases?

## References
- `snippets/`, `manifest.json`

## Acceptance Criteria
- `tools/validate-snippets.js` exits 0 for the current `snippets/vsa_snippets.code-snippets`.
- A PR that adds malformed JSON or invalid naming fails CI and lists offending files.
