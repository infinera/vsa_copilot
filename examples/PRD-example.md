# PRD Example — QuickSearch

**PRD ID:** PRD-QS-001

**Summary:** Add a QuickSearch endpoint that indexes repository Markdown and returns ranked results.

**Goals:** Fast developer-facing search across `Documentation/` and `prompts/` with snippet preview.

**Requirements:**
- FR-001: Search by title and body text.
- FR-002: Return top 10 results by relevance.

**Acceptance Criteria:**
- Given documents contain "deploy guide" and user queries "deploy guide", Then top result includes the Deploy Guide document.
