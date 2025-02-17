
## **UpDownCounter (Bidirectional Counter)**
- **Use Case:** Tracking values that can increase or decrease (e.g., active users, queue depth).
- **Allows both positive and negative increments.**

### **Python Example**
```python
active_users = meter.create_up_down_counter("active_users")
active_users.add(1, {"status": "logged_in"})
active_users.add(-1, {"status": "logged_out"})
```

#### **Node.js Example**
```javascript
const activeUsers = meter.createUpDownCounter("active_users");
activeUsers.add(1, { status: "online" });
activeUsers.add(-1, { status: "offline" });
```

---
