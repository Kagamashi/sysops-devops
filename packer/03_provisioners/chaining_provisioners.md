# Packer Chaining Provisioners: Best Practices and Execution Order

## **1. Introduction to Chaining Provisioners in Packer**
Provisioners in Packer **execute scripts, copy files, or run configuration management tools** during the image build process. **Chaining multiple provisioners** allows for a structured and sequential setup of an image.

### **Key Benefits of Chaining Provisioners:**
- Enables **complex provisioning workflows**.
- Ensures **step-by-step configuration and error handling**.
- Allows the use of **both local and remote scripts**.

---

## **2. Defining the Sequence of Multiple Provisioners**
Packer executes **provisioners in the order they are declared** within a `build` block. Below is an example of a **properly chained provisioning setup**:

### **Example: Chaining Provisioners in Packer**
```hcl
build {
  sources = ["source.azure-arm.example"]

  provisioner "file" {
    source      = "./config/setup.sh"
    destination = "/tmp/setup.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "sudo /tmp/setup.sh"
    ]
  }

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }
}
```

### **Execution Order in the Example Above:**
1. **File Provisioner**: Uploads `setup.sh` to the target instance.
2. **Shell Provisioner**: Grants execute permissions and runs `setup.sh`.
3. **Ansible Provisioner**: Executes an **Ansible playbook** for additional configuration.

---

## **3. Best Practices for Readability and Maintainability**

### **Use Named Variables for Readability**
Define commonly used paths and values in a `variables.pkr.hcl` file:
```hcl
variable "script_path" {
  default = "./config/setup.sh"
}
```
Reference them in the provisioners:
```hcl
provisioner "file" {
  source      = var.script_path
  destination = "/tmp/setup.sh"
}
```

### **Modularize Scripts Instead of Large Inline Commands**
Instead of using large `inline` commands:
```hcl
provisioner "shell" {
  inline = [
    "apt-get update",
    "apt-get install -y nginx",
    "systemctl enable nginx"
  ]
}
```
Use an external script:
```hcl
provisioner "shell" {
  script = "./scripts/install_nginx.sh"
}
```

---

## **4. Handling Errors and Ensuring Provisioner Reliability**
Packer **stops execution on the first failing provisioner** by default. To prevent a build from failing due to minor issues:

### **Use `expect_disconnect` for Long-Running Commands**
```hcl
provisioner "shell" {
  inline = [
    "sleep 30 && reboot"
  ]
  expect_disconnect = true
}
```
This prevents Packer from **failing prematurely** if the instance disconnects.

### **Continue on Failure for Non-Critical Steps**
```hcl
provisioner "shell" {
  inline = [
    "sudo apt-get install -y monitoring-agent || echo 'Failed to install monitoring agent'"
  ]
}
```
This **logs failures but does not interrupt the build**.

---

## **5. Running Local vs Remote Scripts**
### **Local Script Execution**
For local scripts that **configure the instance remotely**, use `local-exec`:
```hcl
provisioner "local-exec" {
  command = "echo 'Packer build completed' > build.log"
}
```
### **Remote Script Execution**
For scripts **running inside the instance**, use `remote-exec`:
```hcl
provisioner "remote-exec" {
  inline = [
    "echo 'Running remote configuration'",
    "sudo systemctl restart nginx"
  ]
}
```

---

## **6. Best Practices Summary**
| Best Practice | Benefit |
|--------------|---------|
| **Use multiple provisioners** | Ensures a structured approach to image provisioning. |
| **Leverage file provisioners** | Uploads required files before execution. |
| **Modularize scripts** | Keeps Packer templates clean and readable. |
| **Handle errors properly** | Prevents unnecessary build failures. |
| **Use environment variables** | Avoids hardcoded values in scripts. |

For more details, visit **[Packer Provisioner Documentation](https://developer.hashicorp.com/packer/docs/provisioners)**.
