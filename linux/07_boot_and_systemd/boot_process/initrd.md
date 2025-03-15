
## **Initrd (Initial RAM Disk)**

`initrd` (Initial RAM Disk) is a temporary filesystem used to prepare the system before mounting the actual root filesystem.

### **Purpose of `initrd` and `initramfs`**
- Loads essential drivers (e.g., RAID, LVM, encryption) before mounting root.
- Located in `/boot/initrd.img-*` or `/boot/initramfs-*`.
- Created using:
  ```bash
  sudo mkinitcpio -p linux  # Arch Linux
  sudo dracut --force /boot/initramfs-$(uname -r).img $(uname -r)  # RedHat/Fedora
  ```

---
