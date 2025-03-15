
## **Logical Volume Manager (LVM)**

LVM is a flexible storage management system that allows for dynamic resizing and allocation of storage resources.

### **LVM Components**
| Component | Description |
|-----------|-------------|
| **Physical Volume (PV)** | Represents physical storage devices (e.g., disks, partitions). |
| **Volume Group (VG)** | Combines multiple PVs into a single storage pool. |
| **Logical Volume (LV)** | Virtual partitions created within a VG, which can be resized dynamically. |

### **Common LVM Commands**
| Command | Description |
|---------|-------------|
| `sudo pvcreate /dev/sdb` | Initialize a disk as a physical volume. |
| `sudo vgcreate my_vg /dev/sdb` | Create a volume group named `my_vg`. |
| `sudo lvcreate -L 10G -n my_lv my_vg` | Create a 10GB logical volume named `my_lv`. |
| `sudo lvextend -L +5G /dev/my_vg/my_lv` | Extend `my_lv` by 5GB. |
| `sudo resize2fs /dev/my_vg/my_lv` | Resize filesystem after extending an LV (for ext-based filesystems). |

### **Displaying LVM Information**
| Command | Description |
|---------|-------------|
| `pvs` | Show physical volumes. |
| `vgs` | Show volume groups. |
| `lvs` | Show logical volumes. |
| `sudo lvdisplay` | Detailed information about logical volumes. |

---

```bash
# Physical Volume (PV)
sudo pvcreate /dev/sda1                    # initialize /dev/sda1 as a physical volume

# Volume Group (VG)
sudo vgcreate vg_data /dev/sda1            # create a volume group 'vg_data' on PV /dev/sda1

# Logical Volume (LV)
sudo lvcreate -L 10G -n lv_data vg_data    # create a logical volume 'lv_data' of size 10G in 'vg_data'


sudo pvdisplay                              # show detailed information about physical volumes
sudo vgdisplay                              # show detailed information about volume groups
sudo lvdisplay                              # show detailed information about logical volumes

sudo lvextend -L +5G /dev/vg_data/lv_data   # increase the size of 'lv_data' by 5GB
sudo resize2fs /dev/vg_data/lv_data         # resize the filesystem after extending an ext4 LV
sudo lvreduce -L -5G /dev/vg_data/lv_data   # decrease the size of 'lv_data' by 5GB (data backup required)

sudo lvcreate --size 1G --snapshot --name lv_snapshot /dev/vg_data/lv_data  # create a 1G snapshot of 'lv_data'
sudo lvremove /dev/vg_data/lv_snapshot                                      # remove the snapshot
```

---
