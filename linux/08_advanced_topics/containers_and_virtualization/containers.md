
## **Containers: Docker, Podman, and LXC**

Containers provide **lightweight, isolated environments** to run applications.

### **Docker**
Docker is the most widely used container runtime for packaging applications.

| Command | Description |
|---------|-------------|
| `docker ps` | List running containers. |
| `docker images` | List available container images. |
| `docker run -d -p 8080:80 nginx` | Run an Nginx container in detached mode. |
| `docker stop container_id` | Stop a running container. |
| `docker rm container_id` | Remove a container. |
| `docker rmi image_id` | Remove an image. |
| `docker exec -it container_id bash` | Access a running container shell. |

To install Docker:
```bash
sudo apt install docker.io  # Debian/Ubuntu
sudo dnf install docker-ce  # Fedora/RHEL
```

### **Podman (Rootless Alternative to Docker)**
Podman is a container engine similar to Docker but runs **without a daemon**.

| Command | Description |
|---------|-------------|
| `podman ps` | List running containers. |
| `podman images` | List available images. |
| `podman run -d -p 8080:80 nginx` | Run a container (same as Docker). |
| `podman stop container_id` | Stop a running container. |
| `podman exec -it container_id bash` | Access a running container shell. |

To install Podman:
```bash
sudo apt install podman  # Debian/Ubuntu
sudo dnf install podman  # Fedora/RHEL
```

### **LXC (Linux Containers)**
LXC provides **system-level virtualization** for running full Linux distributions in containers.

| Command | Description |
|---------|-------------|
| `lxc-create -t download -n my-container` | Create an LXC container. |
| `lxc-start -n my-container -d` | Start an LXC container. |
| `lxc-attach -n my-container` | Attach to a running container. |
| `lxc-stop -n my-container` | Stop an LXC container. |

To install LXC:
```bash
sudo apt install lxc lxc-utils  # Debian/Ubuntu
sudo dnf install lxc lxc-templates  # Fedora/RHEL
```

---
