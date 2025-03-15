Linux follows the **Filesystem Hierarchy Standard (FHS)**, which defines a structured layout for system directories.

## **FHS (Filesystem Hierarchy Standard)**
The **FHS** ensures consistency across Linux distributions. Below are the most important directories and their purposes:

| **Directory**  | **Purpose** |
|---------------|------------|
| `/`           | Root directory (contains everything). |
| `/bin/`       | Essential user binaries (e.g., `ls`, `cp`, `mv`, `rm`). |
| `/sbin/`      | Essential system binaries (e.g., `fdisk`, `mount`, `fsck`). |
| `/etc/`       | Configuration files (e.g., `/etc/fstab`, `/etc/hosts`). |
| `/var/`       | Variable data (logs, cache, spools, temporary files). |
| `/usr/`       | User applications and utilities (non-essential binaries). |
| `/home/`      | User home directories (e.g., `/home/user`). |
| `/root/`      | Root user’s home directory. |
| `/tmp/`       | Temporary files (cleared on reboot). |
| `/opt/`       | Third-party software installations. |
| `/lib/`       | Essential system libraries for `/bin` and `/sbin`. |
| `/dev/`       | Device files (e.g., `/dev/sda1` for disk partitions). |
| `/mnt/`       | Temporary mount points. |
| `/media/`     | Mount points for removable media (USB, CD/DVD). |
| `/proc/`      | Virtual filesystem for system information (processes). |
| `/sys/`       | Virtual filesystem for kernel-related information. |
| `/boot/`      | Boot loader files (kernel, GRUB configuration). |
| `/srv/`       | Data for network services (e.g., web server files). |

---

## User and Group Management

- `/etc/passwd`:  Contains user account information.
- `/etc/shadow`:  Stores encrypted user passwords and password policies.
- `/etc/group`:   Contains group account information.
- `/etc/gshadow`: Stores group passwords and additional group-related security information.
- `/etc/skel`:    Directory for default files to be copied to a new user's home directory.
- `/etc/security/limits.conf`: Configures user resource limits.
- `/etc/default/useradd`: Contains default values for user account creation.
- `/etc/login.defs`: Defines system-wide settings for user logins.

---

## System Configuration

- `/etc/profile.d`: Contains scripts to configure the environment for all users.
- `/etc/sudoers`: File for configuring sudo permissions. Should be edited with `sudo visudo`.
- `/etc/sysctl.conf`: Configures kernel parameters at runtime.

---

## Logs

- `/var/log/auth.log`: Authentication logs (Ubuntu).
- `/var/log/secure`:   Authentication logs (Red Hat).

---

## Networking

- `/etc/hosts`: Maps hostnames to IP addresses.
- `/etc/resolv.conf`: Configuration file for DNS servers.
- `/etc/network/interfaces`: Networking configuration for Debian-based systems.
- `/etc/sysconfig/network-scripts/`: Networking scripts for Red Hat-based systems.

---

## Security and Authentication

- `/etc/pam.d`: Directory for Pluggable Authentication Module (PAM) configuration files.
- `/etc/ssh/`:  Configuration files for the SSH server and client.

---

## Application and Package Management

- `/etc/apt/`: Configuration files for the Advanced Package Tool (APT) on Debian-based systems.
- `/etc/yum.conf`: Configuration file for the YUM package manager on Red Hat-based systems.
- `/etc/systemd/`: Configuration files for systemd services and units.

---

## Development and Version Control

- `~/.git/config`: Configuration file for Git repositories.
- `/usr/local/`:   Directory for locally compiled applications and files.

---

## Miscellaneous

- `/etc/fstab`:    Contains information about filesystems and their mount points.
- `/etc/crontab`:  Configuration file for cron jobs.
- `/etc/hostname`: Contains the hostname of the system.
