# **AppArmor and SELinux: Linux Mandatory Access Control (MAC) Systems**

Linux provides two major **Mandatory Access Control (MAC)** frameworks: **AppArmor** and **SELinux**. 
These security systems **restrict** application behavior beyond traditional user/group permissions, enhancing system security by preventing unauthorized access.

---

### **Best Practices for AppArmor**
✅ Keep profiles in **enforce mode** whenever possible.  
✅ Use **complain mode** for debugging issues before enforcing.  
✅ Regularly monitor logs in `/var/log/syslog` for AppArmor violations.  
✅ Create **custom profiles** for non-standard applications.  

---

## **AppArmor (Application Armor)**

### **Overview**
AppArmor is a **profile-based security framework** mainly used in **Debian-based distributions** (Ubuntu, openSUSE). It restricts applications using security profiles, specifying what resources an application can access.

### **How AppArmor Works**
- Works by defining **per-application profiles** stored in `/etc/apparmor.d/`
- Can operate in **enforce mode** (actively blocking unauthorized actions) or **complain mode** (logging policy violations without blocking them)
- Uses **path-based access control**, meaning permissions are set based on file paths

### **Key AppArmor Commands**
| Command | Description |
|---------|-------------|
| `sudo aa-status` | Check the current AppArmor status and loaded profiles. |
| `sudo aa-enforce /etc/apparmor.d/*` | Enforce all AppArmor profiles. |
| `sudo aa-complain /etc/apparmor.d/*` | Set profiles to complain mode (log-only). |
| `sudo aa-disable /etc/apparmor.d/profile` | Disable a specific AppArmor profile. |
| `sudo apparmor_parser -r /etc/apparmor.d/profile` | Reload an updated profile. |

### **Managing AppArmor Profiles**
- Profiles define what files, network access, and resources an application can use.
- Located in `/etc/apparmor.d/`
- Example: Restricting `nginx`:
  ```plaintext
  /usr/sbin/nginx {
      include <abstractions/base>
      network inet tcp,
      /var/www/** r,
      /etc/nginx/** r,
  }
  ```
- Generate a new profile:
  ```bash
  sudo aa-genprof /usr/bin/application
  ```

---
