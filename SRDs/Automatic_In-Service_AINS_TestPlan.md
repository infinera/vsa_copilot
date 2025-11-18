# AINS Test Plan

**Context:**
- Source SRD: `SRDs/Automatic_In-Service_GRD.md`
- Purpose: Validate Automatic In-Service (AINS) behavior against the GRD requirements.

**Deliverable:**
- A set of executable test cases (manual or automated), pass/fail criteria, and traceability to GRD IDs.

**Assumptions:**
- Testbed hardware supports TRIB-PTP and Line-PTP/SCG-PTP features required for scenarios.
- Alarm injection and management-plane access are available to set/observe AINS and timers.
- Timeouts and timers are configurable for accelerated validation.

**Open Questions:**
- Should tests include extended feature-interaction scenarios (protection switching, PM, upgrades)?
- Which test environment (hardware model and software version) should be used as the baseline?

**References:**
- `SRDs/Automatic_In-Service_GRD.md`
- GRD IDs (e.g. GRD-459..GRD-490) referenced in test cases.

---

## Test Case Index
- TC-001: AINS basic enable/disable and template override (covers GRD-459..GRD-464)
- TC-002: ValidSignalTimeInterval behavior and RemValidSignalTimer exposure (covers GRD-464..GRD-468)
- TC-003: Facility-failure triggers (invalid signal) for TRIB and Line (covers GRD-477, GRD-478)
- TC-004: Alarm masking while AINS enabled (covers GRD-479)
- TC-005: State transitions on timer expiry and fault occurrence (covers GRD-476)
- TC-006: Reset behavior on cold/warm/controller resets (covers GRD-480..GRD-484)
- TC-007: Control plane failure handling (covers GRD-485..GRD-486)
- TC-008: Path-level failures and SNC masking interaction (covers GRD-487..GRD-488)
- TC-009: Feature interaction smoke (protection switching, PM, diagnostics) (covers GRD-490)

---

## Test Cases (detailed)

TC-001: AINS basic enable/disable and template override
- ID: TC-001
- Purpose: Verify AINS can be configured via default template and overridden per-port.
- Preconditions: Management interface reachable; default template set to disabled.
- Steps:
  1. Set default AINS template to `disabled`.
  2. Configure AINS `enabled` on TRIB-PTP `<port-A>` via per-port config.
  3. Verify `AINS` attribute on `<port-A>` shows `enabled` while default template remains `disabled`.
  4. Change default template to `enabled`, verify existing `<port-B>` remains unchanged per GRD-471.
- Expected:
  - Per-port override applies immediately and is reported via management API (pass).
  - Changing the default template does not retroactively change per-port AINS values (pass).
- Traceability: GRD-459..GRD-464, GRD-471

TC-002: ValidSignalTimeInterval behavior and RemValidSignalTimer exposure
- ID: TC-002
- Purpose: Validate configuration and reporting of the timer values.
- Preconditions: Ports under test are in AINS enabled state; timer configurable.
- Steps:
  1. Configure `ValidSignalTimeInterval` to a short value (e.g., 2 minutes) on `<port-A>`.
  2. Enable AINS on `<port-A>` and observe `RemValidSignalTimer` decrementing.
  3. Simulate no faults during timer; wait for expiry; verify `<port-A>` transitions to In-Service with AINS disabled.
  4. Repeat with a fault injected before timer expiry; verify RemValidSignalTimer resets and port remains Out-of-Service AINS enabled.
- Expected:
  - Timer configurable and exposed; RemValidSignalTimer decrements as expected.
  - Port state transitions follow GRD-476 rules.
- Traceability: GRD-464..GRD-468, GRD-476

TC-003: Facility-failure triggers (invalid signal) for TRIB and Line
- ID: TC-003
- Purpose: Confirm that specified alarms are treated as invalid signals and trigger AINS behavior.
- Preconditions: List of alarms configured to be considered invalid per platform.
- Steps:
  1. Enable AINS on a TRIB-PTP and a Line-PTP.
  2. Inject an OLOS alarm on the Line-PTP; verify it is classified as invalid signal.
  3. Inject a LOSYNC/CSF on client-side TRIB and verify classification.
  4. Verify behavior matches expectations (masking, RemValidSignalTimer reset, state transitions).
