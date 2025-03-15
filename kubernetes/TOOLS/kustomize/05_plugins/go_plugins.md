
## **Go Plugins**
- These are compiled Go binaries that conform to Kustomize’s plugin API.
- Provide better performance and integration with the Kustomize ecosystem.

### **Example Go Plugin Structure**
```go
package main
import (
    "sigs.k8s.io/kustomize/api/resmap"
)
type MyPlugin struct {}
func (p *MyPlugin) Transform(m resmap.ResMap) error {
    return nil
}
```

---
