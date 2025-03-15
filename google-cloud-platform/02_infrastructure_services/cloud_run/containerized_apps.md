# Cloud Run

## 1. Overview
Google Cloud Run is a **fully managed serverless platform** for running containerized applications. It automatically scales containers based on traffic demand and supports both public and private endpoints.

---

## 2. Managing Containerized Apps with Cloud Run

### **1. Deploying a Container to Cloud Run**
Cloud Run allows deploying containers from **Google Artifact Registry** or **Docker Hub**.

```sh
gcloud run deploy my-service \
  --image gcr.io/my-project/my-image \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

### **2. Key Features**
- **Fully managed**: No need to manage infrastructure.
- **Stateless execution**: Containers are ephemeral and auto-scale to zero.
- **Support for HTTP and event-driven execution**.
- **Flexible deployment options**: Works with Cloud Build, GitHub Actions, and Terraform.

---

## 3. Scaling and Concurrency in Cloud Run

### **1. Autoscaling**
Cloud Run scales **horizontally** based on request load.

- **Default settings**: Scale to zero when idle.
- **Maximum instances**: Limit the number of running instances to control cost.
- **Minimum instances**: Keep instances warm for better response times.

```sh
gcloud run services update my-service \
  --min-instances 1 \
  --max-instances 100
```

### **2. Concurrency Settings**
Each instance can handle multiple requests concurrently.

- Default **concurrency = 80** (up to 250).
- **Lower concurrency** → better isolation, higher costs.
- **Higher concurrency** → better resource efficiency.

```sh
gcloud run services update my-service \
  --concurrency 10
```

---

## 4. Private Service Endpoints

### **1. Restricting Public Access**
By default, Cloud Run services are publicly accessible. Use **Cloud IAM** to restrict access.

```sh
gcloud run services add-iam-policy-binding my-service \
  --member="user:example@gmail.com" \
  --role="roles/run.invoker"
```

### **2. Enabling Private Cloud Run with VPC**
- Use **VPC Service Controls** to restrict access to internal resources.
- Deploy services **inside a VPC** using **Cloud Run for Anthos**.

```sh
gcloud beta run deploy my-private-service \
  --image gcr.io/my-project/my-image \
  --region us-central1 \
  --vpc-connector my-vpc-connector \
  --no-allow-unauthenticated
```

---

## 5. Final Checklist
✅ Deploy **containerized apps** seamlessly with Cloud Run.
✅ Configure **autoscaling and concurrency** for cost and performance.
✅ Restrict access using **IAM roles** and private endpoints.
✅ Use **VPC Service Controls** for enhanced security.
✅ Integrate with **Cloud Pub/Sub** for event-driven applications.

📌 **More Resources:** [Google Cloud Run Documentation](https://cloud.google.com/run/docs/)

