<!-- Converted from: Automatic_In-Service_GRD.pdf -->

## Page 1

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

Automatic In-Service GRD

Issue Date

Owner

Status

Release Remarks

1.0

07 Dec 
2020

Aref 
Modanlu

Draft

N/A

Initial import of existing content from:

Automatic IN Service (AINS) Generic Requirements Specification

1.1

1.2

1.3

1.4

09 Dec 
2020

10 Dec 
2020

18 Dec 
2020

01 Feb 
2021

Aref 
Modanlu

Aref 
Modanlu

Aref 
Modanlu

Aref 
Modanlu

Document # 1410-001177
Department: System Engineering
Revision #: 1.0
Revision Date #: Oct 19, 2018

Draft

N/A

General editing and addition of SCG AINS specifications.

Ready for 
Review

N/A

Expansion of SCG AINS scenario and specification.
Removed all AINS disabled enabled pre-conditions.
Updated state diagrams to enable transition from "IS-NR" to "OOS-AU, AINS" when no fault is present.
Updated SCH CTP "OLOS" to "ALL-CARRIER-FAIL" according to 

[GX-8915]

.

Released

N/A

Reworded failure condition requirements to clarify the role of supporting equipment.

Ready for 
Review

N/A

Edited the RemValidSignalTimer range to include "0". Edited the Trib-PTP AINS text to allow the associated client entity to go either in AINS or alarm 
suppression.
Replaced "DE-ENCAP" with the direction attribute in alarms.
Re-organized the state diagrams, requirements and tables for consistency and clarity.

2

04 Mar 2021  Aref 

Released

N/A

Released Content for 1 version.

Modanlu

2.1

11 Oct 2021  Aref 

Draft

Modanlu

2.2

27 Oct 2021  Aref 

2.3

10 Dec 
2021

Modanlu

Aref 
Modanlu

Ready for 
Review

N/A

N/A

Updated AINS input signals on various objects. Added and removed a few defects to/from invalid signals for GX 
Updated alarm masking requirements during AINS to include all SA/NSA alarms and updated the list of example alarms.

applicability

.

Added a reference for AINS/ARC definitions.
Updated the GRD-469 to clarify the allowed configuration changes between disabled and enabled.
Updated AINS state machine and clarified the state relationship between supporting/supported managed objects under AINS.

Released

N/A

Released the updates after approval by the CCB according to 

[GX-33439]

.

2.4

29 Jun 2022  Aref 

Released

N/A

Updated the GRD-477 requirement for AINS triggers per 

[GX-49460]

 to cover the exception for UCM4.

2.6

2.7

2.8

24 Aug 
2022

07 Sep 
2022

27 Sep 
2023

Modanlu 

Aref 
Modanlu 

Aref 
Modanlu 

Aref 
Modanlu 

2.9

10 Jan 2024  Aref 

Modanlu 

2.9.2 26 Jan 2024  Aref 

Modanlu 

Ready for 
Review

Ready for 
Review

Ready for 
Review

Ready for 
Review

Ready for 
Review

N/A

Updated the GRD-479 requirement for TCA inhibition behavior per 
Added a note to clarify the handling of Controller Card alarms when the Transport Card entities are in AINS per 

 to cover the related exception.

[GX-55425]

[GX-55302]

.

N/A

Clarified the GRD-481, GRD-482, GRD-483 and GRD-484 requirements to specify the hosting/containing equipment.

N/A

Expanded the GRD-477 requirement to include Fiber-Channel-related triggers for upcoming products.

N/A

Generalized the descriptions and requirements throughout the document for applicability to various platform designs using Line-PTP and SCG-PTP. 

N/A

Updated GRD-477 for FC triggers based on review comments.

2.9.3 06 Jun 2024  Aref 

Released

N/A

Updated the GRD-477 requirement for invalid signal triggers on ODU per 

[GX-124336]

.

Released

N/A

Updated the GRD-476 and GRD-478 requirement for invalid signal triggers in CHM7 per 

[GX-193332]

.

2.94

11 Feb 
2025

Modanlu 

