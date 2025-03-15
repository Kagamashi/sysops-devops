
## **Using `TF_LOG` for Debugging Terraform**
Terraform provides the `TF_LOG` environment variable to enable detailed logging for troubleshooting issues.

### **Log Levels**
| Log Level  | Description |
|------------|-------------|
| `TRACE`    | Extremely detailed logs (low-level operations). |
| `DEBUG`    | Detailed internal logs. Useful for debugging Terraform execution. |
| `INFO`     | General operation logs (default). |
| `WARN`     | Warnings about non-critical issues. |
| `ERROR`    | Logs only errors. |

### **How to Enable Debug Logging**
Run Terraform with a specific log level:
```bash
export TF_LOG=DEBUG
terraform apply
```

### **Saving Logs to a File**
Redirect logs to a file for analysis:
```bash
export TF_LOG=TRACE
export TF_LOG_PATH="terraform.log"
terraform apply
```

---
