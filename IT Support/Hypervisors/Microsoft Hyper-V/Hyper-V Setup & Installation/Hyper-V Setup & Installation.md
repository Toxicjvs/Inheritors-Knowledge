# ✅ Hyper-V Role Installation Guide  
### *Step-by-Step, Detailed Instructions for Installing Hyper-V on Bare-Metal Servers and Desktop Systems*

---

## **Introduction**
Hyper-V is Microsoft’s hypervisor platform for creating and managing virtual machines (VMs). It's commonly installed on **bare-metal servers** for production environments, but it can also be installed on **Windows 10/11 Pro, Enterprise, and Education editions** for development, testing, or lab environments.

This guide covers the **installation methods**, **system requirements**, and **post-installation steps** for both **Windows Server Hyper-V** and **Windows desktop Hyper-V** installations.

---

## **1. Understanding Hyper-V Installations**
### **Bare-Metal Server Installations**
- Typically used in **enterprise and data center environments**.
- Hyper-V is installed on **dedicated physical servers** with no other workloads, providing better **performance, stability, and security**.
- Deployed as:
  - **Hyper-V Role** on Windows Server
  - **Hyper-V Server** (standalone, headless hypervisor; now deprecated but still used in legacy setups)
  - **Server Core Installations** for minimal footprint and reduced attack surface.

### **Desktop/Workstation Installations**
- Common in **lab environments**, **development**, **testing**, and **training**.
- Hyper-V is available on:
  - **Windows 10 Pro, Enterprise, and Education**
  - **Windows 11 Pro, Enterprise, and Education**
- Installed as an **optional feature**, but it’s **not** supported on **Windows Home editions** without modification.

---

## **2. Hyper-V System Requirements**

### **Hardware Requirements (Applies to Both Server and Desktop)**
- **64-bit Processor** with **Second Level Address Translation (SLAT)** support
- **Virtualization Support Enabled in BIOS/UEFI**:
  - Intel VT-x (Intel Virtualization Technology)
  - AMD-V (AMD Virtualization)
  - Data Execution Prevention (DEP): Intel XD bit or AMD NX bit
- Minimum **4 GB RAM** (8 GB or more recommended)
- Sufficient **free disk space** (consider VM storage requirements)

> ⚠️ **Note:** If SLAT isn’t supported, you won’t be able to run Hyper-V on Windows 10/11. It’s mandatory for desktop Hyper-V installations.

---

## **3. How to Check Hardware Compatibility (Pre-installation Checklist)**

### **Check Virtualization Support in Windows (CMD or PowerShell):**
```powershell
systeminfo
```
Look for:
- **Hyper-V Requirements:**
  - VM Monitor Mode Extensions: Yes
  - Virtualization Enabled in Firmware: Yes
  - Second Level Address Translation: Yes
  - Data Execution Prevention Available: Yes

If any of these say “No”, check your **BIOS/UEFI** settings.

### **Enable Virtualization in BIOS/UEFI:**
- Common Keys: `DEL`, `F2`, `ESC` on boot to enter BIOS
- Settings may be under:
  - `Advanced > CPU Configuration > Intel Virtualization Technology (VT-x)`
  - `Advanced > CPU Configuration > AMD-V`
- Enable **Data Execution Prevention (DEP)** or **No Execute Memory Protection (NX)**

---

## **4. Installing Hyper-V on Windows Server (Bare-Metal Server Installations)**

### **Option 1: Using Server Manager (GUI)**
1. Open **Server Manager**.
2. Select **Manage** > **Add Roles and Features**.
3. **Before You Begin**: Click **Next**.
4. **Installation Type**: Select **Role-based or feature-based installation**, click **Next**.
5. **Select Destination Server**: Choose the local server, click **Next**.
6. **Server Roles**:  
   - Check **Hyper-V**.  
   - Click **Add Features** when prompted to install dependent features.
7. **Features**: Accept defaults, click **Next**.
8. **Hyper-V**:  
   - Read information about Hyper-V.  
   - Click **Next**.
9. **Create Virtual Switches**:  
   - Select network adapters for **External** virtual switches.  
   - You can skip and configure this later if unsure.
10. **Migration Options**:  
    - Enable **Live Migration** if required (optional).  
    - Configure authentication (default is **CredSSP**, can be changed later).
11. **Default Stores**:  
    - Set locations for **Virtual Hard Disks** and **VM Configuration Files**.
12. **Confirmation**:  
    - Review settings.  
    - Check **Restart the destination server automatically if required** (optional).  
    - Click **Install**.
13. After installation, **reboot** the server if prompted.

---

### **Option 2: Using PowerShell (Recommended for Server Core or Automation)**

#### **Install Hyper-V Role:**
```powershell
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart
```

#### **For Server Core (No GUI):**
```powershell
Install-WindowsFeature -Name Hyper-V
```

> ⚠️ Server Core installs **without** the Hyper-V Manager GUI; manage via **PowerShell**, **Remote Hyper-V Manager**, or **Windows Admin Center**.

---

## **5. Installing Hyper-V on Windows 10/11 (Desktop/Workstation Installations)**

### **Option 1: Using Control Panel (GUI)**
1. Open **Control Panel** > **Programs** > **Turn Windows features on or off**.
2. Check **Hyper-V**:
   - Hyper-V Management Tools  
   - Hyper-V Platform  
   *(If Platform is greyed out, SLAT isn’t supported or virtualization isn’t enabled.)*
3. Click **OK**.
4. Windows installs Hyper-V and prompts for a **reboot**.

---

### **Option 2: Using PowerShell**
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```
- If prompted, restart the computer:
```powershell
Restart-Computer
```

---

### **Option 3: Using DISM (Deployment Image Servicing and Management)**
```powershell
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
```

---

## **6. Verifying Hyper-V Installation**

### **Check Installed Roles and Features (Server):**
```powershell
Get-WindowsFeature -Name Hyper-V*
```

### **Verify Hyper-V is Running (Desktop):**
- Open **Hyper-V Manager** from:
  - Start Menu  
  - Run `virtmgmt.msc`  
- If Hyper-V Manager opens and connects to the local host, installation is successful.

---

## **7. Post-Installation Configuration**
- **Virtual Switch Manager**:  
  - Create External/Internal/Private switches for VM networking.
- **Default VM/Storage Paths**:  
  - Configure storage locations for VHDs and VM files.
- **Live Migration/Replica**:  
  - Plan authentication and network configuration.
- **Integration Services (Legacy systems)**:  
  - New versions of Windows already include updated services.

---

## **8. Best Practices for Hyper-V Deployment (Bare-Metal)**
- Use **Server Core** whenever possible to minimize attack surface.
- Keep the **Hyper-V host dedicated** to virtualization workloads—no additional roles/services.
- Enable **NUMA spanning** only if necessary.
- Regularly **update firmware** and **Hyper-V Integration Services**.
- Plan for **high availability** (Live Migration, Failover Clustering).
- Backup the **host configuration and VM data** regularly.

---

## **9. Common Issues & Troubleshooting**

| **Issue** | **Cause** | **Resolution** |
|-----------|-----------|----------------|
| Hyper-V Platform checkbox greyed out (Windows 10/11) | No SLAT support / Virtualization disabled in BIOS | Enable SLAT and virtualization in BIOS |
| VM won’t start | Insufficient resources, Secure Boot mismatch | Adjust resource allocation, check firmware settings |
| Network adapter missing | Virtual switch not configured | Create Virtual Switch in Hyper-V Manager |
| Cannot manage Hyper-V remotely | Firewall settings, missing admin rights | Enable Remote Management, configure firewall exceptions |