- Expected: Alarms listed in GRD-477/GRD-478 cause the described AINS actions.
- Traceability: GRD-477, GRD-478

TC-004: Alarm masking while AINS enabled
- ID: TC-004
- Purpose: Verify that alarms on affected termination points are not reported to management interfaces while AINS is active, except noted exceptions.
- Steps:
  1. Enable AINS on `<port-A>`.
  2. Inject a service-affecting alarm on `<port-A>` and verify it is not reported via management interfaces.
  3. Verify TCAs and controller-card dependent alarms (e.g., COMM-CHNL-DOWN) are still reported.
- Expected: Masking applies per GRD-479; TCAs and controller-dependent alarms are not masked.
- Traceability: GRD-479

TC-005: State transitions on timer expiry and fault occurrence
- ID: TC-005
- Purpose: Validate transition to In-Service when timer expires with no faults and Out-of-Service when faults occur.
- Steps:
  1. Enable AINS on `<port-A>` with a short timer.
  2. Ensure no faults; wait for timer expiry; verify transition to In-Service and AINS disabled.
  3. Repeat with a fault occurring before expiry; verify transition to Out-of-Service and AINS enabled.
- Expected: Transitions match GRD-476.
- Traceability: GRD-476

TC-006: Reset behavior on cold/warm/controller resets
- ID: TC-006
- Purpose: Validate RemValidSignalTimer and AINS behavior across cold/warm resets of controller and transport cards.
- Steps:
  1. Enable AINS and start RemValidSignalTimer on `<port-A>`.
  2. Perform a warm reset of the controller card; observe RemValidSignalTimer behavior per GRD-482.
  3. Perform a cold reset of transport card and verify RemValidSignalTimer reset behavior per GRD-483.
  4. Validate controller-card reboot/switch-over does not undesirably reset RemValidSignalTimer per GRD-484.
- Expected: Behavior follows GRD-481..GRD-484.
- Traceability: GRD-481..GRD-484

TC-007: Control plane failure handling
- ID: TC-007
- Purpose: Verify behavior when the control plane is down during timer activity and after recovery.
- Steps:
  1. Enable AINS on `<port-A>` and start timer.
  2. Simulate control-plane loss between transport module and controller; verify RemValidSignalTimer continues (or behavior per platform acceptability).
  3. Restore control-plane; verify RemValidSignalTimer behavior and state transitions per GRD-485..GRD-486.
- Expected: RemValidSignalTimer behavior follows GRD-485..GRD-486.
- Traceability: GRD-485..GRD-486

TC-008: Path-level failures and SNC masking interaction
- ID: TC-008
- Purpose: Validate SNC alarms and path-level faults handling when AINS is enabled.
- Steps:
  1. Enable AINS on endpoints of an SNC.
  2. Inject a path-level fault (DTP/ODU) inside the Infinera network and verify SNC alarms are still reported.
  3. Verify SNC masking for client-level failures behaves per GRD-488..GRD-489.
- Expected: Path-level faults reported; SNC masking for client-level failures applies as defined.
- Traceability: GRD-487..GRD-489

TC-009: Feature interaction smoke
- ID: TC-009
- Purpose: Quick smoke tests for protection switching, PM, diagnostics, and SW/DB upgrade interactions while AINS is enabled.
- Steps:
  1. Enable AINS on relevant ports.
  2. Perform a protection switch event and verify service continuity and alarm behavior.
  3. Trigger PM collection and confirm PM buckets are not marked invalid due to AINS.
  4. Simulate an SW/DB upgrade and verify AINS/template values are preserved per GRD-490.
- Expected: No loss of functionality; interactions documented.
- Traceability: GRD-490

---

## Execution Notes
- Use accelerated timers or test harness flags to shorten test durations.
- Capture management API logs, alarm reporting, and state transitions as artifacts for each test.
- Record pass/fail with logs, screenshots, and timestamps.

---

## Traceability Matrix (sample)
- GRD-459..GRD-464 -> TC-001
- GRD-464..GRD-468 -> TC-002
- GRD-477, GRD-478 -> TC-003
- GRD-479 -> TC-004
- GRD-476 -> TC-005
- GRD-481..GRD-484 -> TC-006
- GRD-485..GRD-486 -> TC-007
- GRD-487..GRD-489 -> TC-008
- GRD-490 -> TC-009

---

*Generated by vsa_copilot test-plan generator.*
