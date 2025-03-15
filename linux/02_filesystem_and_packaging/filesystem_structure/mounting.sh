
# partition table manipulator for Linux
fdisk -l                                # list all partitions on all disks
fdisk /dev/sda                          # open fdisk for a specific disk (e.g., /dev/sda)

# partition manipulation program
parted /dev/sda                         # open parted for a specific disk (e.g., /dev/sda)
parted /dev/sda print                   # print partition table of the specified disk

# list information about block devices
lsblk                                   # list all block devices
lsblk -f                                # list block devices with filesystem information

# locate/print block device attributes
blkid                                   # show attributes of all block devices
blkid /dev/sda1                         # show attributes of a specific block device

# build a Linux file system
mkfs.ext4 /dev/sda1                     # create an ext4 filesystem on /dev/sda1
mkfs.vfat /dev/sdb1                     # create a FAT32 filesystem on /dev/sdb1

# mount a file system
mount /dev/sda1 /mnt                    # mount the filesystem on /dev/sda1 to /mnt
mount -o loop image.iso /mnt            # mount an ISO file

# unmount file systems
umount /mnt                             # unmount the filesystem mounted at /mnt
umount -a                               # unmount all mounted filesystems
