<!-- Converted from: Automatic_In-Service_GRD.pdf -->

## Page 1

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

Automatic In-Service GRD

Issue Date

Owner

---
# Automatic In-Service GRD (AINS) — SRD

**Context:**
- **Source:** `SRDs/Automatic_In-Service_GRD.pdf` (converted to Markdown).
- **Original URL:** https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD
- **Purpose:** Provide a concise, VSA-friendly SRD summarizing the Automatic In-Service (AINS) Generic Requirements Document and preserve the extracted content for reference.

**Deliverable:**
- **Summary:** The AINS feature allows a termination point (Trib-PTP or Line-/SCG-PTP) to enter an "alarm-free" provisioning state where alarm reporting is masked while a configurable Valid Signal Timer counts down. If no service-affecting faults are observed for the duration of the timer, the termination point transitions to In-Service; otherwise it remains Out-of-Service with AINS enabled. The feature includes configuration via templates, per-port overrides, timers (`ValidSignalTimeInterval`, `RemValidSignalTimer`), alarm masking rules, and interaction constraints with other features (protection switching, PM, diagnostics, etc.).
- **Key requirements (representative):**
	- Support AINS on TRIB-PTP and Line-PTP/SCG-PTP with template and per-port overrides (see GRD-459..GRD-464).
	- Provide configurable `ValidSignalTimeInterval` (1..7200 minutes) and expose `RemValidSignalTimer` (GRD-464..GRD-468).
	- Define facility-failure alarm lists that constitute "invalid signal" triggers for AINS (GRD-477, GRD-478).
	- Mask alarms for the affected termination points while AINS is enabled; do not suppress certain controller-managed alarms or TCAs (GRD-479).
	- Define state transitions and reset/behavior rules for control-plane events, warm/cold resets, and interaction with protection and PM (GRD-480..GRD-490).

**Assumptions:**
- The converted Markdown omits detailed diagrams and some Confluence interactive elements; diagrams may need manual review or reattachment.
- GRD identifiers (e.g., `GRD-477`) are preserved verbatim from the source and should remain authoritative for traceability.
- Diagrams and large tables remain in the appendix as extracted text; if needed they should be rebuilt by the engineering writer.

**Open Questions:**
- Do you want OCR transcriptions kept in the main SRD or moved to a separate file `SRDs/Automatic_In-Service_GRD-ocr.md` (recommended)?

**References:**
- `SRDs/Automatic_In-Service_GRD.pdf` (source PDF, converted). 
- Converted assets: `SRDs/Automatic_In-Service_GRD-images/` (page PNGs and tesseract `.txt` outputs).
- Confluence page: https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

---

## Appendix — Extracted Document (converted text)

The remainder of this file contains the raw extracted Markdown from the original GRD for reference. Use the SRD sections above for VSA consumption; the appendix is for traceability and review.

3. 3. Operational Impact

The following items describe the importance of this feature in providing operational benefits for our customers.

1.  

2.  
3.  

4.  

Alarms reported, when they are not supposed to, cause operational personnel additional burden, cause NOC teams to unnecessarily spend time 
and effort in handling trouble tickets.
False alarms cause considerable cost, time and effort towards operational expenses for our customers.
Extraneous alarms become visible everywhere in the network. Different operational personnel (other than service turn-up staff) monitoring alarms 
in the network, get unnecessary trouble tickets.
Differentiating between true alarms vs false alarms becomes non-trivial when co-relating the alarms network-wide, between the Node A and Node 
Z.

4. 4. User Experience Considerations



---

## Page 5

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

The following are the considerations of this feature for providing the best user experience to our customers.

1.  
2.  
3.  

The purpose of AINS for turning up client services in an “alarm-free state” must be delivered with high quality.
The fault management (Alarm reporting) sub-system has to be robust with predictable, reliable and consistent behavior.
A system which is built with a solid fault management solution/offering becomes a key component for retaining the value proposition as an 
incumbent equipment provider.

5. 5. AINS Requirements

5.1. 5.1. Configuration Management

[ 

GRD-459 Getting issue details...

 - 

STATUS

 ]

 AINS Support on TRIB interface

The Infinera NE shall support the Automatic In-Service (AINS) provisioning feature on the TRIB-PTP of all the circuit pack types which has a tributary 
interface to the client equipment. Furthermore, the AINS feature shall be supported for both the pre-provisioning and auto-provisioning cases.

[ 

GRD-460 Getting issue details...

 - 

STATUS

 ]

 AINS Support on Line/SCG interface

The Infinera NE shall support the Automatic In-Service (AINS) provisioning feature on the Line-PTP/SCG-PTP of all the circuit pack types which has a 
line interface to the network. Furthermore, the AINS feature shall be supported for both the pre-provisioning and auto-provisioning cases.

The TRIB-PTP and Line-/SCG-PTP are specifically selected as the choice of termination points to support AINS feature because during test and turn-up 
(or troubleshooting) of the client and line signals coming into Infinera network node, the TRIB-PTPs and Line-/SCG-PTPs act as the edge points of the 
network and client boundary. It is to be noted that when the AINS feature is applied to the TRIB-PTP, the corresponding client shall also be placed 
 
---

:

Upon expiry of the Valid Signal Timer, if there were no faults detected either on the TRIB-PTP or the corresponding Client CTP, Line-PTP/SCG-
PTP or the corresponding Line CTP for the entire duration of the timer, the TRIB-PTP and the Client CTP, or the Line-PTP/SCG-PTP and the Line 
CTP shall transition to an “In-Service” state with AINS value set to disabled.
If the fault condition(s) occurs on the TRIB-PTP or Client CTP, the Line-PTP/SCG-PTP or Line CTP before the Valid Signal Timer expires, the 
TRIB-PTP and the corresponding Client CTP, or the Line-PTP/SCG-PTP and the corresponding Line CTP shall transition to “Out-of-Service” state 
(operational state=disabled) with AINS value set to enabled.

Generic State Diagram for the AINS feature 

The presence of “fault" conditions or “abnormal” conditions or “invalid signal” is defined as the presence of an alarm which causes a Facility Failure (FAF) 
state for the termination point. The FAF state (NE operational state qualifier=Faulted) is an out-of-service state.

The following requirements shall be used for triggering the FAF on TRIB-PTP, Line-PTP/SCG-PTP, Client CTPs, and SCH CTP that results in transition 
into AINS or out of AINS state.


---

## Page 8

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[ 

GRD-477 Getting issue details...

 - 

STATUS

 ]

 Facility Failures - Invalid Signal Failures for the TRIB AINS feature

The NE shall use the 
the signal as “invalid signal”.

service-affecting

 alarms that contribute to the TRIB-PTP and the 

Client CTP facilities

, and the supporting equipment for declaring 

For example (may not be a complete list of service-affecting alarms applicable to each facility):

TRIB-PTP  OLOS, CDR-LOL
Client CTPs

:

:

SONET Client-CTP: ingress/egress LOF, ingress/egress AIS-L
SDH Client-CTP: ingress/egress LOF, ingress/egress MS-AIS
GbE
OTU Client-CTP: ingress/egress LOF, ingress LOM, ingress LOL
ODU Client-CTP (service-mode=network-wrapper)  egress CSF, egress AIS, egress OCI, egress LCK, PLM, TIM

 Client-CTP:

 ingress/egress LOSYNC, ingress/egress LF, ingress/egress RF, ingress/egress HIBER, ingress LOA, ingress LOLM

