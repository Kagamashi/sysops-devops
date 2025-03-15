
## **Kernel Module Management**

### **Loading and Unloading Modules**
Kernel modules extend the functionality of the Linux kernel by adding support for hardware, filesystems, or networking features.

| Command | Description |
|---------|-------------|
| `lsmod` | List all currently loaded kernel modules. |
| `modinfo module_name` | Display information about a module. |
| `sudo modprobe module_name` | Load a kernel module. |
| `sudo modprobe -r module_name` | Unload a kernel module. |
| `echo module_name | sudo tee -a /etc/modules-load.d/custom.conf` | Load a module at boot. |

### **Blacklisting Modules**
To prevent a module from loading at boot, add it to `/etc/modprobe.d/blacklist.conf`:
```plaintext
blacklist module_name
```

---
