
## **Introduction to Systemd**

Systemd is the **modern init system** used in most Linux distributions. It is responsible for booting the system, managing services, and handling system states.

- Systemd replaces traditional init systems like **SysVinit** and **Upstart**.
- Uses **unit files** to define how services, devices, and mount points operate.
- Provides faster boot times, better dependency handling, and parallel startup.

---

## **Systemd Units**

Systemd units describe resources that systemd manages. They are stored in:
- `/etc/systemd/system/` (User-defined services)
- `/usr/lib/systemd/system/` (System-wide services)

### **Common Unit Types**
| Unit Type | Description |
|-----------|-------------|
| `service` | Manages system services (e.g., SSH, Apache). |
| `socket` | Controls inter-process communication (IPC) sockets. |
| `target` | Represents system states (similar to runlevels). |
| `timer` | Schedules tasks (replaces cron jobs). |
| `mount` | Manages filesystem mount points. |

To list all active units:
```bash
systemctl list-units --type=service
```

---

## **Systemd Targets (Replacing Runlevels)**

Systemd uses **targets** instead of traditional runlevels:

| Runlevel | Systemd Target | Description |
|----------|---------------|-------------|
| 0 | `poweroff.target` | System shutdown. |
| 1 | `rescue.target` | Single-user mode. |
| 3 | `multi-user.target` | Multi-user, no GUI. |
| 5 | `graphical.target` | Multi-user with GUI. |
| 6 | `reboot.target` | System reboot. |

To change the default boot target:
```bash
sudo systemctl set-default multi-user.target
```
To switch to a different target:
```bash
sudo systemctl isolate graphical.target
```

---
