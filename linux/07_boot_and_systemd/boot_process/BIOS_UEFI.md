
## **BIOS and UEFI**

BIOS (Basic Input/Output System) and UEFI (Unified Extensible Firmware Interface) are responsible for initializing hardware before handing control over to the operating system.

### **BIOS (Legacy Firmware)**
- Older firmware used in traditional boot systems.
- Relies on **MBR (Master Boot Record)** for booting.
- Loads the first boot sector (512 bytes) containing the bootloader.

### **UEFI (Modern Firmware)**
- Replaces BIOS and supports **GPT (GUID Partition Table)**.
- Uses **EFI System Partition (ESP)** to store bootloaders.
- Provides secure boot functionality to prevent unauthorized OS from loading.
- Uses `efibootmgr` for managing boot entries:
  ```bash
  sudo efibootmgr -v
  ```

---
