<!-- Converted from: SwRRT GX SW Upgrade CFDs Analysis_06102025.pptx (zip fallback) -->

## GX – SW

Upgrade CFD 
Analysis
Akshay Kumar Behki
SwRRT
June 10, 2025

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


**Notes:**

21


---

## Handling component failures

Problem statement:
Sometimes the lower layer failures can cause traffic impact. These should be handled in SW. 
Handling different  layer failure scenarios like 
reboots while SW upgrades on LCs/FW/FPGA upgrades/Downgrades.
GX-176701
: Post upgrade Equipment failure/Firmware Installation Failed on CHM6 in GX_R6.1.1.
GX-168320
: 
Prepare Upgrade failed from R6.0.1 to R7.1.0.
GX-157894
: 
CHM6 warm restart is not getting complete. Due to DCO process is not running.
GX-170561
: 
FW details are showing as un-available after upgrade to R7.1 FROM R6.0.1
GX-170560
: 
Line ports entered into low power mode and stopped transmitting power
Development:
UT tests to check what happens and how to handle when lower layers fail like DCO.
Test:
Reboots/Failures at different phases of upgrades needs to be simulated and tested.
Instrument the failure during the upgrades of components (ex: DCO by deleting /
tmp
/firmware) to make sure it’s NSA.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


**Notes:**

22


---

## Molex Vendor GRPC hardening.

Basil/Kapil and we should check what happens inside FW.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## MoMs

: 6/27:
The NRs and SVT repro "no" which can be checked:
GX-175382
: Dev RCA: 
NXP version upgrade successful after first cold boot. But FW update was not sent to 
eqm
. 2nd reboot showed upgrade failure. 3rd reboot finally had successful upgrade which updated 
eqm
 and traffic came up. NXP logs are missing. Due to no logs can't debug issue further.
GX-171860
:Dev RCA: This issue is not reproducible locally. We analyzed the logs and couldn't root cause the exact reason for gecko watchdog. On other hand 
GX-73268
 fixes a watchdog issue in DCO-Gecko with version 1.59. This new version is present in R6.1.5-70. Also we added more logs to catch any failure conditions.
GX-171832
: It appears there is a race condition in NXP where partition sync might occur after the upgrade application stage. Although the probability is low, it happened in this instance. Unlike CHM6, NXP has a different approach to partition sync, performing periodic checks every 15 minutes. A cold boot of CHM6 has done the right grade for NXP and upgraded the NXP. We will fix the race condition in R8.0
									continued…

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## MoMs

: 6/27:
GX-152780
: There was 
controlplane
 
ms
 restart in chm6. That might have caused an issue with communication with XMM4. Need to restart 
dhcpd
 in chm6 whenever time shift happens. Parent bug still in INVESTIGATE state only.
GX-143122
: Missing APJs in newer releases.
GX-140995
: Infamous 3rd party TOM issues (not sure if it's still Best effort defined by our PLM).
GX-137280
: Race condition within 
swmd
 process.
GX-134556
 and 
GX-132613
: 
Kill pal process during activation and include such TC as negative scenarios
GX-132074
: This was marked as ELT visible when 
RCA'ed
 and the issue was with our vendor.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## MoMs

: 6/27:
GX-163964
: Multilane TOM PM migration issue. Already fixed in 8.0.
GX-167300
: MF crash issue while doing SNMP gets while upgrade, already implemented in SVT (already implemented in new upgrade 
testplan
).
GX-158759
: One off SPI issue. This issue was never seen in CHM6 in development testing or anytime in our labs, so fix could not be verified in CHM6.
It was tested in CHM7 only, so it was added as preventive fix for CHM6.
GX-158357
: In R5.2.2 NXP has some problem in updating f/w occasionally. in R6.1.6 Iceland & 
bcm
 versions are not updated always. We fixed These issues in R7.0.
GX-158289
: Log enhancements. NXP bootup issue. We don't know if 
uboot
 load has failed or new partition did not have active file.
GX-157719
: One more case of Stress Mem on CHM6 (CLONED bug).
GX-154468
: WD reset due to low mem.
								continued…

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## MoMs

: 6/27:
Question from Suresh:
 1) why are so many issues not reproduced in our 
environgment
 
Greg: The analysis across many of these items previously points to the lack of proper exception handling. We'll extend the full list, but most of these aren't reproduced in our testing because the exception situation happens in larger deployments or situations where memory reserves are lower over time. There are a hand-
ful
 of functional issues, but the vast majority is exception handling related. One of the primary buckets will be around the exception handling, and there are multiple sub-categories. The test results show that lack of exceptions results in proper upgrades....
