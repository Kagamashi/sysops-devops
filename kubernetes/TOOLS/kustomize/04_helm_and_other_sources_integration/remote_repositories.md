
## **Using Remote Bases and Repositories**
Kustomize supports referencing remote Git repositories as bases.

### **Referencing a Remote Base**
```yaml
resources:
  - github.com/example-org/kustomize-base//base?ref=v1.2.0
```

### **Handling Version Pinning**
- **Best practice:** Always specify a `ref` to avoid pulling unintended updates.
- Example:
```yaml
resources:
  - github.com/example-org/kustomize-base//base?ref=stable
```

### **Authentication for Private Repos**
For private repositories, use:
```sh
git clone https://username:token@github.com/example-org/kustomize-base.git
```
Then reference the local clone in `kustomization.yaml`.

### **Best Practices for Remote Bases**
- **Use version pinning (`ref=`) to ensure stability.**
- **For private repositories, use SSH authentication or personal access tokens.**
- **Structure remote bases in a reusable format** to maximize flexibility.

By leveraging remote bases, Kustomize enables teams to standardize configurations across multiple repositories while maintaining flexibility and security.

