
## **Kernel Boot Parameters**

Kernel parameters modify the system's behavior at boot time.

### **Modifying Kernel Parameters in GRUB**
1. Edit `/etc/default/grub`:
   ```plaintext
   GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
   ```
2. Update GRUB configuration:
   ```bash
   sudo update-grub
   ```

### **Common Boot Parameters**
| Parameter | Description |
|-----------|-------------|
| `quiet` | Suppress boot messages. |
| `splash` | Show graphical splash screen. |
| `nomodeset` | Disable graphics driver auto-detection. |
| `single` | Boot into single-user mode. |
| `init=/bin/bash` | Boot directly into a shell. |
| `rw` | Mount root filesystem in read-write mode. |

---
