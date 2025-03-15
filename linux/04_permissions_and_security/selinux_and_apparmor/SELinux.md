---

### **Best Practices for SELinux**
✅ Keep SELinux in **Enforcing mode** whenever possible.  
✅ Use `Permissive` mode only for debugging (not in production).  
✅ Regularly check logs (`/var/log/audit/audit.log`) for policy violations.  
✅ Use `restorecon` after modifying system files to reset SELinux labels.  

---

## **SELinux (Security-Enhanced Linux)**

### **Overview**
SELinux is a **label-based security framework** primarily used in **Red Hat-based distributions** (RHEL, Fedora, CentOS, AlmaLinux). It enforces strict access controls based on security policies.

### **How SELinux Works**
- Uses **context-based security labels** instead of file paths.
- Operates in **three modes**:
  - `Enforcing` (default) → Blocks unauthorized actions.
  - `Permissive` → Logs violations but does not block.
  - `Disabled` → Turns off SELinux.
- Security contexts define rules for **users, processes, and files**.

### **Key SELinux Commands**
| Command | Description |
|---------|-------------|
| `getenforce` | Check the current SELinux mode (Enforcing, Permissive, Disabled). |
| `sudo setenforce 1` | Enable SELinux Enforcing mode. |
| `sudo setenforce 0` | Switch SELinux to Permissive mode. |
| `sestatus` | Show detailed SELinux status and policy information. |
| `ls -Z /path/to/file` | View SELinux security labels for a file. |
| `chcon -t httpd_sys_content_t /var/www/html/index.html` | Temporarily change file security context. |
| `restorecon -Rv /var/www/html` | Restore default SELinux contexts for files. |

### **Managing SELinux Policies**
- SELinux policies determine how files, processes, and users interact.
- Security labels (contexts) are assigned to **files, processes, and users**.
- Example label breakdown:
  ```bash
  ls -Z /var/www/html/index.html
  ```
  Output:
  ```plaintext
  system_u:object_r:httpd_sys_content_t:s0 /var/www/html/index.html
  ```
  - `system_u` → User
  - `object_r` → Role
  - `httpd_sys_content_t` → Type (Defines access rules for Apache)
  - `s0` → Security Level

### **Allowing SELinux Access (Troubleshooting)**
- **Audit logs** provide information on blocked actions:
  ```bash
  sudo ausearch -m AVC -c httpd | audit2why
  ```
- **Create SELinux rules to allow blocked actions**:
  ```bash
  sudo ausearch -m AVC -c httpd | audit2allow -M my_httpd_rule
  sudo semodule -i my_httpd_rule.pp
  ```

---
