<!--
Source: SRDs/SRD-SWU-sw-upgrade.md and PRD/PRD-SWU-sw-upgrade.md
-->

# Test Plan - SW Upgrade (SWU)

**Context**
- Source SRD: `SRDs/SRD-SWU-sw-upgrade.md`
- Source PRD: `PRD/PRD-SWU-sw-upgrade.md`

## Objectives
- Verify pre-upgrade checks, safe apply/rollback, failure isolation, telemetry emission, and compatibility validation across representative GX platforms.

## Test Environment
- SVT lab with CHM6, NXP, and representative LC cards.
- Test harness: automated runner capable of deploying packages, simulating failures (network, disk, component restarts), and collecting telemetry.
- Monitoring/telemetry backend to receive structured events.

## Test Matrix (summary)
| Test ID | Purpose | Target | Preconditions |
|---|---|---:|---|
| TC-SWU-001 | Pre-check signature validation | CHM6 | Prepare invalid signature package |
| TC-SWU-002 | Disk-space pre-check | CHM6/LC | Fill disk to below threshold |
| TC-SWU-003 | Granular delta apply | CHM6 slot | Delta package for single FRU |
| TC-SWU-004 | Concurrent upgrade stress | 50 nodes (simulated) | 50 test nodes available |
| TC-SWU-005 | Apply failure -> rollback | CHM6 | Inject failure during apply step |
| TC-SWU-006 | Post-activate health check rollback | CHM6 | Activation health check script configured |
| TC-SWU-007 | DCO failure isolation | Node with DCO | Trigger DCO crash during upgrade |
| TC-SWU-008 | Line-port low-power handling | Node with line ports | Force port low-power during install |
| TC-SWU-009 | Telemetry validation | Central telemetry | Telemetry backend available |
| TC-SWU-010 | Compatibility validator | Node with old release | Node on unsupported path |
| TC-SWU-011 | Signed script execution | Any | Signed pre-upgrade script in package |

## Test Case Details (selected)

TC-SWU-001: Pre-check signature validation
- Steps:
  1. Create an upgrade package with an invalid signature or modified checksum.
  2. Submit the package to orchestration API.
  3. Observe pre-check rejection and alarm.
- Expected:
  - Orchestrator rejects package, logs error, emits failure event. No apply started.

TC-SWU-005: Apply failure -> rollback
- Steps:
  1. Prepare a package that will fail during apply (instrument target to error at a chosen step).
  2. Start upgrade job.
  3. Confirm orchestrator detects failure and triggers rollback.
  4. Verify node returns to previous running partition and services restored.
- Expected:
  - Automatic rollback completes; telemetry shows rollback steps; no operator action required.

TC-SWU-009: Telemetry validation
- Steps:
  1. Run an upgrade job (normal path).
  2. Collect telemetry events from orchestrator and nodes.
  3. Validate events include jobId, componentId, step name, timestamps, and status.
- Expected:
  - All steps emit structured events; events correlated by jobId.

## Automation & Tools
- Use the existing test harness or MCP mock runner to trigger upgrades and simulate failures.
- Implement harness plugins for:
  - Disk fill simulation
  - Component crash injection
  - Network partition simulation

## Schedule & Exit Criteria
- Phase 1 (MVP): Implement and validate TC-SWU-001, TC-SWU-002, TC-SWU-005, TC-SWU-009 within SVT environment.
- Exit Criteria for release: All Phase 1 tests pass in SVT and telemetry shows full per-step coverage.

## Risks & Mitigations
- Risk: Incomplete telemetry on older hardware. Mitigation: Add fallback logging and collect vendor logs.
- Risk: Testbed resource limitations for large-scale concurrency tests. Mitigation: Use simulated nodes or cloud shells for scale tests.

## Traceability
- Tests map to SRD FRs as listed in `SRDs/SRD-SWU-sw-upgrade.md` traceability matrix.
