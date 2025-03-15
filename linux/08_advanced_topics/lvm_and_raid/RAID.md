
## **RAID (Redundant Array of Independent Disks)**

RAID provides **performance, redundancy, or both** by combining multiple disks.

### **Common RAID Levels**
| RAID Level | Description | Pros | Cons |
|------------|-------------|------|------|
| **RAID 0** | Striping (no redundancy) | High speed | No fault tolerance |
| **RAID 1** | Mirroring | Full redundancy | Uses double storage |
| **RAID 5** | Striping + Parity | Redundant, efficient storage | Requires 3+ disks |
| **RAID 6** | Striping + Dual Parity | Survives 2 disk failures | Requires 4+ disks |
| **RAID 10** | Mirroring + Striping | High performance, redundancy | Requires 4+ disks |

### **Creating a RAID Array with `mdadm`**
#### **1. Install `mdadm` (if not already installed)**
```bash
sudo apt install mdadm  # Debian/Ubuntu
sudo dnf install mdadm  # RHEL/Fedora
```

#### **2. Create a RAID 1 Array (Mirroring)**
```bash
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb /dev/sdc
```

#### **3. Format and Mount the RAID Device**
```bash
sudo mkfs.ext4 /dev/md0
sudo mount /dev/md0 /mnt
```

#### **4. Verify the RAID Array**
| Command | Description |
|---------|-------------|
| `cat /proc/mdstat` | Show active RAID arrays. |
| `sudo mdadm --detail /dev/md0` | Show detailed RAID information. |

#### **5. Persist RAID Configuration**
To save the RAID configuration, run:
```bash
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u
```

---

```bash
### Software RAID Setup using mdadm
# install mdadm package (Ubuntu/Debian)
sudo apt install mdadm -y

# install mdadm package (CentOS/RHEL)
sudo yum install mdadm -y

sudo mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sda /dev/sdb
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sda /dev/sdb
sudo mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sda /dev/sdb /dev/sdc
sudo mdadm --create /dev/md0 --level=6 --raid-devices=4 /dev/sda /dev/sdb /dev/sdc /dev/sdd
sudo mdadm --create /dev/md0 --level=10 --raid-devices=4 /dev/sda /dev/sdb /dev/sdc /dev/sdd


### Managing RAID Arrays
# save RAID configuration
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf  # Debian-based systems
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm.conf        # RHEL-based systems

# assemble an existing RAID array
sudo mdadm --assemble /dev/md0 /dev/sda /dev/sdb

# stop a RAID array
sudo mdadm --stop /dev/md0

# remove a RAID array
sudo mdadm --remove /dev/md0

# add a new device to a RAID array
sudo mdadm --manage /dev/md0 --add /dev/sdc


### Monitoring RAID Arrays
cat /proc/mdstat
sudo mdadm --detail /dev/md0
watch cat /proc/mdstat  # continuously monitor RAID status
```

---
