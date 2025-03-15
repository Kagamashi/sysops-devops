
## **Exec Plugins**
- These are standalone executable scripts or binaries that modify resources.
- They receive input via `stdin` and return modified YAML via `stdout`.
- Can be written in any language (e.g., Bash, Python, Go).

### **Example Exec Plugin (Bash)**
```sh
#!/bin/bash
jq '.metadata.labels.environment = "staging"'
```

---
