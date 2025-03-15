## **Best Practices**
✅ **Use UUIDs instead of `/dev/sdX`** in `/etc/fstab` to avoid device name changes.  
✅ **Use `mount -o noexec,nodev,nosuid`** for security on untrusted partitions.  
✅ **Monitor disk usage with `df -h` and `du -sh`**.  
✅ **Always unmount partitions before removing USB drives (`umount /mnt`)**.  
✅ **Use LVM (Logical Volume Manager) for flexible partitioning**.  

---

## **Mount Points and Filesystem Mounting**
### **What is a Mount Point?**
A **mount point** is a directory where an external storage device (partition, USB drive, network share) is attached to the filesystem.

### **Common Mount Commands**
| Command | Description |
|---------|-------------|
| `mount` | Show currently mounted filesystems. |
| `mount /dev/sdb1 /mnt` | Mount a device (`/dev/sdb1`) to `/mnt`. |
| `umount /mnt` | Unmount a device. |
| `df -h` | Show disk usage in human-readable format. |
| `lsblk` | Show block devices and mount points. |

### **Example: Mounting a USB Drive**
```bash
sudo mount /dev/sdb1 /mnt
cd /mnt  # Access the mounted USB drive
```

---

## **`/etc/fstab` (Filesystem Table)**
The `/etc/fstab` file **defines persistent mount points** that are automatically mounted at boot.

### **Example `/etc/fstab` Entry**
```plaintext
UUID=1234-5678  /mnt/data  ext4  defaults  0  2
```

### **fstab Columns**
| Column | Description |
|--------|-------------|
| `UUID` or `/dev/sdX` | Filesystem identifier (UUID preferred). |
| `Mount Point` | Directory where the filesystem is mounted. |
| `Filesystem Type` | (e.g., `ext4`, `xfs`, `vfat`, `ntfs`). |
| `Options` | Mount options (`defaults`, `noexec`, `ro`, etc.). |
| `Dump` | 0 = No backup, 1 = Backup. |
| `FSCK Order` | 0 = Do not check, 1 = First check, 2 = Later check. |

### **Example: Mounting with `fstab`**
1. **Find the UUID of the partition**:
   ```bash
   blkid /dev/sdb1
   ```
2. **Edit `/etc/fstab`**:
   ```bash
   sudo nano /etc/fstab
   ```
   Add an entry:
   ```plaintext
   UUID=abcd-1234  /mnt/storage  ext4  defaults  0  2
   ```
3. **Apply changes without rebooting**:
   ```bash
   sudo mount -a
   ```

---

## **Partitioning Basics**
Partitioning divides a disk into separate sections for different filesystems.

### **Common Partitioning Tools**
| Tool | Description |
|------|-------------|
| `fdisk` | CLI tool for managing MBR partitions. |
| `parted` | CLI tool for GPT partitions. |
| `lsblk` | View disk and partition layout. |
| `mkfs.ext4 /dev/sdb1` | Format a partition as ext4. |

### **Creating a Partition with `fdisk`**
```bash
sudo fdisk /dev/sdb
```
**Steps:**
1. Press `n` → Create new partition.
2. Press `p` → Primary partition.
3. Enter partition number.
4. Define the start and end sector.
5. Press `w` → Write changes.

### **Formatting a Partition**
```bash
sudo mkfs.ext4 /dev/sdb1
```

### **Checking Disk Usage**
```bash
df -h   # Show mounted filesystems
lsblk   # Show block devices
```

---
