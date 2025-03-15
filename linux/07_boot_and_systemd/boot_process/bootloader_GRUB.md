
## **Bootloader (GRUB)**

The bootloader is responsible for loading the Linux kernel into memory.

### **GRUB (GRand Unified Bootloader)**
- Default bootloader for most Linux distributions.
- Located in `/boot/grub/grub.cfg` (or `/etc/grub.d/` for configuration scripts).
- Allows selecting different kernels and boot parameters.

### **Common GRUB Commands**
| Command | Description |
|---------|-------------|
| `grub-mkconfig -o /boot/grub/grub.cfg` | Regenerate GRUB configuration. |
| `grub-install /dev/sda` | Install GRUB on MBR/GPT disk. |
| `grub-editenv list` | Check saved GRUB environment settings. |
| `sudo update-grub` | Update GRUB configuration (Debian/Ubuntu). |

---