:

Note: As an exception, UCM4 in service-mode=switching considers the specified ODU Client-CTP alarms as invalid signals for AINS.

FC Client-CTP: ingress/egress LOSYNC, ingress/egress HIBER, ingress/egress LF, ingress/egress RF, ingress LOS, ingress LFA (FEC 
enabled)

Equipment 
UNSUPPORTED

(TOM or its supporting equipment; OTM, TIM, LM, TAM, etc.):

 EQPTFAIL, IMPROPRMVL, EQPTCOMFAIL, PWR-CLASS-

[ 

GRD-478 Getting issue details...

 - 

STATUS

 ]

 Facility Failures - Invalid Signal Failures for the Line/SCG AINS feature

The NE shall use the following failure conditions that contribute to the Line-PTP/SCG-PTP and the SCH CTP facilities for declaring the signal as “invalid 
signal”.

Line-PTP/SCG-PTP: OLOS
Line CTPs:

SCH-CTP: ALL-CARRIER-FAIL
Carrier-CTP (CHM7): COH-LOL, POST-FEC-Q-SIGNAL-FAILURE

Equipment (line transceiver equipment or its supporting equipment): EQPTFAIL, IMPROPRMVL

[ 

GRD-479 Getting issue details...

 - 

STATUS

 ]

 Alarm Masking when in AINS enabled state

When the AINS feature is enabled on the TRIB-PTP or Line-PTP/SCG-PTP, any alarms occurring on the TRIB-PTP and its corresponding Client CTP, 
the Line-PTP/SCG-PTP and its corresponding SCH CTP, and the SNC (if present) shall not be reported to the management interfaces.

Note 1: Threshold Crossing Alerts (TCA) are not suppressed or inhibited when AINS is enabled in the GX line of products.
Note 2: Alarms that are managed in the controller card but dependent on the transport card, such as COMM-CHNL-DOWN, are not suppressed or 
inhibited when AINS is enabled in the GX line of products.

When the AINS is enabled and the AINS remaining valid signal timer is decrementing, the data plane traffic is up and running. Only the alarm reporting is 
turned off during AINS state.

State Transitions for the Trib-PTP AINS feature

The following figure illustrate the state transitions for the Trib-PTP AINS provisioning.


---

## Page 9

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[ 

GRD-480 Getting issue details...

 - 

STATUS

 ]

 Reset of Valid Signal Timer upon detecting fault

During the time RemValidSignalTimer is active (decrementing), If any of the faults as specified in 
RemValidSignalTimer value shall be reset to the configured value for ValidSignalTimeInterval.

GRD-477 GRD-478
 or 

 is detected by the NE, the 

[ 

GRD-481 Getting issue details...

 - 

STATUS

 ]

 Cold reset behavior - Chassis equipment hosting transceivers/TOMs

It is acceptable that a cold reset of the associated chassis controller card equipment resets the RemValidSignalTimer value to the configured value for 
ValidSignalTimeInterval.

[ 

GRD-482 Getting issue details...

 - 

STATUS

 ]

 Warm reset behavior - Chassis equipment hosting transceivers/TOMs

During the time RemValidSignalTimer is active (decrementing), it is acceptable that a warm reset of the associated chassis controller card equipment 
continues to decrement the RemValidSignalTimer value.

[ 

GRD-483 Getting issue details...

 - 

STATUS

 ]

 Cold/Warm reset behavior - Transport equipment containing transceivers/TOMs

During the time RemValidSignalTimer is active (decrementing), it is acceptable that a 
RemValidSignalTimer value to the configured value for ValidSignalTimeInterval.

cold/warm

 reset of the associated transport card resets the


---

## Page 10

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[ 

GRD-484 Getting issue details...

 - 

STATUS

 ]

 Controller Card reset or active switch

It is desirable that a node controller card reboot or switch-over shall not trigger the reset of RemValidSignalTimer value to the configured value for 
ValidSignalTimeInterval.

The above objective is desirable to cover the case of not restarting AINS feature all over again when the controller resets or a controller activity switch 
takes place.

[ 

GRD-485 Getting issue details...

 - 

STATUS

 ]

 Control Plane Failure when VS Timer is active

During the time RemValidSignalTimer is active (decrementing) and the control plane connectivity between the tributary module hosting the TOM or the 
line module  and controller module is down, then it is acceptable that the RemValidSignalTimer continues to decrement, and the state transitions are 
carried accordingly.

,

[ 

GRD-486 Getting issue details...

 - 

STATUS

 ]

 Control Plane failure when fault is outstanding

When AINS is enabled on the TRIB-PTP or Line-PTP/SCG-PTP with any of the outstanding fault specified in 
plane failure is also present between the tributary module hosting the TOM or the line module and controller module, then it is acceptable that the AINS 
state is held until the control plane is recovered and the fault conditions are re-evaluated accordingly. The following cases shall be handled.

, and a control 

GRD-478

GRD-477

 and 

1.  

2.  

When the control plane is recovered and there is no fault present as specified in 
decrementing from the configured value for ValidSignalTimeInterval.
When the control plane is recovered and there is any fault present as specified in 
, then the RemValidSignalTimer is reset 
to the configured value for ValidSignalTimeInterval. No count-down of RemValidSignalTimer occurs in this scenario as there is still a fault present.

, then the RemValidSignalTimer starts 

GRD-477 and GRD-478

GRD-477 and GRD-478

[ 

GRD-487 Getting issue details...

 - 

STATUS

 ]

 Path level failures - CTP

It is acceptable that the NE do not mask the path level faults (e.g. DTP in DTN and ODU in XTN) when the TRIB-PTP or Line-PTP/SCG-PTP is in the 
AINS enabled state.

It is expected that the Infinera network-side faults are useful to be reported to isolate the failure inside the Infinera network. The AINS feature is used only 
at the edge point where the tributary/client signals and line signals are monitored for faults during turn up or troubleshooting. Note that the ODU-level CSF 
is considered a client signal failure and is included in the AINS hierarchy.

[ 

GRD-488 Getting issue details...

 - 

STATUS

 ]

 SNC Alarm masking resulting from TRIB/Client or Line/SCG Failures

The NE shall mask the SNC failure alarm which results from the faults specified in 
PTP/SCG-PTP on which SNC is created is in the AINS enabled state.

GRD-477 and GRD-478

, and the corresponding TRIB-PTP or Line-

There are no separate timers provided for SNCs or Client Termination Points. The timers (both RemValidSignalTimer and ValidSignalTimeInterval) are 
provided only on the TRIB-PTP and Line-PTP/SCG-PTP. If the user wants to check how much time is remaining before SNC or a client termination point 
transition to In-Service state, he/she shall explicitly perform a retrieval operation on the corresponding TRIB-PTP or Line-PTP/SCG-PTP managed object 
where SNC or Client Termination Point resides.

Interaction between Trib-PTP AINS, SNC and Client-CTP states

The following state transition diagram illustrates state transitions that are supported for the AINS states between the Trib-PTP, SNC and Client CTP.


