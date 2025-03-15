
## **3. Best SSH Practices**
✅ **Use Key-Based Authentication** instead of passwords:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-copy-id user@remote-server
```
✅ **Disable Root Login** by setting `PermitRootLogin no`.
✅ **Restrict Users** with `AllowUsers` in `sshd_config`.
✅ **Use a Non-Standard SSH Port** to reduce automated attacks.
✅ **Monitor Failed Login Attempts**:
```bash
sudo journalctl -u sshd --since "1 hour ago"
```

---

## **1. SSH Configuration (`/etc/ssh/sshd_config`)**
The SSH daemon configuration file (`/etc/ssh/sshd_config`) controls how the SSH server operates.

### **Key Security Settings:**
Edit the file using:
```bash
sudo nano /etc/ssh/sshd_config
```
| Option | Description |
|--------|-------------|
| `PermitRootLogin no` | Disables root login for security. |
| `PasswordAuthentication no` | Forces key-based authentication. |
| `AllowUsers user1 user2` | Restricts SSH access to specific users. |
| `PermitEmptyPasswords no` | Prevents logins with empty passwords. |
| `MaxAuthTries 3` | Limits login attempts to prevent brute force attacks. |
| `Port 2222` | Changes the default SSH port from 22 to 2222 (optional). |

After making changes, restart SSH:
```bash
sudo systemctl restart sshd
```

---

## **2. Known Hosts (`~/.ssh/known_hosts`)**
The `known_hosts` file stores fingerprints of previously connected SSH servers to prevent MITM attacks.

### **Managing SSH Known Hosts:**
- View stored hosts:
  ```bash
  cat ~/.ssh/known_hosts
  ```
- Remove an entry (if host key changes and prevents login):
  ```bash
  ssh-keygen -R hostname_or_ip
  ```

---
