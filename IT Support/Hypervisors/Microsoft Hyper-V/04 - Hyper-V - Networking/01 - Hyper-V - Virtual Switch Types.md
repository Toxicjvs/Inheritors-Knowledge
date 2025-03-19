## **Virtual Switch Types**

Hyper-V provides three types of virtual switches that define how virtual machines communicate with each other, the host, and external networks.

---

### **External Virtual Switch**

**Description:**  
An External Virtual Switch connects virtual machines to the physical network through the Hyper-V host’s physical network adapter. Virtual machines can communicate with external devices on the network and access the internet if available.

**Key Features:**  
- Bridges VMs directly to the external physical network.  
- Optionally allows the Hyper-V host to share the same network adapter.  
- Supports VLAN tagging and SR-IOV (if supported by hardware).

**Use Cases:**  
- Production environments requiring VM connectivity to the corporate LAN and internet.  
- Scenarios where VMs need to be accessible by physical devices or services on the network.

**Configuration Steps:**  
1. Open **Hyper-V Manager**.  
2. Select the Hyper-V host.  
3. Click **Virtual Switch Manager**.  
4. Choose **New virtual network switch**, select **External**, and click **Create Virtual Switch**.  
5. Provide a name for the switch (e.g., `ExternalSwitch`).  
6. Select the physical network adapter to bridge.  
7. (Optional) Enable **"Allow management operating system to share this network adapter"** if required.  
8. Click **OK** to apply.

---

### **Internal Virtual Switch**

**Description:**  
An Internal Virtual Switch allows communication only between the Hyper-V host and its virtual machines. It does not provide access to the physical network or internet.

**Key Features:**  
- Enables communication between the VMs and the Hyper-V host.  
- The Hyper-V host is automatically connected to the switch through a virtual network adapter.  
- Provides isolated internal networks without external exposure.

**Use Cases:**  
- Isolated development or testing environments.  
- Communication between VMs and the host for services like file sharing or directory services.  
- Management networks.

**Configuration Steps:**  
1. Open **Hyper-V Manager**.  
2. Select the Hyper-V host.  
3. Click **Virtual Switch Manager**.  
4. Choose **New virtual network switch**, select **Internal**, and click **Create Virtual Switch**.  
5. Name the switch (e.g., `InternalSwitch`).  
6. Click **OK** to create.

---

### **Private Virtual Switch**

**Description:**  
A Private Virtual Switch enables communication exclusively between virtual machines on the same Hyper-V host. The Hyper-V host itself cannot communicate with these VMs.

**Key Features:**  
- Provides isolated VM-to-VM communication.  
- No network connection to the Hyper-V host or the external network.  
- Offers complete isolation for specific workloads.

**Use Cases:**  
- Secure environments where VMs should only communicate with each other.  
- Isolated test labs that do not require access to the host or physical network.

**Configuration Steps:**  
1. Open **Hyper-V Manager**.  
2. Select the Hyper-V host.  
3. Click **Virtual Switch Manager**.  
4. Choose **New virtual network switch**, select **Private**, and click **Create Virtual Switch**.  
5. Name the switch (e.g., `PrivateSwitch`).  
6. Click **OK** to create.

---