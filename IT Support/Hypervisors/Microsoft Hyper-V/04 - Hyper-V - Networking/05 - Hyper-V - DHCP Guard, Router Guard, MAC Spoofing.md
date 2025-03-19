## **DHCP Guard, Router Guard, MAC Spoofing**

In a Hyper-V environment, securing VM network traffic is vital to prevent malicious attacks or network disruptions. Hyper-V provides several features such as **DHCP Guard**, **Router Guard**, and **MAC Spoofing** protection to help maintain the integrity and security of virtualized networks.

These features are designed to protect against unauthorized network behaviors like rogue DHCP servers, traffic interception, and MAC address spoofing, which could lead to man-in-the-middle attacks or network disruptions.

---

### **Enhancing VM Network Security**

The goal of these features is to bolster network security by ensuring that only authorized network traffic flows through the VM network. By enforcing these protections, you can prevent various types of network-based attacks.

1. **DHCP Guard**:  
   This feature is used to prevent rogue DHCP servers from assigning IP addresses within a network, which could disrupt network connectivity or launch attacks such as **Man-in-the-Middle (MITM)**.

2. **Router Guard**:  
   Router Guard prevents the network from accepting routing advertisements from unauthorized devices. It ensures that only legitimate routers can issue routing information in the network.

3. **MAC Spoofing Prevention**:  
   MAC address spoofing is an attack technique where an attacker changes the MAC address of their device to match the MAC address of another legitimate device in the network. Hyper-V provides protection by disallowing changes to a VM's MAC address once it's been assigned, ensuring the security of the virtualized network.

---

### **DHCP Guard**

**DHCP Guard** protects against rogue DHCP servers that might attempt to assign IP addresses to VMs on your network. These unauthorized servers could disrupt network services by assigning invalid IP addresses or intercepting network traffic.

#### **How DHCP Guard Works**:

When enabled, **DHCP Guard** blocks any DHCP offer from a device that is not specifically trusted, usually the DHCP server in your network. This is done by tagging specific network ports (on physical or virtual network adapters) as either **trusted** or **untrusted**. Only trusted ports are allowed to offer DHCP services.

#### **Configuring DHCP Guard in Hyper-V**:

1. Open **Hyper-V Manager** and select the **Virtual Switch Manager**.
2. Click on the **Virtual Switch** you wish to configure.
3. Under the **Network Adapter** settings, check the option for **Enable DHCP Guard**.
4. Select which virtual switch ports should be trusted (usually, only your DHCP server port should be trusted).
5. Apply the changes to activate the feature.

#### **PowerShell Example**:

To enable **DHCP Guard** using PowerShell for a specific VM's network adapter:

```powershell
Set-VMNetworkAdapter -VMName "VMName" -DhcpGuard Enabled
```

---

### **Router Guard**

**Router Guard** prevents rogue routers from advertising routing information, ensuring that only legitimate routers can send route advertisements in the network. This helps prevent **false route injections** and other forms of network disruption.

#### **How Router Guard Works**:

Router Guard will only allow routers that are explicitly trusted (configured as trusted routers in Hyper-V) to send router advertisements. Any other devices trying to advertise themselves as routers are blocked.

#### **Configuring Router Guard in Hyper-V**:

1. Open **Hyper-V Manager** and select the **Virtual Switch Manager**.
2. Select the network adapter associated with your VM.
3. Enable **Router Guard** for this adapter to prevent unauthorized routers from advertising in the network.

#### **PowerShell Example**:

To enable **Router Guard** on a specific VM's network adapter:

```powershell
Set-VMNetworkAdapter -VMName "VMName" -RouterGuard Enabled
```

---

### **MAC Spoofing Prevention**

**MAC Spoofing** refers to the practice of changing the MAC address of a network adapter to impersonate another device on the network. This could be used for various attacks such as identity theft, traffic interception, or evading network security.

Hyper-V includes **MAC Spoofing prevention**, which ensures that the MAC address of a VM's network adapter cannot be altered unless explicitly allowed. This provides an extra layer of security to avoid unauthorized access or malicious activity.

#### **How MAC Spoofing Prevention Works**:

When MAC spoofing protection is enabled, Hyper-V enforces the integrity of the MAC address assigned to a VM’s network adapter. Any attempts to change the MAC address are blocked, preventing potential attackers from impersonating other devices.

#### **Configuring MAC Spoofing Prevention in Hyper-V**:

1. Open **Hyper-V Manager** and select the VM you wish to configure.
2. Click on the **Settings** option for the selected VM.
3. Under **Network Adapter** settings, navigate to the **Advanced Features** section.
4. Enable the option **Prevent MAC Spoofing** to block the ability to modify the MAC address.
5. Apply the changes to activate the feature.

#### **PowerShell Example**:

To enable **MAC Spoofing Prevention** for a specific VM:

```powershell
Set-VMNetworkAdapter -VMName "VMName" -MacAddressSpoofing Disabled
```

---

### **Summary**

Hyper-V provides essential security features such as **DHCP Guard**, **Router Guard**, and **MAC Spoofing Prevention** to enhance the security of virtualized networks.  
- **DHCP Guard** prevents rogue DHCP servers from disrupting network traffic by ensuring that only trusted servers assign IP addresses.
- **Router Guard** ensures that only authorized routers can advertise routing information, securing the network topology.
- **MAC Spoofing Prevention** stops attackers from changing the MAC address of VMs, thus maintaining the integrity of network traffic.

These features should be enabled in environments where network security is critical, particularly when running sensitive workloads on virtual machines. 

---