---

## Page 11

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[ 

GRD-489 Getting issue details...

 - 

STATUS

 ]

 SNC alarms resulting from Path level faults

It is acceptable that the SNC failure alarm be reported at all times (irrespective of corresponding TRIB or Line/SCG being in AINS enabled or disabled 
mode) when there is a path (DTP/ODU) level fault present in any of the path points of the SNC.

The SNC failure alarms resulting from the DTP/ODU-level faults will be useful for debugging the problem in the Infinera network. Note that the only 
exception to the above requirement is ODU-level CSF failure, which is considered as a client failure and is include in the AINS Facility Failure Condition, 
thus masking the SNC fail alarm.

5.3. 5.3. Feature Interaction


---

## Page 12

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[ 

GRD-490 Getting issue details...

 - 

STATUS

 ]

 AINS and Other Feature interaction

The NE shall continue to support the existing features. The features covered in this GRD shall coexist with existing features already supported. There 
shall be no loss of functionality as a result of adding the AINS feature support. The following are the important features identified to have some feature 
interaction that shall be tested and verified.

1.  
2.  
3.  

4.  
5.  

6.  

7.  
8.  

9.  

10.  

LED behavior: No changes to the LED behavior.
SW/DB upgrade: The AINS and valid signal time interval values will be backed up and restored per the existing SW/DB upgrade procedure.
Protection Switching: The PG creation and TRIB-PTP PU selection per the existing behavior shall continue to be supported. Fault detection and 
protection switching upon the existing triggers continues to be supported when in the AINS enabled state (i.e. when the RemValidSignalTimer is 
active and decrementing). Both 1-port and 2-port protection shall be certified with AINS.
Diagnostics: Ability to perform diagnostics in maintenance state shall continue to be supported.
Performance Monitoring: The NE should continue to collect the PM data (real time and historical) when the TRIB-PTP is in the AINS enabled state. 
Further, the PM buckets shall not be marked invalid due to AINS state. The existing rules for marking PM buckets validity shall prevail.
Equipment Provisioning: The AINS feature defined shall be applicable to all the equipment type where the applicable tributary or line interfaces are 
present. Also, the existing equipment provisioning methodology shall not be changed to support AINS.
Service Provisioning: The existing methods of creating the manual cross-connects or SNCs shall be used.
OTN mappings: Where applicable, all type of network mappings shall be supported with deployment scenarios: SNC endpoints with source to 
destination clients as: GBE to GBE, GBE to OTUk, OTUk to OTUk
The SNC masking shall be done for both LOCAL SNC and REMOTE SNCs depending on the TRIB AINS configuration on the corresponding 
endpoints.
Masking of TRIB, Client, Line/SCG, SCH and SNCs alarms listed in this GRD shall be certified for the multiplexing scenarios.

6. 6. Information Model for the AINS 

Feature

NE Attribute Name

Access/Role

Possible Values

Default

Description/Behavior

AINS

R/W

Disabled

This attribute is used to configure the AINS feature on the TRIB or Line/SCG interface.

Enabled
Disabled

ValidSignalTimeInterval R/W

1 to 7200 minutes

480 minutes This attribute is used to configure the valid signal timer for the AINS feature on TRIB or Line/SCG interfaces.

RemValidSignalTimer

R-O

0 to 7200 minutes

NA

This attribute is used to display the remaining valid signal timer value.

The value is configurable in 1-minute granularity.

The value is reported in 1-minute granularity.

7. 7. Reviews

7.1. 7.1. Mandatory Reviewers

Reviewed/Approved

Reviewed/Concerns raised, not ready to approve.

Sharfuddin Syed 

16 Dec 2020

@<reviewer-name> //<date>

Nuno Pereira  

16 Dec 2020

Channabasava Yadrami 

16 Dec 2020

Unknown User (tstafford) 

16 Dec 2020

Prasanna Jaikrishnamoorthy 

16 Dec 2020

Unknown User (kkasiviswanathan) 

16 Dec 2020

7.2. 7.2. Jira Requirement Table

T

Key

Summary

Status

Labels


---

## Page 13

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

GRD-490 AINS and Other Feature interaction

GRD-489 SNC alarms resulting from Path level faults

GRD-488 SNC Alarm masking resulting from TRIB/Client or SCG Failures

GRD-487 Path level failures - CTP

GRD-486 Control Plane failure when fault is outstanding

GRD-485 Control Plane Failure when VS Timer is active

GRD-484 Controller Card reset or active switch

GRD-483 Cold/Warm reset behavior - Transport equipment containing transceivers/TOMs

GRD-482 Warm reset behavior - Chassis equipment hosting transceivers/TOMs

GRD-481 Cold reset behavior - Chassis equipment hosting transceivers/TOMs

GRD-480 Reset of Valid Signal Timer upon detecting fault

GRD-479 Alarm Masking when in AINS enabled state

GRD-478

Facility Failures - Invalid Signal Failures for the Line/SCG AINS feature

GRD-477

Facility Failures - Invalid Signal Failures for the TRIB AINS feature

GRD-476

Transition into in-service state upon expiry of VS Timer

GRD-475 No pre-conditions for changing the Valid Signal Time Interval

GRD-474 No impact to default template when Valid Signal Time Interval is updated on TRIB/SCG

GRD-473 No impact to existing AINS Valid Signal Time Interval configuration when default template is 

updated

GRD-472 No impact to default template when TRIB/Line/SCG AINS is updated

GRD-471 No impact to existing AINS configuration when default template is updated

Showing 20 out of 32 issues

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED 

RELEASED


---

## Page 14




---



--- OCR PAGE: page-01.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

Automatic In-Service GRD

Issue | Date

10 07 Dee
2020

141 08Dee
2020

12 10Dee
2020

13 18Dee
2020

14 O1 Feb
2021

2 04 Mar 2021

2111 Oct 2021

22 27 Oct 2021

23. 10Dec
2021

24 29.Jun 2022

26 28Aug
2022

27 O7 Sep
2022

28 2750p
2023

29 10Jan 2024

29.2 26 Jan 2024

29.3 06 Jun 2024

pea 11 Feb
2025

‘owner

‘Aol
Modanty

‘ot
Modanty

‘ot
Modanty

Aol
Modanty
‘Aol

Modanty

‘Aeot
Modantu
Aeot

Modanty

‘Aol
Modanty

‘ot
Modanty

‘ot
Modantu

‘ot
Modanty

Reot
Modantu

Aeot
Modanty

Reot
Modantu

Aeot
Modanty

Reot
Modantu

Aeot
Modantu

Table of Contents

ee

eee

1. References
2. Introduction

Status
Draft

Draft

jeady for

Ri
Review

Released

Ready for
Review

Released
Draft

Ready for
Review

Released
Released
Ready for

Review

jeady for

Ri
Review

Ready for
Review

Ready for
Review

Ready for
Review
Released

Released

Release Remarks

NA

NA

NA

NA

NA

NA

Initial import of existing content from.
‘Automatic IN Service (AINS) Generic Requirements Specification

Document # 1410-00117
Department: System Engineering
Revision #: 1.0,

Revision Date #: Oct 19, 2018

General editing and addition of SCG AINS specications.