Aref 
Modanlu 

Table of Contents

1. References
2. Introduction

2.1. Automatic In-Service (AINS) Provisioning Overview
2.2. End-To-End Deployment Scenarios

2.2.1. AINS for Ethernet/OTN Services
2.2.2. AINS for Ethernet/OTN Adaptation
2.2.3. AINS for Line/SCG

3. Operational Impact
4. User Experience Considerations
5. AINS Requirements

5.1. Configuration Management
5.2. Fault Management and State Model
5.3. Feature Interaction
6. Information Model for the AINS Feature
7. Reviews

7.1. Mandatory Reviewers
7.2. Jira Requirement Table

1. 1. References

1.  
2.  

GR-1093-CORE Generic State Requirements for Network Elements (NEs), Issue 2 June 2000
ITU-T Recommendation M.3100 - Generic network information model

3.


---

## Page 2

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

3.  
4.  
5.  
6.  

Automatic In Service (AINS) GRD
System State Management GRD
Glossary and Abbreviations
[THANOS-10096] AINS Clarifications/Updates - Infinera Jira

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

2.2. 2.2. End-To-End Deployment Scenarios

2.2.1. 2.2.1. AINS for Ethernet/OTN Services

An end-to-end deployment scenario for the operational use case is shown in the figure below.


---

## Page 3

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

As depicted in the figure above, the deployment scenario shows two network elements, Node A and Node Z, with 3×100GbE TOMs already provisioned on 
each of the Nodes. The customer wants to add new capacity, with another 100GbE TOM. The goal is to ensure that the bring-up of services does not incur 
any alarms on the network, as it generates unnecessary trouble tickets at the NOC.

In order to achieve this goal, the user simply configures the tributary Port 4 into AINS service, at both Node A and Node Z. If any alarms during the turn-up 
starts to show up on tributary Port 4 or its associated 100GbE client, then it will be masked. Specifically, the LOSYNC at Node A, the egress-LOSYNC at 
Node Z and the Sub-Network Connection (
during the bring-up time, also known as Valid Signal Timer, which is configurable by the user. When the fault conditions, LOSYNC and egress-LOSYNC, 
are handled and fixed, usually by means of attaching a good source of client signal, the Port 4 at Node A and Node Z are bought into service automatically.

 Fail alarms on Node A and Node Z will be masked. Thus, the network does not show up any alarms 

SNC)

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

The figure below depicts a similar scenario, except that the protected services are deployed. In this scenario, the Ethernet client at Node A does not have 
any outstanding alarm. However, due to an intermediate failure, the CSF is detected/asserted on the Line-ODU entity at Node Z. If the AINS is enabled on 
the tributary port of Node Z, the alarms/conditions CSF and SNCFAIL are masked.


---

## Page 4

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

2.2.3. 2.2.3. AINS for Line/SCG

As depicted in the figure below, the deployment scenario shows two network elements, Node A and Node Z, that provide transport services between the 
clients already provisioned on each of the nodes. A critical OLOS alarm arises on the Line-/SCG-PTPs of Node A and Node Z when the optical fiber line 
between the two nodes is disconnected. The NOC generates a trouble ticket and dispatches the field operations crew for investigation and repair. The goal 
is to ensure the fault is isolated and the recovery of services will be automatic after the issue is resolved.

In order to achieve this goal, the operator simply configures the Line/SCG port into AINS mode, at both Node A and Node Z. If the OLOS alarm continues 
to exist during the repair, then it will be masked. Thus, the network does not show up such alarms during the repair time, also known as Valid Signal Timer, 
which is configurable by the user. When the fault conditions (OLOS) are handled and fixed, and the timer expires without detecting any OLOS faults, the 
Line/SCG ports at Node A and Node Z are bought into service automatically. At this point, the normal alarm reporting is resumed on the Line/SCG ports of 
both nodes.

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
the AINS state or in an alarm suppression state.

either 

in 

NOTE: The AINS feature can also be applied to other termination points (OTS, OCG etc.) and equipment types which is not required immediately and can 
be supported in the future. If and when this is needed, this GRD will be updated to include the definitions of abnormal conditions on these equipment and 
termination points.

