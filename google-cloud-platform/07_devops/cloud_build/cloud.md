# Cloud Build

## 1. Overview
Cloud Build is a **fully managed CI/CD service** that allows users to build, test, and deploy applications at scale. It supports **build triggers, Docker builds, artifact storage, and integrations with GitHub and GitLab**.

---

## 2. Build Triggers
Build triggers allow **automated builds** based on code changes in repositories.

### **Supported Triggers**
- **GitHub & GitLab commits** (push events)
- **Pull request updates**
- **Tag-based releases**
- **Cloud Storage uploads**

### **Creating a GitHub Build Trigger**
```sh
gcloud beta builds triggers create github \
  --name=my-github-trigger \
  --repo-owner=my-org \
  --repo-name=my-repo \
  --branch-pattern="main" \
  --build-config=cloudbuild.yaml
```

### **Creating a GitLab Build Trigger**
```sh
gcloud beta builds triggers create gitlab \
  --name=my-gitlab-trigger \
  --repo-owner=my-org \
  --repo-name=my-repo \
  --branch-pattern="main" \
  --build-config=cloudbuild.yaml
```

---

## 3. Docker Builds
Cloud Build supports **containerized builds** using Docker.

### **Building a Docker Image**
```sh
gcloud builds submit --tag gcr.io/my-project/my-image
```

### **Using a `cloudbuild.yaml` for Docker Builds**
```yaml
steps:
  - name: "gcr.io/cloud-builders/docker"
    args: ["build", "-t", "gcr.io/my-project/my-image", "."]
images:
  - "gcr.io/my-project/my-image"
```

---

## 4. Artifact Storage
Built artifacts are stored in **Artifact Registry** or **Cloud Storage**.

### **Pushing an Image to Artifact Registry**
```sh
gcloud auth configure-docker
```
```sh
gcloud builds submit --tag us-central1-docker.pkg.dev/my-project/my-repo/my-image
```

### **Storing Artifacts in Cloud Storage**
```sh
gcloud builds submit --gcs-log-dir=gs://my-build-logs/
```

---

## 5. Integrations with GitHub and GitLab
Cloud Build integrates with **GitHub and GitLab** for automated CI/CD pipelines.

### **Connecting Cloud Build to GitHub**
```sh
gcloud beta builds triggers create github \
  --repo-owner=my-org \
  --repo-name=my-repo \
  --branch-pattern="main"
```

### **Connecting Cloud Build to GitLab**
```sh
gcloud beta builds triggers create gitlab \
  --repo-owner=my-org \
  --repo-name=my-repo \
  --branch-pattern="main"
```

---

## 6. Final Checklist
✅ Use **build triggers** for automated CI/CD workflows.  
✅ Configure **Docker builds** in `cloudbuild.yaml`.  
✅ Store artifacts in **Artifact Registry or Cloud Storage**.  
✅ Integrate with **GitHub or GitLab** for automated pipelines.  
✅ Optimize build times by **caching dependencies**.  

📌 **More Resources:** [Google Cloud Build Documentation](https://cloud.google.com/build/docs/)