Andreas: 
And to trigger the exceptions we need proper hooks. For handling multiple FW downgrade matrix.. UDAN tool. I.e. a tool which is doing upgrades as a service. 
http://udanshanghai.infinera.com:8080/index
 (Shanghai server)
https://udan.infinera.com/index
 ( 
Blr
 server)
							continued…

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## MoMs

: 6/27:
Jotting down some insights for NR list from the 
xls
 shared:
GX-175382
:  
FW update was not sent to 
eqm
. 2nd reboot showed upgrade failure. 3rd reboot finally had successful upgrade which updated 
eqm
 and traffic came up. NXP logs are missing. 
Due to no logs can't debug issue further to see why version update wasn't communicated
 in card. 
GX-171832
: It appears there is a 
race condition in NXP
 where partition sync might occur after the upgrade application stage. Although the probability is low, it happened in this instance.
Unlike CHM6, NXP has a different approach to partition sync, performing periodic checks every 15 minutes.
GX-152780
: There was
 
controlplane
 
ms
 restart in chm6.
 That might have caused an issue with communication with XMM4. Need to restart 
dhcpd
 in chm6 when ever 
timeshift
 happens.
GX-143122
: There is 
SDK exception while configuring one of the Tx 
Apj
 parameter
 
PilotAvgnSS
. It crashed and invoked powerdowndco.sh script to power down 
dco
GX-137280
: 
There were 2 instances of SWMD running
, that caused issue with 
sw
-version update on CHM6
							continued…

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## MoMs

: 6/27:
Suresh’s asks for NRs above:
GX175382 : why 
dont
 we have NXP logs ? Is it s design problem ? 
GX-171832
: Have we drawn the application states of the upgrade flow vs the dynamic events that the system can experience to be able to design for eventualities ?
Unlike CHM6, NXP has a different approach to partition sync, performing periodic checks every 15 minutes.> What is the implication of this ? 
GX-152780: 
Thsi
 falls under the category of event vs state design considerations. tell me if it is not. Control plane restart is a common issue and it is a dynamic event , how does the system flow get affected and what resilience do we have in this context ?  
GX-143122: this 
doesnt
 seem to have anything to do with upgrade as such, just missing robustness or missing completeness in the unit test 
GX-137280: Why does it cause any issue for 
sw
-version update ? what is the expectation  ?

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## MoMs

: 6/27:
 2) how did each issue impact the customer at a higher level 
 3) what was the customer behavior. / environment 
 4) How were we lacking on Design for Service 
 5) clearly DFS is not great since several of the issues are not 
repro’ed
6) Are we designing for resilience ( least impact on the system and n/w due to faults )  
 7) Are we able to produce architecture guidelines due to these CFD's ? 
 
8 ) design guidelines ? Coding guidelines 
etc
 
Points from Anoop for Meta:
Resource usage in the long run, and software behaving inconsistently over prolonged usage, hard to reproduce in our setup. Maybe the long running customer test chain you are planning to buy helps here Andreas Schuch (Nokia) .
Slowness of upgrades he said this is also partially due to slowness of 
hw
 components.
A release upgrade matrix that's too complex to execute, because we have many in field versions.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Backup Data

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Agenda

This document covers analysis  of customer found defects related to SW upgrade during Y2024.
 
Purpose of the 
analysis
 is to establish, 
WoWs
 (Ways of Work) within R&D to improve upgrade experience for the customer in all the GX platforms.
In total 
61*CFDs 
related to SW upgrade were reported in 2024, out of which 18 cut through as per their reproducibility probability or at least help us characterize and document expected behaviors.
Each slide caters to one area which can be classified as improvement with corresponding CFD links.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## RRT Recommendation:

Check all FS corruption and modes before upgrade.
Internal links/HW (I2C, PCIe) failure detections.
Granular Upgradability.
Dynamic pre-upgrade scripting.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Inputs from SRD lead

Text
Architecture comment
Backward compatibility over new release
We have the requirement, that backward compatibility is to be considered for up to two major releases back 
Which upgrade paths really are supported depends on Customer Requirements, Test resources, and is subject to be decided by PLM and Release management.
Check all FS corruption and modes before upgrade
All Files are signed and signature checked prior to usage (and after download).
Other issues need to be covered by SW architecture. Note that scripts can be part of the SW package and will run prior to the upgrade, so If we get aware of any issues, this is the way to check for them.
FW/FPGA upgrades/Downgrades
Should be covered:
No automatic downgrade of firmware, but possible with force option
Upgrade of Firmware is delayed when service affecting until the next cold start of card.
Bad initializations
SW to care about this
 Internal links/HW (I2C, PCIe) failure detections.​