[ 

GRD-461 Getting issue details...

 - 

STATUS

 ]

 AINS configuration

The NE shall allow the configuration of AINS state on the TRIB-PTP and Line-PTP/SCG-PTP using the attribute “AINS” as defined in the information 
model table

.

[ 

GRD-462 Getting issue details...

 - 

STATUS

 ]

 AINS default template support

The NE shall allow the management interfaces to provision the AINS configuration specified in 
mechanism that is provided on a per NE basis. Changes to the AINS configuration using the default template shall be allowed all the time without any 
preconditions. Furthermore, the changes made to the AINS configuration in the default template will take effect on the TRIB-PTPs and Line-PTP/SCG-
PTPs that are created subsequently after the change is made to the default template.

 using the default template 

GRD-460

GRD-459

 and 

NOTE: Changing the AINS configuration on an already provisioned TRIB-PTPs and Line-/SCG-PTPs shall follow the rules as specified in 

GRD-469

.

[ 

GRD-463 Getting issue details...

 - 

STATUS

 ]

 Overriding the AINS configuration in the default template configuration

In addition to supporting the configuration through the default template, the NE shall allow the configuration of AINS on a per TRIB-PTP and per Line-
PTP/SCG-PTP basis.

This requirement is used to cover the following two use cases:

1.  
2.  

When the AINS template value is set to disabled and the user wants to provision a particular TRIB or Line/SCG port using the AINS state.
When the AINS template value is set to enabled, the TRIB or Line/SCG port was earlier brought into service. However, there is a recurring fault 
on the TRIB/Client or Line/SCG port on which the user wants to apply the AINS feature.

NOTE: The AINS feature shall not be limited to just during test and turn-up but can be applied any time on the TRIB or Line/SCG interfaces.

[ 

GRD-464 Getting issue details...

 - 

STATUS

 ]

 Configuration of Valid Signal Timer Value

The NE shall allow the configuration of AINS Valid Signal Timer value on the TRIB-PTP and Line-PTP/SCG-PTP using the attribute 
“ValidSignalTimeInterval” as defined in the 

. The standard value range-check shall also be supported.

information model table


---

## Page 6

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[ 

GRD-465 Getting issue details...

 - 

STATUS

 ]

 Default template support for Valid Signal Timer configuration

The NE shall allow the configuration of ValidSignalTimeInterval specified in 
NE basis. Changes to the ValidSignalTimeInterval configuration using the default template shall be allowed at all times without any pre-conditions. 
Further, the changes made to the ValidSignalTimeInterval configuration in the default template will take effect on the TRIB-PTPs and Line-PTP/SCG-
PTPs that are created subsequently after the change is made to the default template.

 using the default template mechanism that is provided on a per 

GRD-464

[ 

GRD-466 Getting issue details...

 - 

STATUS

 ]

 Overriding the Valid Signal Timer value configuration in the default template 

configuration

In addition to supporting the configuration through the default template, the NE shall allow the configuration of ValidSignalTimeInterval specified in GRD-
464

 on a per TRIB-PTP and per Line-PTP/SCG-PTP basis.

[ 

GRD-467 Getting issue details...

 - 

STATUS

 ]

 Retrieval of the Remaining Valid Signal Timer Value

The NE shall support the retrieval of the Time Remaining for the configured valid signal timer to expire. The attribute “RemValidSignalTimer” as defined 
in the 

information model table

 shall be used.

In order to get the time remaining for the valid signal timer, the user shall explicitly execute a retrieval operation from the NE, through the management 
interface. There will not be any autonomous notifications (AVCs) sent by the NE for the remaining valid signal timer value.

[ 

GRD-468 Getting issue details...

 - 

STATUS

 ]

 Format of Remaining Valid Signal Timer Value

The management interfaces shall support a user-friendly interface for the configuration and display of the timer values in the following format.

DD-HH-MM

DD: Number of days. Values are from 00 to 05 days.
HH: Number of hours. Values are from 00 to 23.
MM: Number of minutes. Values are from 00 to 59.

