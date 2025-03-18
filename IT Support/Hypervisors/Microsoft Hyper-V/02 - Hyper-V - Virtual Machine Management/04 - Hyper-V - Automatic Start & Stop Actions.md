## **Virtual Machine Management**

### **Automatic Start/Stop Actions**

In Hyper-V, you can configure the automatic startup and shutdown of virtual machines (VMs) when the host system is booted or shut down. This feature is particularly useful in production environments or for managing multiple VMs where you need specific control over when each VM starts or stops relative to others. These configurations can help improve efficiency and manage VM workloads during host system restarts or shutdowns.

---

#### **Configuring VM Startup Priority and Delay**

1. **VM Startup Priority**:
   - When a Hyper-V host is restarted, VMs do not automatically start at the same time. Hyper-V allows you to set **startup priorities** to control the order in which VMs are powered on.
   - **VM Startup Priority** helps to determine which VM should start first if there are multiple VMs on the host. This is particularly important if you have VMs with dependencies on others. For example, you might want to start a domain controller VM first before other application or database VMs.

   - **Configuring Startup Priority**:
     - Open **Hyper-V Manager**.
     - Right-click on the VM for which you want to configure the startup priority, and select **Settings**.
     - Under **Automatic Start Action**, click on **Advanced**.
     - Set the **Startup Priority**. You can assign a priority of **High**, **Medium**, or **Low**. High priority VMs will start before those with a lower priority.
     - Click **OK** to apply the changes.

2. **Startup Delay**:
   - You can also configure a **startup delay** for each VM. This is useful to avoid overloading the host with too many simultaneous start-ups, especially if the host is running multiple VMs.
   - **Startup Delay** is typically configured in conjunction with **Startup Priority**, ensuring that VMs start in a controlled manner and do not overwhelm the system’s resources during the boot process.

   - **Configuring Startup Delay**:
     - Open **Hyper-V Manager**.
     - Right-click on the VM and select **Settings**.
     - In the **Automatic Start Action** section, click **Advanced**.
     - Set the **Startup Delay** in seconds. This allows you to specify how long Hyper-V waits before starting the VM after the host begins its startup process.
     - This delay ensures that other VMs with higher priority can start first, avoiding resource contention.
     - Click **OK** to apply the changes.

---

#### **Auto Start/Stop Actions on Host Boot/Shutdown**

1. **Configuring Auto Start**:
   - Hyper-V allows you to define what happens when the host system is powered on (either manually or after a restart).
   - You can choose from three options for auto-starting VMs when the host boots:
     - **Never Start**: The VM will not start automatically when the host starts.
     - **Start If Running**: The VM will automatically start only if it was running at the time the host was shut down.
     - **Always Start**: The VM will always start when the host boots, regardless of its previous state.
     
   - **Configuring Auto Start**:
     - Open **Hyper-V Manager**.
     - Right-click on the VM and select **Settings**.
     - Under **Automatic Start Action**, choose one of the following:
       - **Never Start**: The VM will not be started automatically.
       - **Start If Running**: The VM starts automatically only if it was running when the host was powered off.
       - **Always Start**: The VM will start automatically regardless of its previous state.
     - Click **OK** to apply the changes.

2. **Configuring Auto Stop**:
   - Hyper-V also allows you to define actions for when the host system shuts down or restarts.
   - There are three options for auto-stopping VMs when the host shuts down:
     - **Shut Down**: The VM will be gracefully shut down when the host shuts down.
     - **Turn Off**: The VM will be forcefully turned off (equivalent to pulling the power on a physical machine).
     - **Save**: The state of the VM is saved when the host shuts down (similar to suspending a physical computer).
     
   - **Configuring Auto Stop**:
     - Open **Hyper-V Manager**.
     - Right-click on the VM and select **Settings**.
     - Under **Automatic Stop Action**, choose one of the following:
       - **Shut Down**: The VM will attempt to shut down gracefully when the host shuts down.
       - **Turn Off**: The VM will be powered off abruptly when the host shuts down.
       - **Save**: The VM will save its state and resume when the host is restarted.
     - Click **OK** to apply the changes.

---

#### **Advanced Auto Start/Stop Options (Using PowerShell)**

You can also configure auto start/stop settings via PowerShell, offering more flexibility and enabling automation for large-scale environments.

1. **Configuring Auto Start using PowerShell**:
   ```powershell
   Set-VM -Name "VMName" -AutomaticStartAction StartIfRunning
   ```
   This command will configure the VM to start automatically if it was running before the host shut down.

2. **Configuring Auto Stop using PowerShell**:
   ```powershell
   Set-VM -Name "VMName" -AutomaticStopAction Save
   ```
   This command will configure the VM to save its state when the host shuts down.

3. **Setting Startup Delay using PowerShell**:
   ```powershell
   Set-VM -Name "VMName" -AutomaticStartDelay 30
   ```
   This command sets the startup delay to 30 seconds for the specified VM.

---

### Best Practices for Automatic Start/Stop Actions

1. **Set Startup Priorities Carefully**:
   - Assign higher startup priority to VMs that are essential to your infrastructure, such as domain controllers, DNS servers, and database servers. This ensures that these VMs are online first to provide necessary services to other VMs.

2. **Use Startup Delay for Large Environments**:
   - If you have many VMs on the same host, consider adding a small startup delay (e.g., 10-20 seconds) to avoid overloading the system and to ensure VMs start in an orderly fashion.

3. **Graceful Shutdown**:
   - Always choose **Shut Down** for production VMs when configuring automatic stop actions. This ensures that VMs can perform necessary shutdown procedures (e.g., database flushing) before turning off.

4. **Avoid Forceful Shutdowns**:
   - Avoid using the **Turn Off** option unless absolutely necessary, as it can cause data corruption, especially in database-driven VMs. Always aim for a graceful shutdown to maintain data integrity.

5. **Test Auto Start/Stop Configurations**:
   - Before applying these settings in a production environment, thoroughly test automatic start/stop configurations to ensure that they work as expected and do not disrupt critical operations.

---

### Summary

- You can configure **automatic start** and **stop** actions for VMs to manage their behavior during host boot and shutdown.
- **Startup priority** and **startup delay** help control the order and timing of VM startups, ensuring that essential VMs come online first.
- **Auto start/stop actions** can be configured via the **Hyper-V Manager** or PowerShell, allowing for flexible management of VMs in both test and production environments.
- Following best practices, such as graceful shutdown and careful startup sequencing, will help ensure that your VMs and applications remain stable and secure during host restarts.

---