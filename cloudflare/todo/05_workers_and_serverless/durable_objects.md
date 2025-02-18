
## **Using Durable Objects for Stateful Data**
Durable Objects allow Workers to store and manage per-user or per-connection state with strong consistency.

### **Example: Creating a Counter with Durable Objects**
```javascript
export class Counter {
  constructor(state, env) {
    this.state = state;
  }

  async fetch(request) {
    let count = (await this.state.storage.get("count")) || 0;
    count++;
    await this.state.storage.put("count", count);
    return new Response(`Counter: ${count}`);
  }
}
```

### **Steps to Use Durable Objects**
1. **Define the Durable Object Class** in a Worker script.
2. **Deploy Using Wrangler:**
   ```sh
   wrangler publish
   ```
3. **Bind the Durable Object to a Worker:**
   ```sh
   wrangler d1 create my-counter
   ```

### **Best Practices for Durable Objects**
- **Use Durable Objects for write-heavy, stateful workloads**.
- **Minimize contention** by partitioning Durable Objects per user/session.
- **Integrate with Azure Storage** for long-term data persistence.

---

## **Comparing Workers KV vs. Durable Objects**
| Feature          | Workers KV | Durable Objects |
|----------------|------------|----------------|
| **Use Case**   | Caching, fast lookups | Stateful real-time data |
| **Data Access** | Eventual consistency | Strong consistency |
| **Read Speed** | Fast (global replication) | Slower (single instance per object) |
| **Write Latency** | High | Low |
| **Best For** | Configuration, caching | WebSockets, counters, live sessions |

---
