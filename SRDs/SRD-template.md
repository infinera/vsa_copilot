# SRD Template

## Header
- **SRD ID:** SRD-<FeatureCode>-NNN
- **Related PRD:** PRD-<FeatureCode>-NNN
- **Author:**
- **Date:**

## Overview

Short description and intent of the system requirements.

## Scope

- In-scope components and boundaries
- Out-of-scope

## Functional Requirements (FR-###)

List functional requirements with structure:
- **FR-001 — Title**
  - Description: Detailed requirement text.
  - Rationale: Why this exists.
  - Priority: Must|Should|Could
  - Owner: team/person
  - Inputs: data and events
  - Outputs: expected outputs

## Data Models / Schema

- Summary of key data entities and links to `APIs/` OpenAPI specs.

## Non-Functional Requirements (NFR-###)

- **NFR-001 — Performance**
  - Metric: p95 latency < X ms
  - Test: reference TC-###

- **NFR-002 — Security**
  - Requirement: OAuth2/Bearer or mutual TLS

## Interface Contracts

- Describe external interfaces, protocols, and message formats.

## Error Handling & Edge Cases

- Describe failure modes, retry behavior, and compensating actions.

## Traceability Matrix

| SRD ID | FR ID | Test Case TC | Notes |
|--------|-------|--------------|-------|

## Deployment & Operational Requirements

- Deployment topology, scaling, backups, and monitoring metrics.

## Acceptance Criteria

- Criteria mapped to FR/NFR with pass/fail rules.

## References

- Links to PRD, design docs, external standards.
