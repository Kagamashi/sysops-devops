# Cloudflare Workers Basics (Azure Context)

## **1. Introduction to Cloudflare Workers**
Cloudflare Workers is a serverless platform that allows developers to run JavaScript, TypeScript, or WebAssembly code at Cloudflare’s edge locations. This reduces latency and improves performance by processing requests closer to the user.

### **Key Benefits:**
- **Global Deployment**: Code runs across Cloudflare’s worldwide network.
- **Low Latency**: Reduces round-trip time by executing logic near the user.
- **Scalability**: Automatically handles traffic without managing infrastructure.
- **Integrates with Azure**: Can be used alongside Azure Functions, App Services, or Kubernetes.

---

## **2. Writing a Simple Worker Script**
Workers handle HTTP requests and responses using a simple event-driven API.

### **Example: Hello World Worker**
```javascript
addEventListener("fetch", event => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  return new Response("Hello from Cloudflare Workers!", {
    headers: { "content-type": "text/plain" }
  });
}
```

### **Deploying the Worker**
1. Navigate to **Cloudflare Dashboard → Workers → Create Worker**.
2. Paste the script and click **Deploy**.
3. Test the worker using the assigned **Worker URL**.

---

## **3. Using Workers KV (Key-Value Storage)**
Workers KV is a distributed key-value store for persisting data globally.

### **Example: Storing and Retrieving Data**
```javascript
export default {
  async fetch(request) {
    const value = await MY_NAMESPACE.get("myKey");
    return new Response(value || "No value found");
  }
};
```

### **Steps to Use KV Storage**
1. **Enable KV Storage** in Cloudflare Dashboard under **Workers → KV**.
2. **Create a Namespace** and bind it to the Worker.
3. **Store Data Using Wrangler:**
   ```sh
   wrangler kv:key put myKey "Hello from KV!" --namespace-id <KV_NAMESPACE_ID>
   ```

---

## **4. Deploying Workers via Wrangler (CLI Tool)**
Wrangler is a command-line tool for managing Cloudflare Workers.

### **Installation**
```sh
npm install -g wrangler
```

### **Authenticate and Deploy**
```sh
wrangler login
wrangler init my-worker
wrangler publish
```

### **Testing Locally**
```sh
wrangler dev
```

---

## **5. Best Practices for Cloudflare Workers**
### **Performance and Optimization**
- Keep Worker scripts **small** (<1MB) to reduce execution latency.
- Use **caching** (Cloudflare Cache API) to minimize unnecessary requests to origin servers.
- Minimize external API calls to avoid increasing response time.

### **Concurrency and Execution Limits**
- **CPU Limit:** 50ms per execution (for standard Workers).
- **Memory Limit:** 128MB (higher limits available with paid plans).
- **Requests per Second (RPS):** Unlimited but subject to rate limits in free plans.

### **Security and Reliability**
- Use **environment variables** instead of hardcoding credentials.
- Validate incoming requests to prevent abuse.
- Monitor execution logs in **Cloudflare Workers Analytics** and integrate with **Azure Monitor**.

By leveraging Cloudflare Workers alongside Azure services, developers can build highly performant, globally distributed applications while minimizing infrastructure complexity.
