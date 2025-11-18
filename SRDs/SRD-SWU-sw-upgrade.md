<!--
Source: Scopes/sw_upgrade.md
Generated SRD for: GX SW Upgrade CFD Analysis (SwRRT)
-->

# SRD - SW Upgrade (SWU)

**Context**
- Grounding: `Scopes/sw_upgrade.md` (converted PPTX)

**Deliverable**
This Software Requirements Document (SRD) breaks down the SW Upgrade concerns from `Scopes/sw_upgrade.md` into functional requirements (FR), SRD items, non-functional requirements (NFR), a traceability matrix and sample test cases.

## 1. Overview

The document captures required behaviors for safe, robust, and observable software upgrades across GX platforms. It focuses on pre-upgrade validation, per-component handling, rollback/recovery, compatibility, telemetry/logging, and testability.

## 2. Scope
- Applies to upgrade orchestration components, target nodes (CHM6, NXP, LCs), upgrade package delivery, pre/post checks, and recovery mechanisms described in `Scopes/sw_upgrade.md`.

## 3. Functional Requirements (FR)
- FR-SWU-001: Pre-upgrade Validation — System shall run pre-upgrade checks (disk space, signatures, HW links, config compatibility) prior to applying any upgrade package.
- FR-SWU-002: Granular Upgradability — System shall support delta/partial upgrades and per-FRU (card/component) upgrade control.
- FR-SWU-003: Safe Apply & Rollback — System shall detect failed apply/install steps and revert to the prior known-working partition automatically (or via safe rollback) within specified timeouts.
- FR-SWU-004: Per-Component Failure Handling — System shall detect lower-layer component failures (e.g., DCO, NXP, line-port) during upgrade and run isolation/recovery actions without taking down unrelated services.
- FR-SWU-005: Upgrade Orchestration Visibility — System shall emit structured logs and upgrade progress telemetry for each upgrade phase and component.
- FR-SWU-006: Backward Compatibility Check — System shall validate backward compatibility for configured upgrade paths up to two major releases back.
- FR-SWU-007: Signed Script Execution — System shall support dynamic pre-upgrade scripts packaged with the upgrade; scripts must be signed and recorded in a package manifest.

## 4. SRD Items (detailed)
- SRD-FR-001 (maps FR-SWU-001): Pre-upgrade check list and failure modes
  - Verify package signature and checksum.
  - Validate available disk space, RAM heuristics, and CPU headroom for each target FRU.
  - Verify internal HW links (I2C, PCIe) and NBI connectivity; raise alarm if missing.
  - Validate CLI/NBI compatibility (sample regression check list).

- SRD-FR-002 (maps FR-SWU-002): Upgrade granularity and orchestration API
  - Provide API to apply upgrade to: entire node, shelf, slot, or single FRU.
  - Support delta upgrades and service packs with semantic versioning.

- SRD-FR-003 (maps FR-SWU-003): Safe rollback criteria and automation
  - Define automatic rollback triggers (failed install, failed health checks, missing heartbeat after partition switch).
  - Provide manual override and forced-rollback options.

- SRD-FR-004 (maps FR-SWU-004): Isolation & recovery actions
  - For detected DCO failure, attempt local DCO restart and selective re-apply.
  - For line-port low-power/loss events, mark port and continue other installs.

- SRD-FR-005 (maps FR-SWU-005): Telemetry & logging
  - Emit per-step structured events (validate, transfer, apply, activate, verify) with timestamps and component ids.
  - Capture NXP/NXP-logs and vendor logs when available; correlate with upgrade id.

- SRD-FR-006 (maps FR-SWU-006): Compatibility validator
  - Maintain supported upgrade matrix and run automated checks against current configuration.

- SRD-FR-007 (maps FR-SWU-007): Script signing and manifest
  - Package manifest contains script list, version, signature, and execution order. Execution logs are recorded.

## 5. Non-Functional Requirements (NFR)
- SRD-NFR-001 (Performance): Upgrade pre-checks and apply steps should complete within operational time budgets; measured test targets defined per component (see Test Plan). Example: partition switch must complete within 4 minutes; overall activation timeout 10 minutes.
- SRD-NFR-002 (Reliability): System shall achieve recovery behavior such that 99.9% of single-FRU upgrade failures result in automatic rollback without manual intervention.
- SRD-NFR-003 (Scalability): Orchestration must support concurrent upgrades across at least 50 nodes without centralized performance degradation.
- SRD-NFR-004 (Resource Constraints): Upgrade agent memory and CPU usage must stay within 5% of baseline resource usage per-component (test to be defined per platform).
- SRD-NFR-005 (Security): All upgrade packages and scripts must be signed; unsigned packages must be rejected.

