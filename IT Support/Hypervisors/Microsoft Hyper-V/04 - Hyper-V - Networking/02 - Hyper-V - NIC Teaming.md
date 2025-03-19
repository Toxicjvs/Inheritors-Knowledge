## **NIC Teaming in Hyper-V**

NIC Teaming, also known as Load Balancing and Failover (LBFO), allows multiple network adapters on a Hyper-V host to be grouped into a team. This increases network bandwidth and provides redundancy in case a network adapter fails.

---

### **Overview**

NIC Teaming provides the ability to aggregate bandwidth from multiple network interfaces and ensure network availability. It’s configured at the host level and can be applied to physical adapters bound to Hyper-V virtual switches.

- **Benefits:**
  - Increased network throughput by combining multiple adapters.
  - Redundancy and fault tolerance.
  - Flexible configurations supporting different load balancing and failover scenarios.
  
- **Requirements:**
  - Windows Server 2012 or later (NIC Teaming is built-in).
  - Compatible physical network adapters (matching speeds and capabilities recommended).
  - Teams can consist of adapters from different manufacturers, but consistency is advised.

---

### **NIC Teaming Setup and Management**

#### **1. Accessing NIC Teaming**
- Open **Server Manager**.
- Navigate to **Local Server**.
- In the **Properties** pane, click the link next to **NIC Teaming** (default is **Disabled**).

#### **2. Creating a New NIC Team**
1. In the **NIC Teaming** window, click **Tasks** under the **Teams** section and select **New Team**.
2. Provide a **team name** (e.g., `HyperVTeam`).
3. Select the network adapters to include in the team by checking the appropriate boxes.
4. Click **Additional Properties** to configure advanced settings (explained below).
5. Click **OK** to create the team.

---

### **Team Properties and Modes**

#### **Teaming Mode Options**
- **Switch Independent** (default):  
  - Network switches are unaware of the NIC team.  
  - No special configuration on the switch is required.  
  - Suitable for connection to multiple switches (for redundancy).  
- **Static Teaming (IEEE 802.3ad)**:  
  - Requires configuration on both the host and the switch.  
  - All team members must connect to the same switch.  
  - Provides link aggregation and load balancing based on configured policies.  
- **LACP (Link Aggregation Control Protocol)**:  
  - Dynamically negotiates links with the switch using LACP.  
  - Requires the switch to support and be configured for LACP.

#### **Load Balancing Modes**
- **Address Hash** (default):  
  - Distributes traffic based on a hash of address components (IP, MAC, etc.).  
  - Compatible with most configurations.  
- **Hyper-V Port**:  
  - Each virtual NIC is placed on a different physical adapter.  
  - Ideal when using virtual switches and Hyper-V workloads.  
- **Dynamic (Recommended)**:  
  - Combines features of Address Hash and Hyper-V Port.  
  - Optimized for dynamic workloads on Hyper-V hosts.

---

### **Load Balancing / Failover Scenarios**

#### **Load Balancing**
- Combines bandwidth from multiple adapters.
- Traffic is distributed across the adapters based on the selected algorithm.
- Increases total available bandwidth for Hyper-V virtual switches and VMs.

#### **Failover**
- Provides high availability by allowing traffic to continue if one adapter fails.
- Active adapters automatically take over traffic from failed adapters.
- No interruption to VM connectivity if properly configured.

---

### **Best Practices**
- Use **Dynamic** load balancing mode for most Hyper-V environments.
- Opt for **Switch Independent** mode for simplified setup and resilience across switches.
- Ensure all physical NICs are of the same speed and type when possible.
- Regularly monitor NIC Team status in **Server Manager** or **PowerShell**.

---

### **PowerShell Example: Create a NIC Team**
```powershell
# Create a new NIC team named 'HyperVTeam' with two adapters
New-NetLbfoTeam -Name "HyperVTeam" -TeamMembers "Ethernet1","Ethernet2" -TeamingMode SwitchIndependent -LoadBalancingAlgorithm Dynamic
```

---

### **Summary**

NIC Teaming in Hyper-V provides a robust and flexible solution to enhance network performance and resiliency. Whether you're looking to improve bandwidth utilization or ensure failover capabilities, NIC Teaming is a valuable feature for maintaining a stable and scalable Hyper-V environment. Using **Dynamic Load Balancing** with **Switch Independent** teaming mode is generally recommended for modern Hyper-V deployments, delivering a balance of performance, redundancy, and ease of configuration.

---