Mainly upgrade runs over Ethernet Connectivity, if this is not available, the affected FRU will raise an alarm (I assume) and the pre-upgrade step (where we send the software) will fail. For internal stuff like I2s, SW needs to ensure detecting issues I assume
Granular upgradability
Delta Upgrades/Service Packs are supported.
Improved visibility and logging during upgrades.​
Please Check SRD for what we plan here, I hope it is matching expectations.
Dynamic pre-upgrade scripting
As each script must be signed and we need to keep track what is installed on a node, all scripts are part of a release package with a unique number, I think we disused this in length.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Inputs from SRD lead

Contd
 …
Text
Architecture comment
Minimize interdependencies between components
This is one of the main architectural goals of 
Thanos
.
Upgrade/bootup even if certain non-critical accesses fail.​
I hope that fail-safe programming is one of our architectural goals also. Regarding upgrade, when we switchover to the new partition, we will automatically switch back to the known working partition if the node does not come back to a manageable state within a certain time (currently specified as 10 minutes)
Memory/RAM/CPU usage over introducing new features.​
From upgrade perspective we have the precondition checks to compare available disk space (and probably RAM) with what is needed for the upgrade. Otherwise this is a SW architecture question
Handling misconfigurations.
From upgrade perspective such misconfiguration can be detected by the check scripts. But I believe also the 
ThanOs
 SW Architecture will help here, e.g. one central Database storing the configuration, so the expectation is, that we only run rarely into such issues.
Upgrade > Reboot wr.t to timeouts and alarm handling
We differentiate between upgrade and normal reboot. And only the time we need on the XMM to bring up the Management interface again after an upgrade reboot counts. Currently this is requested to be not more than 4 Minutes, the Timeout is defined as 10 Minutes.
Object snap-shots before upgrade
Not sure what this is asking for. All Configuration data is stored on the XMM. Transient events would be captured in log files, still 
availabel
 after an upgrade. So for me it is unclear which 
additonal
 data should be captured here.
Packaging issues, Files/binaries, CLs missing/broken.​
This is a request against our release process.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## End frame

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Feedback on G42 SW Upgrade from Amazon Account team

G42 SNMP Performance issues resulted in Amazon doubting our system capabilities. Nokia had to work with Amazon closely to optimize the 
SNMP
 retrieval to work around our system limitations. 
R6.2.0 basic Upgrade failure with dual controller was a huge disappointment and main reason behind this miss in SVT was, the test team did not consider 
FW
 
downgrade
 during upgrade tests.
SVT testing ,in general, is always being questioned by Amazon because very basic issues were observed during the upgrade. 
While providing the 
workaround
 to Amazon for these issues, there were a lot of back-and-forth recommendations provided by Engineering further questioned our product understanding and clarity. 
GX upgrade times are longer and moreover, components FW upgrade failures is a big concern.
Amazon openly criticize Nokia, for the lack of developing comprehensive test plans and taunt Nokia saying that we use their 
network as test bed to 
RCA all the issues.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Feedback on G42 SW Upgrade from Meta Account team

Post 6.1, 
multiple maintenance builds 
have been provided to Meta till now.
Meta is very disappointed on GX upgrade times, and the improvements made in this area, are not enough for Meta. Meta moved from 
shell-based upgrade to ISSU 
to reduce the traffic drain times. The first ISSU upgrade was planned recently during R5.2.2 to R6.1.6 upgrade. However, Meta’s confidence with our SW is so low, that they kept draining the traffic to monitor traffic impact.
At some point during the R5.2.2 to R6.1.6 upgrades, Meta stated that they could not gather any data because of the too many issues, i.e
., too many cold reboots needed 
and too many outages. 
Meta is upgrading network from R5.2.2 to R6.1.8, so the experience didn’t change much to previous upgrade (R5.2.2 to R6.1.6) but even a bit worse as in the meantime new issues that we had previously communicated 
as benign now turned to be not so much true
. 
To deal with a specific Level DB partition full issue, Meta decided to go for restore factory default, but this caused a lot of TI NVM corruption issues. And the only explanation we have, is this issue is fixed in newer 
CHM6 hardware (P5) and for older HW revision, we have only added an alarm 
in newer release. Before the upgrades we communicated, this was a rare issue but at some point, they started to laugh at us because number of times its seen, so we had to withdraw this statement: 
GX-69571
.
Meta will start next SW upgrades from R6.1.6 to R6.1.8 in coming weeks and we will see how the upgrade will go this time, but we are not very optimistic unfortunately.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Flash/RAM usage over introducing new features/upgrades

Problem statement:
Introducing new features/framework changes takes some toll on memory. Unavailability of memory can cause multiple issues such as
traffic hit.
GX-180699
 
: 
G42: R7.1 UCM4 Not able to recover after Upgrade from R7.0 to R7.1 - Equipment's control plane is unreachable
GX-183453
 : 
