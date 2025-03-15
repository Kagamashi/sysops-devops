
## **Partitioning Strategies**

### **MBR vs. GPT**
| Partition Table | Max Partition Size | Max Partitions | Boot Compatibility |
|---------------|----------------|--------------|----------------|
| **MBR (Master Boot Record)** | 2TB | 4 primary partitions | Legacy BIOS |
| **GPT (GUID Partition Table)** | 8ZB | 128 partitions | UEFI and modern BIOS |

### **Creating a Partition with `fdisk`**
```bash
sudo fdisk /dev/sdb  # Start partitioning
```
- Press `n` → Create a new partition.
- Press `w` → Write changes and exit.

To apply changes, format and mount:
```bash
sudo mkfs.ext4 /dev/sdb1
sudo mount /dev/sdb1 /mnt
```

---
