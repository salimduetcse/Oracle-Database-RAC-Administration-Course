# Course resources Information 
While the current class material refers to IBM Power9 and Red Hat Enterprise Linux 7, most of its content remains valid and applicable to IBM Power10 and Red Hat Enterprise Linux 9.2. 
Notes are included below the videos when essential remarks need to be highlighted due to product or service updates.
Refer to the following website for more information: 
https://www.ibm.com/servers
As of 12/14/2024 - the lab exercises have been updated to use Red Hat Enterprise Linux 9.2. 
# understanding power system naming convention
AXYZ
A letter that represents the type of server.<br> 
​LC ---> means Linux only server.<br>
​H  ---> means SAP HANA optimized server.<br> 
​AC ---> stands for accelerated computing server which focuses on AI workloads <br> 
​S  ---> stands for scale out server.<br>
E  ---> enterprise scale up server.<br>

X Letter represent <br>
7 ---> Power7 <br>
8 ---> Power8 <br>
9 ---> power9 <br>
10 --> Power10 <br>
Y represent the number of sockets.
Z represent the height of server
# virtualization in Your server
![alt text](Module_01_img1.jpg) <br> <br>
![alt text](Module_01_img2.png)

# Managing Virtualization
Power virtualization stack (cloud virtualization) : 
![alt text](Module_01_img3.png)
This diagram explains the IBM Power Virtualization Stack for cloud management in IBM Power Systems (POWER9 servers).

It shows the layered architecture from physical hardware to cloud management:

1. Hardware Layer – Physical IBM Power servers (POWER9). <br>
2. Hypervisor Layer – Uses PowerVM (IBM’s virtualization technology) or KVM to run virtual machines. <br>
3. Virtualized I/O Layer – VIOS (Virtual I/O Server) provides shared storage and networking resources to VMs.<br>
4. Management Layer – HMC/vHMC and NovaLink manage virtualization and hardware resources. <br>
5. Cloud Management Layer – CMC and PowerVC provide centralized cloud/private cloud management and automation. <br>

In short, the image shows how IBM Power infrastructure is virtualized and managed from hardware up to cloud orchestration.

# IBM POWER10
The IBM Power10 server virtualization stack is similar to POWER9, but with newer management, automation, security, and hybrid cloud capabilities.<br>
Here is the typical Power10 Virtualization Stack (Cloud Management):

![alt text](Module_01_img4.png)

description each components of POWER10

![alt text](Module_01_img5.png)

# Key Differences: POWER9 vs POWER10

![alt text](Module_01_img6.png)

Power10 Virtualization Flow

Physical Server → Hypervisor (PowerVM) → VIOS → LPARs (AIX/Linux/IBM i) → HMC/NovaLink → PowerVC/Cloud Management
<br> For example, in a Power10 E1080:

* Hardware = Power10 server 
* Hypervisor = PowerVM 
* I/O virtualization = VIOS
* LPAR management = HMC or NovaLink
* Cloud provisioning = PowerVC

This is the architecture commonly used for AIX 7.2/7.3, RHEL, Oracle DB, SAP, and enterprise banking workloads on IBM Power10.
# Power Virtualization stack (multicloud management)

![alt text](Module_01_img7.png)

# Processor Concept
![Processor_concept](Module_01_img8.png) <br> <br>
![alt text](Module_01_img9.png) <br> 
Additional Processor (Logical Processor)
![alt text](Module_01_img10.png) <br> <br>
![alt text](Module_01_img11.png) <br> <br>
PowerVM summary  <br> <br>
![alt text](Module_01_img12.png)

# Graded Assignment: Questions for peer review

Write about why virtualization helps improve efficiency on a server. 

Another student from this course will review your answer. Ensure you cover these;

1. IBM Power server hardware features.

2. How virtualization can be achieved in general. 

3. How IBM Power does virtualization and how it adds to efficient usage of resources. 

4. What business case can you think of, to deploy your own computing environmnet with virtualization?
- answser all previous question  <br>
# Documents
- [Linux Admin Manual](Why Virtualization Helps Improve Efficiency on a Server.pdf)