## 6. Data Models (brief)
- UpgradePackage: {id, version, checksum, signature, artifacts: [{path, component}], manifest}
- UpgradeJob: {jobId, targetNodes, targetFRUs, state, startTime, endTime, steps: [{name,state,component,logRef}]}

## 7. API Sketch (example)
POST /api/v1/upgrade
Request: {packageId, targets:[nodeIds], options:{granularity:'slot'|'fru', force:false}}
Response: {jobId}

GET /api/v1/upgrade/{jobId}
Response: {jobId, state, steps:[{name,state,started,ended,component}]}

## 8. Traceability Matrix
| FR ID | SRD Item | Test Cases |
|---|---:|---|
| FR-SWU-001 | SRD-FR-001 | TC-SWU-001, TC-SWU-002 |
| FR-SWU-002 | SRD-FR-002 | TC-SWU-003, TC-SWU-004 |
| FR-SWU-003 | SRD-FR-003 | TC-SWU-005, TC-SWU-006 |
| FR-SWU-004 | SRD-FR-004 | TC-SWU-007, TC-SWU-008 |
| FR-SWU-005 | SRD-FR-005 | TC-SWU-009 |
| FR-SWU-006 | SRD-FR-006 | TC-SWU-010 |
| FR-SWU-007 | SRD-FR-007 | TC-SWU-011 |

## 9. Sample Test Cases
- TC-SWU-001 (Pre-check fail): Provide a package where checksum or signature is invalid; expected: package rejected, alarm emitted, no apply performed.
- TC-SWU-002 (Disk-space fail): Simulate insufficient disk space on target FRU; expected: pre-check fails, operator-visible error logged.
- TC-SWU-003 (Granular delta apply): Apply a delta upgrade to a single FRU; expected: upgrade completes for target FRU only and does not affect others.
- TC-SWU-004 (Concurrent upgrade): Launch upgrades against 50 nodes in parallel; expected: orchestration remains responsive and no centralized failure.
- TC-SWU-005 (Apply failure triggers rollback): Inject a failure during apply step; expected: automatic rollback to previous partition and service restoration.
- TC-SWU-006 (Post-activate health check): After activation simulate health check failure within timeout; expected: automatic rollback.
- TC-SWU-007 (DCO failure isolation): During upgrade of DCO component, trigger DCO crash; expected: orchestration isolates DCO attempt, attempts local recovery, logs event, and continues other safe upgrades.
- TC-SWU-008 (Line-port low-power): Simulate line-port entering low-power during install; expected: port marked, package apply continues on other FRUs.
- TC-SWU-009 (Telemetry validation): Verify structured telemetry is emitted for each upgrade step and contains component and job IDs.
- TC-SWU-010 (Compatibility validator): For a target node running an older unsupported release path, validator rejects or marks for manual review.
- TC-SWU-011 (Signed script execution): Provide signed pre-upgrade script that modifies environment; expected: script executes in pre-check phase and logs outcome; unsigned script rejected.

## 10. Acceptance Criteria
- All pre-checks implemented and verifiable (TC-SWU-001, TC-SWU-002).
- Automatic rollback works for injected apply failures (TC-SWU-005, TC-SWU-006).
- Orchestration supports per-FRU/delta upgrades (TC-SWU-003).
- Telemetry and logs provide sufficient context for RCA (TC-SWU-009).

**Assumptions**
- The upgrade orchestration layer exists (ThanOS or equivalent); this SRD defines interfaces expected from that layer.
- Target platforms expose sufficient health metrics and logs for automated checks (NXP, CHM6, LCs).
- Release management provides signed packages and manifest data.

**Open Question**
- Which component is the authoritative orchestration controller for GX upgrades (ThanOS, dedicated orchestrator, or external CI/CD)?

**References**
- `Scopes/sw_upgrade.md` (source slides)
- `PRD/PRD-template.md` (template reference, if used)
