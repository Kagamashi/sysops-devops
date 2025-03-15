
## **Kernel Tuning for Specific Workloads**

### **Optimizing for Containers (Docker/Kubernetes)**
For **containerized environments**, kernel tuning can improve performance and security:
- **Enable IP forwarding** for networking:
  ```bash
  sudo sysctl -w net.ipv4.ip_forward=1
  ```
- **Increase maximum number of file descriptors:**
  ```bash
  sudo sysctl -w fs.file-max=2097152
  ```
- **Allow more ephemeral ports for container networking:**
  ```bash
  sudo sysctl -w net.ipv4.ip_local_port_range="1024 65535"
  ```
- **Reduce swapping to improve performance:**
  ```bash
  sudo sysctl -w vm.swappiness=10
  ```

### **Optimizing for High-Performance Computing (HPC)**
For **HPC workloads**, latency reduction and CPU efficiency are key:
- **Disable CPU frequency scaling:**
  ```bash
  echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
  ```
- **Increase shared memory limits:**
  ```bash
  sudo sysctl -w kernel.shmmax=68719476736
  sudo sysctl -w kernel.shmall=16777216
  ```
- **Tune network settings for low latency:**
  ```bash
  sudo sysctl -w net.core.netdev_max_backlog=5000
  sudo sysctl -w net.core.somaxconn=1024
  ```

---
