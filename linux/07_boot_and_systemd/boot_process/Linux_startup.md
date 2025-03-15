
## **How Linux Starts Up**

### **Boot Process Steps**
1. **BIOS/UEFI Initialization** → Firmware initializes hardware.
2. **Bootloader Execution (GRUB)** → Loads the kernel and `initrd`.
3. **Kernel Initialization** → Loads drivers, mounts the root filesystem.
4. **`init` or `systemd` Starts** → Manages user-space services.
5. **Login Prompt or Graphical Environment** → The system is ready for use.

### **Startup Management with Systemd**
| Command | Description |
|---------|-------------|
| `systemctl list-units --type=service` | List active services. |
| `systemctl enable service` | Enable a service at boot. |
| `systemctl disable service` | Disable a service. |
| `systemctl status service` | Check service status. |

---
