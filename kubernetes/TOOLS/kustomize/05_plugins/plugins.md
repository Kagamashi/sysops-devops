# Kustomize Plugins: Basics and Common Examples

## **1. Types of Kustomize Plugins**
Kustomize supports two types of plugins: go and exec

## **2. Storing Plugin Code and Enabling Plugin Mode**
- Plugins should be placed in:
  ```sh
  $XDG_CONFIG_HOME/kustomize/plugin/<apiGroup>/<kind>/<pluginName>
  ```
- Enable plugin mode by setting:
  ```sh
  export KUSTOMIZE_PLUGIN_HOME=$XDG_CONFIG_HOME/kustomize/plugin
  ```

## **3. Common Plugin Examples**

### **Example 1: Rewriting Config Sections**
A plugin that changes container image versions dynamically.
```sh
jq '.spec.template.spec.containers[0].image = "nginx:latest"'
```

### **Example 2: Hooking into Third-Party APIs**
A plugin that fetches data from an external API and injects it into ConfigMaps.
```sh
curl -s https://api.example.com/config | jq '.data | tojson'
```

## **4. Security and Performance Considerations**
- **Security Risks:** Exec plugins run arbitrary code—ensure they come from trusted sources.
- **Performance:** Go plugins perform better than exec scripts due to native integration.
- **Sandboxing:** Use containerized environments for executing untrusted plugins.

By leveraging Kustomize plugins, teams can extend Kubernetes configurations dynamically while maintaining declarative workflows.

---