Expansion of SCG AINS scenario and specification,
Fmoved all AINS disabled enabled pre-condiions.

Updated state dlagrams to enable transition from "IS-NR" to “OOS-AU, AINS" when no fault is present.
Updated SCH CTP "OLOS" to “ALL-CARRIER-FAIL” according to [GX 8915)

eworded failure condition requirements to clarity the role of supporting equipment.

Edited the RemValldSignalTimer range to include “0”. Edited the Trb:PTP AINS text to allow the associated client entity to go either in AINS or alarm
suppressio

Replaced with the direction attribute in alarms.
Fo-organized the state diagrams, requirements and tables for consistency and clarity.

Released Content for 1 version.
Updated AINS input signals on various objects. Added and removed a few defects ta/rom invalid signals for GX applicablty

Updated alarm masking requirements during AINS to include all SANSA alarms and updated the list of example alarms.
‘Added a reference for AINSIARC definitions.

Updated the GRD-469 to clay the allowed configuration changes between disabled and enabled.
Updated AINS state machine and clarified the state relationship between supporting/supported managed objects under AINS.

Released the updates after approval by the CCB according to [GX-33439}

Updated the GAD-477 requirement for AINS triggers per [GX-49460} to cover the exception for UCM.

Updated the GRD-479 requirement for TCA inhibition behavior per [GX-55425] to cover the related exception.

‘Added a note to clarity the handling of Controller Card alarms when the Transport Card entities are in AINS per [GX-55302)

Clariied the GRD-481, GRD-482, GRD-483 and GRD-484 requirements to specity the hosting/containing equipment.

Expanded the GRD-477 requirement to include Fiber-Channel-related triggers for upcoming products.

Generalized the descriptions and requirements throughout the document for applicability to various platform designs using Line-PTP and SCG-PTP.
Updated GRD-477 for FC triggers based on review comments.

Updated the GRD-477 requirement for invalid signal triggers on ODU per [GX- 124336}

Updated the GRD-476 and GRD-478 requirement for invalid signal triggers in CHMT per [GX-199332}

2.1. Automatic In-Service (AINS) Provisioning Overview
2.2. End-To-End Deployment Scenarios

" 2.2.1. AINS for Ethernet/OTN Services

" 2.2.2. AINS for Ethernet/OTN Adaptation

" 2.2.3. AINS for Line/SCG

3. Operational Impact
4. User Experience Considerations
5. AINS Requirements

5.1. Configuration Management
5.2. Fault Management and State Model
5.3. Feature Interaction

7. Reviews

7.1, Mandatory Reviewers
7.2. Jira Requirement Table

1. 1. References

1. GR-1093-CORE Generic State Requirements for Network Elements (NEs), Issue 2 June 2000
2. ITU-T Recommendation M.3100 - Generic network information model

6. Information Model for the AINS Feature



--- OCR PAGE: page-02.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

. Automatic In Service (AINS) GRD

. System State Management GRD

. Glossary and Abbreviations

. [THANOS-10096] AINS Clarifications/Updates - Infinera Jira

OR

2. 2. Introduction

2.1. 2.1. Automatic In-Service (AINS) Provisioning Overview

The AINS (Automatic In-Service) state is used during the provisioning of services in an alarm-free state. It can also be used to troubleshoot a faulty facility
(termination point) in an alarm-free state. The term “alarm-free state” in AINS means that, during the AINS state, the alarms on the equipment or
termination point will be masked and not reported to the management interfaces. Once the abnormal (faulty) condition has been cleared on the equipment
or termination point for a configured time period, the termination point is declared to be “In-Service”. If the fault condition re-occurs during the time when
the timer is active, the equipment/termination point transitions to Out-of-Service:AINS state and the valid signal timer is reset to its configured value.

The AINS feature can be applied to various types of termination points depending on the desired applications. One of the highly desired interfaces where
the AINS needs to be supported is at the boundary (edge point) where the client signal connects to the Infinera network. Within the scope of Infinera
termination points, this interface boundary is represented by the tributary port, aka Tributary Physical Termination Point (Trib-PTP). Another interface that
needs to support the AINS feature is at the boundary where the network signal connects to the client. Within the scope of Infinera termination points, this
interface is represented by the line port, aka Line Physical Termination Point (Line-PTP) or Super Channel Group Physical Termination Point (SCG-PTP).
These two interface boundaries are shown in the figure below.

Infinera Node
CPE Transceiver TOM Line Transceiver Network
Transceive
Client AINS Boundary Line AINS Boundary
Bi-Directional Bi-Directional
Trib-PTP Line-PTP/SCG-PTP

2.2. 2.2. End-To-End Deployment Scenarios

2.2.1. 2.2.1. AINS for Ethernet/OTN Services

‘An end-to-end deployment scenario for the operational use case is shown in the figure below.



--- OCR PAGE: page-03.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

TRIB AINS enabled TRIB AINS enabled
SNC

xGBE

xGBE

LOSYNC egress-LOSY?

Alarms Masked |@3 5@ Alarms Maske

Node A Node Z

As depicted in the figure above, the deployment scenario shows two network elements, Node A and Node Z, with 3x100GbE TOMs already provisioned on
each of the Nodes. The customer wants to add new capacity, with another 100GbE TOM. The goal is to ensure that the bring-up of services does not incur
any alarms on the network, as it generates unnecessary trouble tickets at the NOC.

In order to achieve this goal, the user simply configures the tributary Port 4 into AINS service, at both Node A and Node Z. If any alarms during the turn-up
starts to show up on tributary Port 4 or its associated 100GbE client, then it will be masked. Specifically, the LOSYNC at Node A, the egress-LOSYNC at
Node Z and the Sub-Network Connection (SNC) Fail alarms on Node A and Node Z will be masked. Thus, the network does not show up any alarms
during the bring-up time, also known as Valid Signal Timer, which is configurable by the user. When the fault conditions, LOSYNC and egress-LOSYNC,
are handled and fixed, usually by means of attaching a good source of client signal, the Port 4 at Node A and Node Z are bought into service automatically.

Please note that the same deployment scenario can be extended to OTUk transport services, with the only difference that the triggers for valid signal
determination is based on the OTUk facility failures. In case of Ethernet to OTN adaptation, there is one case worth describing and that is when the client
signal failure is transmitted to the OTN end when the encapsulated Ethernet client failure is present on the corresponding upstream node. Please see next
deployment scenarios for details.

2.2.2. 2.2.2. AINS for Ethernet/OTN Adaptation

The Ethernet/OTN Adaptation service comprises of an Ethernet Client Signal on one end and an OTUk Signal on the other end. These scenarios are
depicted in the following figures for unprotected and protected service scenarios respectively. The main point to bring out from these scenarios is the ability
to detect and report a Client Signal Failure condition (CSF) on the OTUk hand-off site, which is a result of a corresponding Ethernet Client Signal having a
facility failure.

In figure below, the unprotected SNC scenario, the CSF condition is detected at Node Z on the TRIB-ODU entity, due to LOSYNC failure of Ethernet Client

at Node A. Since the CSF is representing a client level failure, the AINS feature includes this condition into the invalid signal category. Thus, if AINS is
enabled on the tributary ports of Node A and Node Z, the alarms/conditions LOSYNC, CSF and SNCFAIL are masked.

