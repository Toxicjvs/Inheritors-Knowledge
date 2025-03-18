## **Virtual Machine Management**

### **Creating Virtual Machines**

#### **Quick Create (GUI / Windows Admin Center)**

**Quick Create** is a simplified approach to creating virtual machines (VMs) that can be done through either **Hyper-V Manager** (GUI) or **Windows Admin Center (WAC)**. This method is efficient for quickly provisioning VMs with minimal configuration.

1. **Using Hyper-V Manager (GUI)**:
   - Open **Hyper-V Manager** from the **Start Menu**.
   - Select the **Hyper-V Host** where you want to create the VM.
   - In the **Actions** pane on the right, click **New** > **Virtual Machine**.
   - The **New Virtual Machine Wizard** will open, where you will:
     - Choose the **VM Generation** (1 or 2).
     - Specify the **VM Name** and the **location** for storing VM files (VM configuration and virtual hard disks).
     - Set the **Startup Memory** (you can enable **Dynamic Memory** if needed).
     - Choose the **Network Adapter** (this will be attached to a virtual switch).
     - Select the **Virtual Hard Disk (VHD/VHDX)**, specifying the size and format (you can create a new disk or use an existing one).
     - Select the **Operating System** to install later, or attach an **ISO** for installation.
   - After completing the wizard, click **Finish**, and the VM will be created.

2. **Using Windows Admin Center (WAC)**:
   - Open **Windows Admin Center** and connect to the Hyper-V server.
   - Navigate to **Virtual Machines** under the Hyper-V server dashboard.
   - Click **Create a virtual machine**.
   - Follow the same steps as the Hyper-V Manager wizard: name the VM, assign resources (memory, disk, network), and attach an installation ISO.
   - WAC also offers additional integrations and management tools for virtual machines, like performance monitoring, VM migrations, and other advanced features.

---

#### **Manual VM Creation (Generation 1 vs Generation 2)**

For more control over the virtual machine’s configuration, **manual creation** gives you flexibility in choosing advanced settings, such as the type of VM generation (Generation 1 vs Generation 2). 

1. **Generation 1**:
   - **Legacy BIOS-Based Virtualization**: The VM is created using traditional BIOS-based virtualization.
   - **Supports older operating systems** that do not require UEFI support (e.g., Windows 7 or older Linux versions).
   - **Virtual Hardware Compatibility**: Offers compatibility with older hardware configurations and legacy operating systems.
   - **Boot Devices**: Supports boot from legacy devices like **IDE** disks and **floppy disks** (if needed).
   
2. **Generation 2**:
   - **UEFI-Based Virtualization**: The VM is created with UEFI firmware instead of traditional BIOS.
   - **Secure Boot**: Supports **Secure Boot** (more on this later) for greater security during the boot process.
   - **Advanced Features**: Allows for newer OS installations that require UEFI, such as Windows 8 and above, or newer Linux distributions.
   - **Enhanced Boot Devices**: Booting from **SCSI** disks and network booting is supported. It does not support legacy devices like floppy drives or IDE controllers.
   - **VM Performance**: Generally, Generation 2 VMs benefit from improved performance due to modern firmware and more efficient resource allocation.

When manually creating a VM, you will be asked to choose the **generation** as part of the **New Virtual Machine Wizard**. Generation 2 is recommended for most modern operating systems, as it takes advantage of newer hardware and firmware features.

---

#### **Configuring Secure Boot (UEFI Firmware)**

**Secure Boot** is a UEFI-based security feature that ensures only trusted operating systems and bootloaders can be loaded during the VM startup process, providing protection against rootkits and other malicious code.

1. **What is Secure Boot?**
   - **Secure Boot** ensures that the VM can only boot from a known, trusted source (such as a digitally signed OS loader). This prevents unauthorized bootloaders or malware from compromising the system during startup.
   - Secure Boot is only available for **Generation 2 VMs**, which use UEFI firmware.

2. **Enabling Secure Boot**:
   - When creating a **Generation 2 VM**, **Secure Boot** is enabled by default in the VM settings. However, you can manually configure it at any time.
   - To enable or disable Secure Boot after VM creation:
     1. Open **Hyper-V Manager**.
     2. Right-click on the **VM** and choose **Settings**.
     3. Under **Hardware**, select **Firmware**.
     4. Check or uncheck **Enable Secure Boot**.
     5. Click **OK** to apply the changes.

3. **Configuring Secure Boot for Non-Windows Operating Systems**:
   - **Linux VMs**: While Secure Boot is typically associated with Windows operating systems, many modern Linux distributions also support Secure Boot. If your VM is running a supported Linux OS (e.g., Ubuntu), you can leave Secure Boot enabled.
   - **Custom Secure Boot Keys**: If you're running a custom OS or need to manage keys manually (e.g., with custom Linux builds), you can upload custom keys to allow non-standard bootloaders. This is done from the **UEFI settings** in the VM's firmware options.

4. **Secure Boot and Compatibility**:
   - If you attempt to boot an unsupported OS or an OS with an untrusted bootloader, the VM will fail to start, ensuring that only authorized operating systems can be used.

---

### Summary

- **Quick Create** allows for a fast, straightforward VM creation process using Hyper-V Manager or Windows Admin Center.
- **Manual VM Creation** provides flexibility in selecting the VM's generation (Generation 1 or 2), which impacts compatibility with OS and features like UEFI and Secure Boot.
- **Secure Boot** offers an additional layer of security for Generation 2 VMs, ensuring that only trusted bootloaders are used during system startup.

This detailed guide gives you a clear understanding of how to create virtual machines in Hyper-V, including the differences between Generation 1 and Generation 2, and how to enable secure boot for enhanced security.

---