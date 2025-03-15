# Machine Learning and AI Products

## 1. Overview
Google Cloud offers a wide range of **AI and ML services** beyond Vertex AI, including **pre-trained AI APIs for Vision, Speech, and NLP**, as well as chatbot solutions and advanced AI patterns.

---

## 2. AI APIs: Vision, Speech, and NLP
Google provides **pre-trained AI APIs** that allow developers to integrate AI capabilities into their applications **without building custom ML models**.

### **1. Vision AI (Image Processing & OCR)**
- Detects objects, faces, logos, and landmarks.
- Extracts text from images (OCR) via **Document AI**.
- Supports **AutoML Vision** for custom training.

#### **Example: Running Image Analysis with Vision API**
```sh
gcloud ml vision detect-labels gs://my-bucket/sample-image.jpg
```

### **2. Speech-to-Text & Text-to-Speech**
- Converts audio to text with **Speech-to-Text API**.
- Synthesizes natural-sounding speech with **Text-to-Speech API**.
- Supports over **125 languages and dialects**.

#### **Example: Converting Audio to Text**
```sh
gcloud ml speech recognize-long-running \
  --config=config.json \
  --audio=gs://my-bucket/sample-audio.flac
```

### **3. Natural Language Processing (NLP)**
- Analyzes **sentiment, syntax, and entity recognition**.
- Supports **AutoML NLP** for training custom models.
- Enables **translation and language detection**.

#### **Example: Analyzing Sentiment in Text**
```sh
gcloud ml language analyze-sentiment --content="Google Cloud is amazing!"
```

---

## 3. Chatbot Solutions & Conversational AI
### **1. Dialogflow for Virtual Agents**
Dialogflow enables **AI-powered chatbots** with natural language understanding.
- Supports **multi-turn conversations**.
- Integrates with **Google Assistant, WhatsApp, and Messenger**.
- Uses **prebuilt agents** for quick deployment.

#### **Example: Creating a Dialogflow Agent**
```sh
gcloud dialogflow agents create \
  --display-name="MyChatbot" \
  --default-language-code="en" \
  --time-zone="America/Los_Angeles"
```

### **2. Contact Center AI (CCAI)**
- Enhances **customer service automation**.
- Uses **conversational AI with live agent handoff**.
- Integrates with **Google Cloud Speech and NLP APIs**.

---

## 4. Advanced AI Patterns
### **1. Recommendation Systems**
- Uses **Google AI Recommendations AI** to personalize shopping experiences.
- Analyzes **user behavior** to optimize suggestions.

#### **Example: Deploying a Recommendation AI Model**
```sh
gcloud ai endpoints deploy --region=us-central1 --model=recommendation-ai
```

### **2. AI-Powered Search & Document Processing**
- **Document AI** extracts structured data from invoices, contracts, and forms.
- **Vertex AI Search** enhances **e-commerce and enterprise search**.

#### **Example: Running Document AI Processing**
```sh
gcloud documentai processors process-document \
  --processor=my-ocr-processor \
  --input-gcs-uri=gs://my-bucket/invoice.pdf
```

---

## 5. Final Checklist
✅ Use **Vision AI** for image classification, OCR, and object detection.  
✅ Integrate **Speech-to-Text** and **Text-to-Speech** for voice-based applications.  
✅ Leverage **Natural Language AI** for sentiment analysis and entity recognition.  
✅ Deploy **Dialogflow** for chatbot and conversational AI experiences.  
✅ Implement **advanced AI patterns** like Recommendations AI and Document AI.  

📌 **More Resources:** [Google Cloud AI & ML Documentation](https://cloud.google.com/products/ai)