Un-protected SNC

xGBE OTUk
<x ->@ (oe ex
LOSYNC Ch , |

T-oDU

+

OLOS....

Node A Node Z
C1: CSF condition

The figure below depicts a similar scenario, except that the protected services are deployed. In this scenario, the Ethernet client at Node A does not have
any outstanding alarm. However, due to an intermediate failure, the CSF is detected/asserted on the Line-ODU entity at Node Z. If the AINS is enabled on
the tributary port of Node Z, the alarms/conditions CSF and SNCFAIL are masked.



--- OCR PAGE: page-04.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

Protected SNC

OTUk

Node A Node 2 C14: CSF condition

2.2.3. 2.2.3. AINS for Line/SCG

As depicted in the figure below, the deployment scenario shows two network elements, Node A and Node Z, that provide transport services between the
clients already provisioned on each of the nodes. A critical OLOS alarm arises on the Line-/SCG-PTPs of Node A and Node Z when the optical fiber line
between the two nodes is disconnected. The NOC generates a trouble ticket and dispatches the field operations crew for investigation and repair. The goal
is to ensure the fault is isolated and the recovery of services will be automatic after the issue is resolved.

TRIB AINS TRIB AINS
SNC

xGBE

e ron Xe 1@
OLoSs od OLOS 2@

3@

Line/SCG AINS Enabled Line/SCG AINS Enabled Node Z

In order to achieve this goal, the operator simply configures the Line/SCG port into AINS mode, at both Node A and Node Z. If the OLOS alarm continues
to exist during the repair, then it will be masked. Thus, the network does not show up such alarms during the repair time, also known as Valid Signal Timer,
which is configurable by the user. When the fault conditions (OLOS) are handled and fixed, and the timer expires without detecting any OLOS faults, the
Line/SCG ports at Node A and Node Z are bought into service automatically. At this point, the normal alarm reporting is resumed on the Line/SCG ports of
both nodes.

3. 3. Operational Impact

The following items describe the importance of this feature in providing operational benefits for our customers.

1. Alarms reported, when they are not supposed to, cause operational personnel additional burden, cause NOC teams to unnecessarily spend time
and effort in handling trouble tickets.
2. False alarms cause considerable cost, time and effort towards operational expenses for our customers.
3. Extraneous alarms become visible everywhere in the network. Different operational personnel (other than service turn-up staff) monitoring alarms
in the network, get unnecessary trouble tickets.
4. Differentiating between true alarms vs false alarms becomes non-trivial when co-relating the alarms network-wide, between the Node A and Node
Zz.

4. 4. User Experience Considerations



--- OCR PAGE: page-05.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

The following are the considerations of this feature for providing the best user experience to our customers.
1. The purpose of AINS for turning up client services in an “alarm-free state” must be delivered with high quality.
2. The fault management (Alarm reporting) sub-system has to be robust with predictable, reliable and consistent behavior.

3. A system which is built with a solid fault management solution/otfering becomes a key component for retaining the value proposition as an
incumbent equipment provider.

5. 5. AINS Requirements

5.1. 5.1. Configuration Management

[| GRD-459 - Getting issue details... St ,tys | ] AINS Support on TRIB interface

The Infinera NE shall support the Automatic In-Service (AINS) provisioning feature on the TRIB-PTP of all the circuit pack types which has a tributary
interface to the client equipment. Furthermore, the AINS feature shall be supported for both the pre-provisioning and auto-provisioning cases.

[ GRD-460 - Getting issue details... St,~tys _] AINS Support on Line/SCG interface

The Infinera NE shall support the Automatic In-Service (AINS) provisioning feature on the Line-PTP/SCG-PTP of all the circuit pack types which has a
line interface to the network. Furthermore, the AINS feature shall be supported for both the pre-provisioning and auto-provisioning cases.

The TRIB-PTP and Line-/SCG-PTP are specifically selected as the choice of termination points to support AINS feature because during test and turn-up
(or troubleshooting) of the client and line signals coming into Infinera network node, the TRIB-PTPs and Line-/SCG-PTPs act as the edge points of the
network and client boundary. It is to be noted that when the AINS feature is applied to the TRIB-PTP, the corresponding client shall also be placed either in
the AINS state or in an alarm suppression state.

NOTE: The AINS feature can also be applied to other termination points (OTS, OCG etc.) and equipment types which is not required immediately and can

be supported in the future. If and when this is needed, this GRD will be updated to include the definitions of abnormal conditions on these equipment and
termination points.

[ GRD-461 - Getting issue details... Statys _] AINS configuration

The NE shall allow the configuration of AINS state on the TRIB-PTP and Line-PTP/SCG-PTP using the attribute “AINS" as defined in the information
model table.

[| GRD-462 - Getting issue details... cratyg _] AINS default template support

The NE shall allow the management interfaces to provision the AINS configuration specified in GRD-459 and GRD-460 using the default template
mechanism that is provided on a per NE basis. Changes to the AINS configuration using the default template shall be allowed all the time without any
preconditions. Furthermore, the changes made to the AINS configuration in the default template will take effect on the TRIB-PTPs and Line-PTP/SCG-
PTPs that are created subsequently after the change is made to the default template.

NOTE: Changing the AINS configuration on an already provisioned TRIB-PTPs and Line-/SCG-PTPs shall follow the rules as specified in GRD-469.
[| GRD-463 - Getting issue detalls... | Sr ,tys | ] Overriding the AINS configuration in the default template configuration

In addition to supporting the configuration through the default template, the NE shall allow the configuration of AINS on a per TRIB-PTP and per Line-
PTP/SCG-PTP basis.

This requirement is used to cover the following two use cases:
1. When the AINS template value is set to disabled and the user wants to provision a particular TRIB or Line/SCG port using the AINS state.
2. When the AINS template value is set to enabled, the TRIB or Line/SCG port was earlier brought into service. However, there is a recurring fault
on the TRIB/Client or Line/SCG port on which the user wants to apply the AINS feature.

NOTE: The AINS feature shall not be limited to just during test and turn-up but can be applied any time on the TRIB or Line/SCG interfaces.

[| GRD-464 - Getting issue details... sratyg | ] Configuration of Valid Signal Timer Value

The NE shall allow the configuration of AINS Valid Signal Timer value on the TRIB-PTP and Line-PTP/SCG-PTP using the attribute
“ValidSignalTimelnterval” as defined in the information model table. The standard value range-check shall also be supported.



--- OCR PAGE: page-06.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[| GRD-465 - Getting issue detalls.../ Gr ,zys | ] Default template support for Valid Signal Timer configuration

The NE shall allow the configuration of ValidSignalTimeinterval specified in GRD-464 using the default template mechanism that is provided on a per
NE basis. Changes to the ValidSignalTimeinterval configuration using the default template shall be allowed at all times without any pre-conditions.
Further, the changes made to the ValidSignalTimelnterval configuration in the default template will take effect on the TRIB-PTPs and Line-PTP/SCG-
PTPs that are created subsequently after the change is made to the default template.

[| GRD-466 - Getting issue details... Gratyg | |] Overtiding the Valid Signal Timer value configuration in the default template
configuration

In addition to supporting the configuration through the default template, the NE shall allow the configuration of ValidSignalTimelnterval specified in GRD-
464 on a per TRIB-PTP and per Line-PTP/SCG-PTP basis.

[| GRD-467 - Getting issue detalls...” cr,tyg | ] Retrieval of the Remaining Valid Signal Timer Value

The NE shall support the retrieval of the Time Remaining for the configured valid signal timer to expire. The attribute “RemValidSignalTimer” as defined
in the information model table shall be used.

In order to get the time remaining for the valid signal timer, the user shall explicitly execute a retrieval operation from the NE, through the management
interface. There will not be any autonomous notifications (AVCs) sent by the NE for the remaining valid signal timer value.

[| GRD-468 - Getting issue details...’ St,tyg _] Format of Remaining Valid Signal Timer Value

The management interfaces shall support a user-friendly interface for the configuration and display of the timer values in the following format.
* DD-HH-MM
DD: Number of days. Values are from 00 to 05 days.
HH: Number of hours. Values are from 00 to 23.
‘MM: Number of minutes. Values are from 00 to 59.

Note: The maximum value of the timer shall be 5 days.

[| GRD-469 - Getting issue detalls.../ Gr ,tys | ] No pre-condition for changing AINS configuration between Disabled and Enabled

When performing AINS configuration on an already provisioned TRIB-PTP or Line-PTP/SCG-PTP, the NE shall allow changing the AINS configuration tr
eely between Disabled and Enabled at any time irrespective of the state of TRIB-PTP or Line-PTP/SCG-PTP or the value of RemValidSignalTimer.

Note: This allows users to disable or enable AINS regardless of fault conditions or states. Enabling AINS without a fault still takes the entity out of
service, but the supported entities stay in service.

Please note that throughout this document, a Client CTP refers to all the Client CTPs listed in GRD-477, depending on the applicability and deployment
scenario. The above requirement is used to cover the case where the user wants to disable the AINS feature and start monitoring the faults again.

[| GRD-470 - Getting issue detalls.... Sr ,tys | ] Allow AdminState Lock and Maintenance when AINS is enabled

The NE shall allow a TRIB-PTP or Line-PTP/SCG-PTP which is in AINS state to be configured to the Locked or Maintenance state.

[| GRD-471 - Getting issue detalls.... Gr ,tyg | ] No impact to existing AINS configuration when default template is updated

The NE shall ensure that changing the AINS configuration in the default template shall not cause the change in value of AINS on an already provisioned
TRIB-PTP or Line-PTP/SCG-PTP.

[| GRD-472 - Getting issue detalls... | Sr ,tys | ] No impact to default template when TRIB/Line/SCG AINS is updated

The NE shall ensure that changing the AINS configuration on an individual TRIB-PTP or Line-PTP/SCG-PTP shall not cause the value in the default
template to be changed.

[| GRD-473 - Getting issue details... ¢r,tyg | |] No impact to existing AINS Valid Signal Time Interval configuration when default
template is updated

The NE shall ensure that changing the ValidSignalTimeinterval in the default template shall not cause the change in value of ValidSignalTimelnterval
already provisioned on the TRIB-PTP or Line-PTP/SCG-PTP.



--- OCR PAGE: page-07.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[| GRD-474 - Getting issue detalls... | Sr ,zys | ] No impact to default template when Valid Signal Time Interval is updated on TRIB/Line
ISCG

The NE shall ensure that changing the ValidSignalTimeinterval on an individual TRIB-PTP or Line-PTP/SCG-PTP shall not cause the value in the
default template to be changed.

[| GRD-475 - Getting issue details... Gr,tyg | |] No pre-conditions for changing the Valid Signal Time Interval

The NE shall allow changing the ValidSignalTimeinterval value at any time using the default template method or on an individual TRIB-PTP or Line-PTP
/SCG-PTP irrespective of the state of the TRIB-PTP/Client CTP, Line-PTP/SCG-PTP/SCH CTP, or the value of RemValidSignalTimer. When such a
change is done on already provisioned TRIB-PTP or Line-PTP/SCG-PTP, and if the RemValidSignalTimer is active (decrementing), the value of
RemValidSignalTimer shall be set to the new value of ValidSignalTimeinterval immediately.

5.2. 5.2. Fault Management and State Model
[| GRD-476 - Getting issue details... cr ,~tyg | | Transition into in-service state upon expiry of VS Timer

When the AINS feature is enabled on a TRIB-PTP or Line-PTP/SCG-PTP, the NE shall monitor for the presence of a valid signal on the TRIB-PTP and
the corresponding Client CTP, or Line-PTP/SCG-PTP and the corresponding Line CTP for the entire duration of Valid Signal Timer before transitioning
to an in-service state. Depending on the occurrence or absence of a fault before or after timer expires, the following cases shall be supported according
to the following state diagram:

* Upon expiry of the Valid Signal Timer, if there were no faults detected either on the TRIB-PTP or the corresponding Client CTP, Line-PTP/SCG-
PTP or the corresponding Line CTP for the entire duration of the timer, the TRIB-PTP and the Client CTP, or the Line-PTP/SCG-PTP and the Line
CTP shall transition to an “In-Service” state with AINS value set to disabled.

© Ifthe fault condition(s) occurs on the TRIB-PTP or Client CTP, the Line-PTP/SCG-PTP or Line CTP before the Valid Signal Timer expires, the
TRIB-PTP and the corresponding Client CTP, or the Line-PTP/SCG-PTP and the corresponding Line CTP shall transition to “Out-of-Service” state
(operational state=disabled) with AINS value set to enabled.

Generic State Diagram for the AINS feature

(utot Service, ANS: No Alarm Reportng
(Out-of-Service, AINS ‘AINS-CD: No Alarm Rortng  Countng Down
‘AINS-NR: No lar Rearing Not Ready

In-Service: Alar Reporting Aloued
(Out of Sericelaintsnance: Aarms Not Mentored

timer e100

The presence of “fault” conditions or “abnormal” conditions or “invalid signal” is defined as the presence of an alarm which causes a Facility Failure (FAF)
state for the termination point. The FAF state (NE operational state qualifier=Faulted) is an out-of-service state.

The following requirements shall be used for triggering the FAF on TRIB-PTP, Line-PTP/SCG-PTP, Client CTPs, and SCH CTP that results in transition
into AINS or out of AINS state.



--- OCR PAGE: page-08.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[| GRD-477 - Getting issue details... | Gr ,tys | ] Facility Failures - Invalid Signal Failures for the TRIB AINS feature

The NE shall use the service-atfecting alarms that contribute to the TRIB-PTP and the Client CTP facilities, and the supporting equipment for declaring
the signal as “invalid signal”.

For example (may not be a complete list of service-affecting alarms applicable to each facility):

* TRIB-PTP: OLOS, CDR-LOL
* Client CTPs:
SONET Client-CTP: ingress/egress LOF, ingress/egress AIS-L
SDH Client-CTP: ingress/egress LOF, ingress/egress MS-AIS
GbE Client-CTP: ingress/egress LOSYNC, ingress/egress LF, ingress/egress RF, ingress/egress HIBER, ingress LOA, ingress LOLM
OTU Client-CTP: ingress/egress LOF, ingress LOM, ingress LOL
ODU Client-CTP (service-mode=network-wrapper): egress CSF, egress AIS, egress OCI, egress LCK, PLM, TIM
= Note: As an exception, UCM4 in service-mode=switching considers the specified ODU Client-CTP alarms as invalid signals for AINS.
FC Client-CTP: ingress/egress LOSYNC, ingress/egress HIBER, ingress/egress LF, ingress/egress RF, ingress LOS, ingress LFA (FEC
enabled)
* Equipment (TOM or its supporting equipment; OTM, TIM, LM, TAM, etc.): EQPTFAIL, IMPROPRMVL, EQPTCOMFAIL, PWR-CLASS-
UNSUPPORTED

[| GRD-478 - Getting issue detalls.../ Sr ,tyg | ] Facility Failures - Invalid Signal Failures for the Line/SCG AINS feature

The NE shall use the following failure conditions that contribute to the Line-PTP/SCG-PTP and the SCH CTP facilities for declaring the signal as “invalid
signal”.

* Line-PTP/SCG-PTP: OLOS
* Line CTPs:
SCH-CTP: ALL-CARRIER-FAIL
Carrier-CTP (CHM7): COH-LOL, POST-FEC-Q-SIGNAL-FAILURE
* Equipment (line transceiver equipment or its supporting equipment): EQPTFAIL, IMPROPRMVL

[| GRD-479 - Getting issue detalls.... cr ,tyg | ] Alarm Masking when in AINS enabled state

When the AINS feature is enabled on the TRIB-PTP or Line-PTP/SCG-PTP, any alarms occurring on the TRIB-PTP and its corresponding Client CTP,
the Line-PTP/SCG-PTP and its corresponding SCH CTP, and the SNC (if present) shall not be reported to the management interfaces.

Note 1: Threshold Crossing Alerts (TCA) are not suppressed or inhibited when AINS is enabled in the GX line of products.

Note 2: Alarms that are managed in the controller card but dependent on the transport card, such as COMM-CHNL-DOWN, are not suppressed or
inhibited when AINS is enabled in the GX line of products.

When the AINS is enabled and the AINS remaining valid signal timer is decrementing, the data plane traffic is up and running. Only the alarm reporting is

turned off during AINS state.

State Transitions for the Trib-PTP AINS feature

The following figure illustrate the state transitions for the Trib-PTP AINS provisioning.



--- OCR PAGE: page-09.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+|n-Service+GRD

A

@) Plugin TOM

Valid signal oo.
Invalid signal

Valid signal

AS=UnLocked AS=UnLocked

OS=Enabled OS=Disabled
AINS=Enabled Invalid rl AINS=Enabled
(OOS-AU, AINS) nvalic'signa (OOS-AU, FAF&AINS)

Alarm reporting is Disabled
Timer value does not decrement

Alarm reporting is disabled
Timer starts decrementing

Timer Expires EDIT:IS

EDIT:AINS EDIT:AINS

Fault AS=UnLocked

AS=UnLocked

OS= bled Recover OS=Disabled
= Enadie OpStateQualifier=Faulted
AINS=Disabled AINS=Disabled
(IS-NR)

(OOS-AU, FAF)
Alarm reporting is Enabled
Timer is not applicable

Alarm reporting is Enabled
Timer reset to its configured value

[ GRD-480 - Getting issue details..." St,tys | ] Reset of Valid Signal Timer upon detecting fault

During the time RemValidSignalTimer is active (decrementing), If any of the faults as specified in GRD-477 or GRD-478 is detected by the NE, the
Rem\ValidSignalTimer value shall be reset to the configured value for ValidSignalTimeinterval.

[| GRD-481 - Getting issue details... cratyg | |] Cold reset behavior - Chassis equipment hosting transceivers/TOMs

It is acceptable that a cold reset of the associated chassis controller card equipment resets the RemValidSignalTimer value to the configured value for
ValidSignalTimeinterval.

[| GRD-482 - Getting issue details... sr,tyg | ] Warm reset behavior - Chassis equipment hosting transceivers/TOMs

During the time RemValidSignalTimer is active (decrementing), it is acceptable that a warm reset of the associated chassis controller card equipment
continues to decrement the Rem\ValidSignalTimer value.

[ GRD-483 - Getting issue details... ¢r,tyg | ] Cold/Warm reset behavior - Transport equipment containing transceivers/TOMs

During the time RemValidSignalTimer is active (decrementing), it is acceptable that a cold/warm reset of the associated transport card resets the
Rem\ValidSignalTimer value to the configured value for ValidSignalTimelnterval.



--- OCR PAGE: page-10.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[| GRD-484 - Getting issue details... Gt,tys | ] Controller Card reset or active switch

Itis desirable that a node controller card reboot or switch-over shall not trigger the reset of RemValidSignalTimer value to the configured value for
ValidSignalTimelnterval.

The above objective is desirable to cover the case of not restarting AINS feature all over again when the controller resets or a controller activity switch
takes place.

[| GRD-485 - Getting issue detalls.../ St ,tyg | ] Control Plane Failure when VS Timer is active

During the time RemValidSignalTimer is active (decrementing) and the control plane connectivity between the tributary module hosting the TOM or the
line module, and controller module is down, then it is acceptable that the RemValidSignalTimer continues to decrement, and the state transitions are
carried accordingly.

[| GRD-486 - Getting issue detalls.... cr ,zyg | ] Control Plane failure when fault is outstanding

When AINS is enabled on the TRIB-PTP or Line-PTP/SCG-PTP with any of the outstanding fault specified in GRD-477 and GRD-478, and a control
plane failure is also present between the tributary module hosting the TOM or the line module and controller module, then it is acceptable that the AINS
state is held until the control plane is recovered and the fault conditions are re-evaluated accordingly. The following cases shall be handled.

1. When the control plane is recovered and there is no fault present as specified in GRD-477 and GRD-478, then the RemValidSignalTimer starts
decrementing from the configured value for ValidSignalTimeinterval.

2. When the control plane is recovered and there is any fault present as specified in GRD-477 and GRD-478, then the RemValidSignalTimer is reset
to the configured value for ValidSignalTimeinterval. No count-down of RemValidSignalTimer occurs in this scenario as there is still a fault present.

[ GRD-487 - Getting issue details... sr,tyg | ] Path level failures - CTP

It is acceptable that the NE do not mask the path level faults (e.g. DTP in DTN and ODU in XTN) when the TRIB-PTP or Line-PTP/SCG-PTP is in the
AINS enabled state.

Itis expected that the Infinera network-side faults are useful to be reported to isolate the failure inside the Infinera network. The AINS feature is used only
at the edge point where the tributary/client signals and line signals are monitored for faults during turn up or troubleshooting. Note that the ODU-level CSF
is considered a client signal failure and is included in the AINS hierarchy.

[| GRD-488 - Getting issue detalls... | cr ,tyg | ] SNC Alarm masking resulting from TRIB/Client or Line/SCG Failures

The NE shall mask the SNC failure alarm which results from the faults specified in GRD-477 and GRD-478, and the corresponding TRIB-PTP or Line-
PTP/SCG-PTP on which SNC is created is in the AINS enabled state.

There are no separate timers provided for SNCs or Client Termination Points. The timers (both RemValidSignalTimer and ValidSignalTimelnterval) are
provided only on the TRIB-PTP and Line-PTP/SCG-PTP. If the user wants to check how much time is remaining before SNC or a client termination point
transition to In-Service state, he/she shall explicitly perform a retrieval operation on the corresponding TRIB-PTP or Line-PTP/SCG-PTP managed object
where SNC or Client Termination Point resides.

Interaction between Trib-PTP AINS, SNC and Client-CTP states

The following state transition diagram illustrates state transitions that are supported for the AINS states between the Trib-PTP, SNC and Client CTP.



--- OCR PAGE: page-11.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

TRIB PTP: In-Service
Client: In-Service
SNC: In-Service

AINS=Disabled for TRIBPTP,

Client and SNC

EDIT:SNC
Maintenance

EDIT:SNC
Unlock

TRIB PTP: AINS
Client: Out-of-service, SGEO
SNC: Maintenance
AINS=Enabled for TRIBPTP

Timer Expires
or EDIT-TRIB:IS

TRIB PTP: In-Service
Client: In-Service
SNC: Maintenance
AINS=Disabled for TRIBPTP,
Client and SNC

EDIT-TRIB:AINS Timer Decrementing

Fault on TRIB PTP
before timer expired

Fault
Recover

Fault

Fault on TRIB PTP
Recover

TRIB PTP: Out-of-service,
Faulted
Client: Out-of-service, SGEO
SNC: Maintenance
AINS=Disabled for TRIBPTP,
Client and SNC

TRIB PTP: AINS&faulted
Client: Out-of-service, SGEO
SNC: Maintenance
AINS=Enabled for TRIBPTP

EDIT:IS

EDIT-TRIB:AINS

[ GRD-489 - Getting issue details...

STATUS | ] SNC alarms resulting from Path level faults

It is acceptable that the SNC failure alarm be reported at all times (irrespective of corresponding TRIB or Line/SCG being in AINS enabled or disabled
mode) when there is a path (DTP/ODU) level fault present in any of the path points of the SNC.

The SNC failure alarms resulting from the DTP/ODU-level faults will be useful for debugging the problem in the Infinera network. Note that the only
exception to the above requirement is ODU-level CSF failure, which is considered as a client failure and is include in the AINS Facility Failure Condition,
thus masking the SNC fail alarm.

5.3. 5.3. Feature Interaction



--- OCR PAGE: page-12.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[| GRD-490 - Getting issue detalls.../ Gr ,tys | ] AINS and Other Feature interaction

The NE shall continue to support the existing features. The features covered in this GRD shall coexist with existing features already supported. There
shall be no loss of functionality as a result of adding the AINS feature support. The following are the important features identified to have some feature
interaction that shall be tested and verified

1. LED behavior: No changes to the LED behavior.

2. SWIDB upgrade: The AINS and valid signal time interval values will be backed up and restored per the existing SW/DB upgrade procedure.

3. Protection Switching: The PG creation and TRIB-PTP PU selection per the existing behavior shall continue to be supported. Fault detection and
protection switching upon the existing triggers continues to be supported when in the AINS enabled state (i.e. when the RemValidSignalTimer is
active and decrementing). Both 1-port and 2-port protection shall be certified with AINS.

. Diagnostics: Ability to perform diagnostics in maintenance state shall continue to be supported.

. Performance Monitoring: The NE should continue to collect the PM data (real time and historical) when the TRIB-PTP is in the AINS enabled state.
Further, the PM buckets shall not be marked invalid due to AINS state. The existing rules for marking PM buckets validity shall prevail

6. Equipment Provisioning: The AINS feature defined shall be applicable to all the equipment type where the applicable tributary or line interfaces are
present. Also, the existing equipment provisioning methodology shall not be changed to support AINS.

. Service Provisioning: The existing methods of creating the manual cross-connects or SNCs shall be used.

. OTN mappings: Where applicable, all type of network mappings shall be supported with deployment scenarios: SNC endpoints with source to
destination clients as: GBE to GBE, GBE to OTUk, OTUk to OTUK
9. The SNC masking shall be done for both LOCAL SNC and REMOTE SNCs depending on the TRIB AINS configuration on the corresponding

endpoints.

10. Masking of TRIB, Client, Line/SCG, SCH and SNCs alarms listed in this GRD shall be certified for the multiplexing scenarios.

an

on

6. 6. Information Model for the AINS Feature

NE AttributeName  Access/Role Possible Values Default ~—_Description/Behavior
AINS RW Disabled This attribute is used to configure the AINS feature on the TRIB or Line/SCG interface.

* Enabled

© Disabled
ValidSignalTimelnterval RW 107200 minutes 480 minutes | This attribute is used to configure the valid signal timer for the AINS feature on TRIB or Line/SCG interfaces.

‘The value is configurable in 1-minute granularity.

RemValidSignalTimer RO 0107200 minutes NA This attribute is used to display the remaining valid signal timer value.

The value is reported in 1-minute granularity,

7. 7. Reviews

7.1. 7.1. Mandatory Reviewers

Reviewed/Approved Reviewed/Concerns raised, not ready to approve.

Sharfuddin Syed 16 Dee 2020 @<reviewer-name> //<date>
Nuno Pereira 16 Dec 2020
Channabasava Yadrami 16 Dec 2020

Unknown User (tstafford) 16 Dec 2020
Prasanna Jaikrishnamoorthy 16 Dec 2020
Unknown User (kkasiviswanathan) 16 Dec 2020

7.2. 7.2. Jira Requirement Table

T Key Summary Status Labels



--- OCR PAGE: page-13.png ---

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

© —_ GRD-490 _AINS and Other Feature interaction
© — GRD-489_ SNC alarms resulting from Path level faults
© —_GRD-488_ SNC Alarm masking resulting from TRIB/Client or SCG Failures
© — GRD-487 Path level failures - CTP
© —_GRD-486 Control Plane failure when fault is outstanding
© — GRD-485__ Control Plane Failure when VS Timer is active
© —_GRD-484 Controller Card reset or active switch
© —_ GRD-483_Cold/Warm reset behavior - Transport equipment containing transceivers/TOMs
© —_GRD-482_ Warm reset behavior - Chassis equipment hosting transceivers/TOMs
© —_ GRD-481 Cold reset behavior - Chassis equipment hosting transceivers/TOMs
© —_GRD-480_ Reset of Valid Signal Timer upon detecting fault
© —_GRD-479 Alarm Masking when in AINS enabled state
© —_GRD-478 Facility Failures - Invalid Signal Failures for the Line/SCG AINS feature
© — GRD-477_ Facility Failures - Invalid Signal Failures for the TRIB AINS feature
© —_GRD-476 Transition into in-service state upon expiry of VS Timer
© — GRD-475_No pre-conditions for changing the Valid Signal Time Interval
© — GRD-474 _No impact to default template when Valid Signal Time Interval is updated on TRIB/SCG
© GRD-473_No impact to existing AINS Valid Signal Time Interval configuration when default template is
update
© — GRD-472_No impact to default template when TRIB/Line/SCG AINS is updated
° GRD-471 No impact to existing AINS configuration when default template is updated

Showing 20 out of 32 issues
