
## **Git Branching Approach**
Another approach is using **Git branches** to separate environments.

### **Example Workflow:**
1. Create separate branches for each environment:
   ```bash
   git checkout -b dev
   git checkout -b staging
   git checkout -b prod
   ```
2. Store environment-specific configurations in each branch.
3. Merge changes from `dev` → `staging` → `prod` after testing.

### **Pros:**
✅ Clear versioning and history per environment.
✅ Ensures infrastructure changes are reviewed before reaching production.
✅ Works well in **collaborative CI/CD workflows**.

### **Cons:**
❌ Managing multiple branches can become complex.
❌ Switching between environments requires branch changes instead of quick commands.
❌ Not ideal for teams needing real-time environment changes.

---
