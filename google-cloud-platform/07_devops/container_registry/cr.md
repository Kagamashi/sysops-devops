# Artifact Registry and Container Registry

## 1. Overview
Google Cloud provides **Artifact Registry and Container Registry** for storing and managing container images, Helm charts, OS packages, and other artifacts. These registries include **security scanning and vulnerability detection** to ensure artifact integrity and security.

---

## 2. Storing Container Images
Artifact Registry is the **recommended** solution for managing container images, while **Container Registry (legacy)** is still supported.

### **Creating an Artifact Registry Repository**
```sh
gcloud artifacts repositories create my-repo \
  --repository-format=docker \
  --location=us-central1
```

### **Authenticating Docker to Artifact Registry**
```sh
gcloud auth configure-docker us-central1-docker.pkg.dev
```

### **Pushing an Image to Artifact Registry**
```sh
docker tag my-image us-central1-docker.pkg.dev/my-project/my-repo/my-image:latest
```
```sh
docker push us-central1-docker.pkg.dev/my-project/my-repo/my-image:latest
```

---

## 3. Security Scanning for Containers
Artifact Registry **automatically scans** container images for vulnerabilities.

### **Enabling Security Scanning**
```sh
gcloud artifacts repositories update my-repo \
  --update-labels=security-scanning=enabled
```

### **Viewing Scan Results**
```sh
gcloud artifacts docker images list-vulnerabilities \
  --location=us-central1 \
  --repository=my-repo \
  --format=json
```

---

## 4. Managing Helm Charts
Artifact Registry supports **Helm charts** for Kubernetes deployments.

### **Creating a Helm Repository**
```sh
gcloud artifacts repositories create my-helm-repo \
  --repository-format=helm \
  --location=us-central1
```

### **Pushing a Helm Chart**
```sh
helm package my-chart/
helm push my-chart-0.1.0.tgz oci://us-central1-docker.pkg.dev/my-project/my-helm-repo
```

### **Pulling a Helm Chart**
```sh
helm pull oci://us-central1-docker.pkg.dev/my-project/my-helm-repo/my-chart
```

---

## 5. Managing OS Packages
Artifact Registry supports **Debian, RPM, Maven, npm, and Python (PyPI) packages**.

### **Creating an OS Package Repository**
```sh
gcloud artifacts repositories create my-os-repo \
  --repository-format=apt \
  --location=us-central1
```

### **Uploading a Debian Package**
```sh
gcloud artifacts packages upload my-package \
  --location=us-central1 \
  --repository=my-os-repo \
  --source=my-package.deb
```

### **Installing a Debian Package**
```sh
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] \
https://us-central1-apt.pkg.dev/projects/my-project my-os-repo main" | sudo tee -a /etc/apt/sources.list.d/google-cloud.list
```
```sh
sudo apt update && sudo apt install my-package
```

---

## 6. Final Checklist
✅ Use **Artifact Registry** instead of Container Registry for new deployments.  
✅ Enable **security scanning** for vulnerability detection.  
✅ Store **Helm charts** for Kubernetes package management.  
✅ Use **OS package repositories** to manage Debian, RPM, Maven, npm, or PyPI artifacts.  
✅ Regularly **review and rotate credentials** for authentication.  

📌 **More Resources:** [Google Cloud Artifact Registry Documentation](https://cloud.google.com/artifact-registry/docs/)

