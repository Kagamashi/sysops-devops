# Cloud Functions

## 1. Overview
Google Cloud Functions is a **serverless event-driven compute platform** that allows running small, single-purpose functions in response to cloud events. It integrates seamlessly with services like **Pub/Sub, Cloud Storage, and HTTP triggers**.

---

## 2. Deploying Cloud Functions
Cloud Functions can be deployed using **Google Cloud Console, gcloud CLI, or Terraform**.

### **1. Deploying an HTTP Function**
```sh
gcloud functions deploy my-http-function \
  --runtime python39 \
  --trigger-http \
  --allow-unauthenticated \
  --region us-central1
```

### **2. Deploying a Pub/Sub Triggered Function**
```sh
gcloud functions deploy my-pubsub-function \
  --runtime nodejs18 \
  --trigger-topic my-topic \
  --region us-central1
```

### **3. Deploying a Cloud Storage Triggered Function**
```sh
gcloud functions deploy my-storage-function \
  --runtime go120 \
  --trigger-bucket my-bucket \
  --region us-central1
```

---

## 3. Scaling and Concurrency
Cloud Functions automatically scales **horizontally** in response to incoming requests or events.

### **Autoscaling Behavior**
- **Scale to zero** when idle.
- **Concurrent execution** depends on the function's runtime (default = 1 per instance).
- **Max instance limits** can be set to prevent excessive scaling.

```sh
gcloud functions deploy my-function \
  --max-instances 10 \
  --region us-central1
```

---

## 4. Integrations with Cloud Services

### **1. Pub/Sub Integration**
- Functions can be triggered when a message is published to a **Pub/Sub topic**.
- Ideal for **event-driven architectures and messaging workflows**.

```js
exports.myPubSubFunction = (event, context) => {
  const message = Buffer.from(event.data, 'base64').toString();
  console.log(`Received message: ${message}`);
};
```

### **2. Cloud Storage Integration**
- Functions can be triggered when files are created, deleted, or modified in a Cloud Storage bucket.
- Useful for **image processing, data pipeline automation, and backups**.

```js
exports.myStorageFunction = (event, context) => {
  const file = event.name;
  console.log(`New file uploaded: ${file}`);
};
```

### **3. HTTP Triggers**
- Functions can be exposed as **REST endpoints**.
- Ideal for **APIs, webhooks, and microservices**.

```js
exports.myHttpFunction = (req, res) => {
  res.status(200).send("Hello, Cloud Functions!");
};
```

---

## 5. Private Service Endpoints
By default, Cloud Functions are publicly accessible. For private access:
- Use **IAM policies** to restrict function invocation.
- Deploy functions **inside a VPC** for internal services.

```sh
gcloud functions add-iam-policy-binding my-function \
  --member="serviceAccount:my-service-account@my-project.iam.gserviceaccount.com" \
  --role="roles/cloudfunctions.invoker"
```

---

## 6. Final Checklist
✅ Use **Pub/Sub for event-driven triggers**.
✅ Integrate with **Cloud Storage for file processing**.
✅ Deploy **HTTP-based functions** for APIs and webhooks.
✅ Configure **scaling limits** to optimize costs and performance.
✅ Secure functions with **IAM policies and VPC integration**.

📌 **More Resources:** [Google Cloud Functions Documentation](https://cloud.google.com/functions/docs/)