PFU Fail on 
node
 Rel 7.1.0
GX-183253
: 
C
HM6 1-7 PFU is failed at apply action in GX_R6.1.3
GX-182504
: 
FPU failed with memory usage check failed in GX_R7.1.1
GX-174292
: 
FW-INSTAL-FAIL after upgrade from R5.2.2 to R6.1.6
GX-171516
: 
FW-INSTAL-FAIL after upgrade from R5.2.2 to R6.1.6
*
All bugs except GX-180699 which was on LC and all others on NXP.
Development:
Characterize every flash/RAM limits by stressing for each component separately in UT.
Implement auto-recovery (watchdogs)/alarming for such failures wherever needed.
Demarcate each flash/RAM failure and make sure they are NSA.
Test:
Need a release-on-release matrix to measure these (continuous).
Carry out upgrades with such stressed situations.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Backward compatibility over new release

Problem statement:
Customers use automation which needs backward compatibility as a requirement.
GX-163967
 :
Dual carrier SCH creation CLI command broken after SW upgrade from R5.2-102 to R6.2.0.
GX-140166
: 
IKE Peer in R7 does not work in GX_R7.0.0.
Development:
While developing new features/changes around a deployed configuration or addition to it, make sure we have backward compatibility or provide a Pre-Upgrade check for the same.
During the upgrade period, provide a conceptual ‘lock’ that prevents any kind of traffic impacting configuration change from occurring. To be meaningful this lock should go down as low as possible down the software stack.
Test:
CL based system testing for any changes in NBIs (tacking specific file changes having definitions).
Have a list of all possible important CLI commands with "Actions" i.e., ADD in this case and check them for completion and validate success.
All 
enum
 checks as regression with validation for success.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## High CPU loading

Problem
 
statement
:
Introducing new features/framework changes takes some toll on CPU. Unavailability of any may result in upgrade failures.
GX-157912
: 
2 nodes apply phase has failed due to CHM6_base_os install failure as well as 
Secproc
 download failure
Development:
Characterize CPU limits by stressing each CPU separately in UT.
Demarcate each CPU failure and implement auto-recovery (watchdogs)/alarming.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Stress/Negative scenarios in NBI interfaces

Problem statement:
Customers use NBI in their own ways choking our NEs sometimes if not used efficiently.
Often challenging to explain customers if the use-case is valid or not.
GX-180871
: 
After upgrade to R7.1 NE lost management in GX_R7.1.0
Development:
Characterize limits by stressing each NBI separately using automation in UT.
Possible for limit the same in SW for alarming?
Test:
Char
acterize limits by stressing All NBIs together using automation.
Need a release-on-release matrix to measure these (continuous).
Test specifically on cards which have low memory/RAM and less CPU specifications as NCs.
Carry out upgrades with such stressed situations.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---

## Files/Packages/CLs missing/corrupted scenarios.

Problem statement:
In some corner scenarios it’s possible to end up with missing packages on LCs/SCs.
GX-183670
: 
Prepare for upgrade failed on node in GX_R6.1.3.
GX-132173
: 
Standby XMM4 installed with R6.1 is not upgrading to R6.1.3 automatically in Shelf chassis.
GX-163450
: 
Upgrade failing on G42 from R5.2.102 to R6.2.0-145
Development:
If there are internal settings changing over releases, we should have an automated UT suite to regress such attributes every release.
Have auto recover for file corruptions/file missing/download fails (in this case apply instead of validate worked around).
Make sure if marking Duplicate, the fix CL is ported to the correct target release. 
Test:
Negative scenarios while upgrade testing (ex: disconnect SCs between different upgrade stages like apply/validate).
Try to delete some packages manually and see if PFU fails and can it be auto recovered.
Make sure before closing any Duplicate, the fix CL is ported to the correct target release.

![image3.png](images/image3.png)

![image2.svg](images/image2.svg)

![image1.png](images/image1.png)

![image4.svg](images/image4.svg)

![image17.svg](images/image17.svg)

![image18.jpeg](images/image18.jpeg)

![image15.jpeg](images/image15.jpeg)

![image14.png](images/image14.png)

![image20.svg](images/image20.svg)

![image10.jpeg](images/image10.jpeg)

![image19.png](images/image19.png)

![image13.jpeg](images/image13.jpeg)

![image12.svg](images/image12.svg)

![image11.png](images/image11.png)

![image16.png](images/image16.png)

![image9.jpeg](images/image9.jpeg)

![image8.jpeg](images/image8.jpeg)

![image7.svg](images/image7.svg)

![image6.png](images/image6.png)

![image5.jpeg](images/image5.jpeg)


---
