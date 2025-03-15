
## **Kernel Parameters (`sysctl`)**

Kernel parameters control system behavior and can be dynamically modified using the `sysctl` command.

### **Viewing and Modifying Kernel Parameters**
| Command | Description |
|---------|-------------|
| `sysctl -a` | List all kernel parameters. |
| `sysctl net.ipv4.ip_forward` | Check the value of a specific parameter. |
| `sudo sysctl -w net.ipv4.ip_forward=1` | Modify a kernel parameter at runtime. |
| `echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward` | Alternative way to modify a kernel parameter. |

### **Persisting Kernel Parameter Changes**
- Edit `/etc/sysctl.conf` and add the desired setting:
  ```plaintext
  net.ipv4.ip_forward = 1
  vm.swappiness = 10
  ```
- Apply changes without rebooting:
  ```bash
  sudo sysctl -p
  ```

---
