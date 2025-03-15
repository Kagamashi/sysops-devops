# Vertex AI

## 1. Overview
Vertex AI is **Google Cloud’s unified AI/ML platform**, providing tools for **model training, deployment, automation, and AutoML**. It supports **custom model training, notebooks, pipelines, and hyperparameter tuning**.

---

## 2. ML Model Training
Vertex AI enables **training models on managed infrastructure**, supporting both **AutoML and custom training** workflows.

### **1. AutoML Training (No-Code/Low-Code)**
- AutoML allows training models **without writing ML code**.
- Supports **tabular, vision, text, and video data**.

#### **Example: Creating an AutoML Training Job**
```sh
gcloud ai custom-jobs create \
  --region=us-central1 \
  --display-name=my-automl-job \
  --dataset=my-dataset-id \
  --model-display-name=my-automl-model
```

### **2. Custom Training (Bring Your Own Model)**
- Supports **TensorFlow, PyTorch, XGBoost, and Scikit-learn**.
- Runs on **CPU, GPU, or TPU machines**.

#### **Example: Submitting a Custom Training Job**
```sh
gcloud ai custom-jobs create \
  --region=us-central1 \
  --display-name=my-custom-training \
  --python-package-uris=gs://my-bucket/training_package.tar.gz \
  --python-module=my_training_script \
  --machine-type=n1-standard-4 \
  --accelerator=type=NVIDIA_TESLA_K80,count=1
```

---

## 3. Model Deployment
Trained models can be deployed as **RESTful endpoints** with autoscaling and monitoring.

### **1. Deploying a Model to an Endpoint**
```sh
gcloud ai endpoints create --region=us-central1 --display-name=my-endpoint
```
```sh
gcloud ai models deploy --region=us-central1 --model=my-model-id --endpoint=my-endpoint-id
```

### **2. Making a Prediction**
```sh
gcloud ai endpoints predict --region=us-central1 --endpoint=my-endpoint-id --json-request=instance.json
```

---

## 4. Vertex AI Pipelines
Vertex AI Pipelines allow **orchestrating ML workflows** with automation, versioning, and reproducibility.

### **1. Creating a Pipeline Run**
```sh
gcloud ai pipelines run \
  --region=us-central1 \
  --pipeline-name=my-pipeline \
  --parameter-values='{"input_data":"gs://my-bucket/data.csv"}'
```

---

## 5. Vertex AI Notebooks
Managed **JupyterLab-based notebooks** for data exploration and model training.

### **1. Creating a Notebook Instance**
```sh
gcloud ai notebooks instances create my-notebook \
  --vm-image-name=deeplearning-common-cpu \
  --machine-type=n1-standard-4 \
  --region=us-central1
```

### **2. Connecting to the Notebook**
```sh
gcloud ai notebooks instances list
```
```sh
gcloud ai notebooks instances describe my-notebook
```

---

## 6. Final Checklist
✅ Use **AutoML** for quick, no-code model training.  
✅ Train **custom ML models** using TensorFlow, PyTorch, or XGBoost.  
✅ Deploy models as **scalable endpoints** for real-time predictions.  
✅ Use **Vertex AI Pipelines** to automate ML workflows.  
✅ Work with **managed notebooks** for seamless development.  

📌 **More Resources:** [Google Vertex AI Documentation](https://cloud.google.com/vertex-ai/docs/)