Note: The maximum value of the timer shall be 5 days.

[ 

GRD-469 Getting issue details...

 - 

STATUS

 ]

 No pre-condition for changing AINS configuration between Disabled and Enabled

When performing AINS configuration on an already provisioned TRIB-PTP or Line-PTP/SCG-PTP, the NE shall allow changing the AINS configuration fr
eely
 between Disabled and Enabled at any time irrespective of the state of TRIB-PTP or Line-PTP/SCG-PTP or the value of RemValidSignalTimer.

Note: This allows users to disable or enable AINS regardless of fault conditions or states. Enabling AINS without a fault still takes the entity out of 
service, but the supported entities stay in service.

Please note that throughout this document, a Client CTP refers to all the Client CTPs listed in 
scenario. The above requirement is used to cover the case where the user wants to disable the AINS feature and start monitoring the faults again.

, depending on the applicability and deployment 

GRD-477

[ 

GRD-470 Getting issue details...

 - 

STATUS

 ]

 Allow AdminState Lock and Maintenance when AINS is enabled

The NE shall allow a TRIB-PTP or Line-PTP/SCG-PTP which is in AINS state to be configured to the Locked or Maintenance state.

[ 

GRD-471 Getting issue details...

 - 

STATUS

 ]

 No impact to existing AINS configuration when default template is updated

The NE shall ensure that changing the AINS configuration in the default template shall not cause the change in value of AINS on an already provisioned 
TRIB-PTP or Line-PTP/SCG-PTP.

[ 

GRD-472 Getting issue details...

 - 

STATUS

 ]

 No impact to default template when TRIB/Line/SCG AINS is updated

The NE shall ensure that changing the AINS configuration on an individual TRIB-PTP or Line-PTP/SCG-PTP shall not cause the value in the default 
template to be changed.

[ 

GRD-473 Getting issue details...

 - 

STATUS

 ]

 No impact to existing AINS Valid Signal Time Interval configuration when default 

template is updated

The NE shall ensure that changing the ValidSignalTimeInterval in the default template shall not cause the change in value of ValidSignalTimeInterval 
already provisioned on the TRIB-PTP or Line-PTP/SCG-PTP.


---

## Page 7

https://confluence.infinera.com/display/GXCONF/Automatic+In-Service+GRD

[ 

GRD-474 Getting issue details...

 - 

STATUS

 ]

 No impact to default template when Valid Signal Time Interval is updated on TRIB/Line

/SCG

The NE shall ensure that changing the ValidSignalTimeInterval on an individual TRIB-PTP or Line-PTP/SCG-PTP shall not cause the value in the 
default template to be changed.

[ 

GRD-475 Getting issue details...

 - 

STATUS

 ]

 No pre-conditions for changing the Valid Signal Time Interval

The NE shall allow changing the ValidSignalTimeInterval value at any time using the default template method or on an individual TRIB-PTP or Line-PTP
/SCG-PTP irrespective of the state of the TRIB-PTP/Client CTP, Line-PTP/SCG-PTP/SCH CTP, or the value of RemValidSignalTimer. When such a 
change is done on already provisioned TRIB-PTP or Line-PTP/SCG-PTP, and if the RemValidSignalTimer is active (decrementing), the value of 
RemValidSignalTimer shall be set to the new value of ValidSignalTimeInterval immediately.

5.2. 5.2. Fault Management and State Model

[ 

GRD-476 Getting issue details...

 - 

STATUS

 ]

 Transition into in-service state upon expiry of VS Timer

When the AINS feature is enabled on a TRIB-PTP or Line-PTP/SCG-PTP, the NE shall monitor for the presence of a valid signal on the TRIB-PTP and 
the corresponding Client CTP, or Line-PTP/SCG-PTP and the corresponding Line CTP for the entire duration of Valid Signal Timer before transitioning 
to an in-service state. Depending on the occurrence or absence of a fault before or after timer expires, the following cases shall be supported according 
to the following state diagram

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

GRD-477

GRD-478

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
