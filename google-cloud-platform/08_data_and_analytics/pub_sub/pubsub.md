# Pub/Sub and Dataflow

## 1. Overview
Google Cloud **Pub/Sub** is a messaging service for **real-time event-driven architectures**, while **Dataflow** is a fully managed service for **streaming and batch data processing**. These services enable scalable and reliable **data ingestion, transformation, and delivery**.

---

## 2. Pub/Sub Fundamentals
Pub/Sub is based on a **publish-subscribe** model where messages are sent to **topics** and received by **subscriptions**.

### **1. Key Concepts**
- **Topic**: The entry point where messages are published.
- **Subscription**: The entity that receives messages from a topic.
- **Publisher**: Sends messages to a topic.
- **Subscriber**: Consumes messages from a subscription.
- **Push vs Pull**:
  - **Push**: Messages are delivered to an HTTP endpoint.
  - **Pull**: Subscribers request messages when ready.

### **2. Creating a Pub/Sub Topic**
```sh
gcloud pubsub topics create my-topic
```

### **3. Creating a Subscription**
```sh
gcloud pubsub subscriptions create my-subscription --topic=my-topic
```

### **4. Publishing a Message**
```sh
gcloud pubsub topics publish my-topic --message="Hello, Pub/Sub!"
```

### **5. Receiving Messages (Pull Mode)**
```sh
gcloud pubsub subscriptions pull my-subscription --auto-ack
```

### **6. Configuring a Push Subscription**
```sh
gcloud pubsub subscriptions create my-push-subscription \
  --topic=my-topic \
  --push-endpoint=https://my-endpoint.example.com
```

---

## 3. Dataflow Pipelines
Google Cloud **Dataflow** is a managed **Apache Beam** service for running scalable data pipelines.

### **1. Streaming vs Batch Processing**
| **Processing Type** | **Use Case** | **Example** |
|--------------------|-------------|------------|
| **Streaming** | Real-time data processing | Event-driven analytics, fraud detection |
| **Batch** | Processing large historical datasets | ETL workflows, log analysis |

### **2. Creating a Dataflow Pipeline (Batch Mode)**
```sh
gcloud dataflow jobs run my-batch-job \
  --gcs-location gs://dataflow-templates/latest/GCS_Text_to_BigQuery \
  --region us-central1 \
  --parameters inputFilePattern=gs://my-bucket/*.csv,outputTable=my-project:dataset.table
```

### **3. Creating a Dataflow Streaming Pipeline**
```sh
gcloud dataflow jobs run my-streaming-job \
  --gcs-location gs://dataflow-templates/latest/PubSub_to_BigQuery \
  --region us-central1 \
  --parameters inputTopic=projects/my-project/topics/my-topic,outputTable=my-project:dataset.table
```

---

## 4. Best Practices
### **1. Pub/Sub Best Practices**
✅ Use **dead-letter topics** for handling failed messages.  
✅ Implement **message ordering** where required (e.g., financial transactions).  
✅ Use **acknowledgment deadlines** wisely to prevent message loss.  
✅ Optimize **pull subscribers** using multiple workers for better parallelism.  

### **2. Dataflow Best Practices**
✅ Choose **batch vs streaming** based on latency needs.  
✅ Use **Dataflow templates** for common ETL tasks.  
✅ Optimize **windowing and watermarking** for real-time pipelines.  
✅ Enable **autoscaling** for cost-efficient processing.  

📌 **More Resources:** [Google Cloud Pub/Sub Documentation](https://cloud.google.com/pubsub/docs/) | [Google Cloud Dataflow Documentation](https://cloud.google.com/dataflow/docs/)

