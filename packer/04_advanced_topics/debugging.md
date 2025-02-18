
## **Debugging and Logging in Packer**
### **Enabling Debug Logs**
Set the `PACKER_LOG` environment variable to enable detailed logs:
```sh
export PACKER_LOG=1
export PACKER_LOG_PATH="packer.log"
packer build template.pkr.hcl
```
This generates detailed logs in `packer.log`.

### **Interactive Debugging Mode**
Use the `-debug` flag to **pause execution at each step**, allowing manual intervention:
```sh
packer build -debug template.pkr.hcl
```
- Prompts for user input before executing each provisioner.
- Useful for **troubleshooting failing steps**.

### **Checking Instance Logs for Errors**
For cloud builds (AWS, Azure, GCP), check logs **inside the instance**:
```sh
tail -f /var/log/cloud-init-output.log
```

---
