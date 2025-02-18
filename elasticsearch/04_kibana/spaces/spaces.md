
## **Using Kibana Spaces for Data Segmentation**
**Kibana Spaces** allow users to **segregate dashboards, visualizations, and settings** into isolated environments.

### **Benefits of Kibana Spaces:**
- **Multitenancy:** Different teams can have their own workspaces.
- **Access Control:** Limit access to dashboards and visualizations.
- **Better Organization:** Separate test and production dashboards.

### **Creating a Kibana Space**
1. Navigate to **Kibana → Stack Management → Spaces**.
2. Click **Create a space**.
3. Enter a **name**, **description**, and **custom logo** (optional).
4. Define **permissions** (user access levels per space).
5. Click **Save**.

### **Assigning Saved Objects to a Space**
- When **saving a dashboard, visualization, or query**, choose the **target space**.
- Use **Spaces Management UI** to move objects between spaces.

### **Switching Between Spaces**
1. Click the **Spaces Selector** (top-right in Kibana UI).
2. Choose the **desired space**.
3. Kibana loads only the **dashboards, visualizations, and settings for that space**.

---
