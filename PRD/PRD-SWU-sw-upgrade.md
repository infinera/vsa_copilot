<!--
Source: Scopes/sw_upgrade.md and SRDs/SRD-SWU-sw-upgrade.md
-->

# PRD - GX SW Upgrade Improvements (SWU)

**Context**
- Source slides: `Scopes/sw_upgrade.md` (SwRRT GX SW Upgrade CFD Analysis)
- SRD: `SRDs/SRD-SWU-sw-upgrade.md`

**Summary / Objective**
Improve the software upgrade experience on GX platforms by making upgrades safer, more observable, and more resilient. Deliver pre-upgrade validators, per-FRU/delta upgrade capability, automated rollback on failure, improved telemetry/logging for RCA, and a compatibility validator that enforces supported upgrade matrices.

**Success Criteria**
- Reduce customer-facing upgrade failures by 80% for known CFD classes within 6 months of release.
- Automated rollback succeeds for 99.9% of single-FRU apply failures in SVT.
- Telemetry coverage: all upgrade steps emit structured events with job/component IDs.
- Performance: partition switch completes within 4 minutes; activation timeout 10 minutes.

## Features

1. Pre-upgrade Validation (FR-SWU-001)
   - Signature and checksum validation.
   - Disk/RAM/CPU heuristics and requirement checks.
   - Internal HW link verification (I2C/PCIe) and NBI checks.

2. Granular Upgradability (FR-SWU-002)
   - API to apply upgrades to node, shelf, slot, or single FRU.
   - Support delta/service-pack style packages.

3. Safe Apply & Rollback (FR-SWU-003)
   - Automatic rollback triggers and manual override.
   - Health-check hooks post-activation.

4. Failure Isolation & Recovery (FR-SWU-004)
   - Component-specific recovery actions (DCO restart, re-apply attempts).
   - Mark and skip failing line-ports without blocking other upgrades.

5. Observability (FR-SWU-005)
   - Structured logs/events for each upgrade step.
   - Correlated debug logs (NXP, vendor logs) attached to upgrade job.

6. Compatibility Validation (FR-SWU-006)
   - Supported upgrade matrix with automated path validation.

7. Signed Script Support (FR-SWU-007)
   - Signed pre-upgrade scripts in manifest; execution logged.

## User Stories (examples)
- As an NRE, I want pre-upgrade checks to fail early when disk space is insufficient, so upgrades don't leave nodes in partial states.
- As an operator, I want to apply a delta upgrade to a single FRU without disrupting other FRUs.
- As an SRE, I want upgrade telemetry to include job and component IDs so I can correlate failures with logs.

## Acceptance Criteria (mapped)
- AC-01: Pre-check rejects unsigned or corrupted packages (TC-SWU-001).
- AC-02: Delta upgrade completion for a single FRU without impact to others (TC-SWU-003).
- AC-03: Automatic rollback on injected apply failure (TC-SWU-005).
- AC-04: Telemetry contains per-step structured events (TC-SWU-009).

## Out of scope
- Full redesign of upgrade GUI; UI improvements are considered separately.
- Vendor-specific firmware creation process (assumes vendor supplies artifacts).

## Stakeholders
- Product (Upgrade lead), QA (SVT team), SRE, Release Management, Platform Engineers (CHM6/NXP/LC teams).

## Risks
- Incomplete telemetry on older HW could limit automated rollback triggers.
- Complex release matrices across many field versions might require manual steps.

## Next steps
1. Approve SRD items and prioritize implementation backlog (epics/stories).
2. Implement Pre-check service and package manifest schema (MVP).
3. Implement automatic rollback and telemetry hooks, run SVT validation.
