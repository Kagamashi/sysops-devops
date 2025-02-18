
## **Wildcard DNS Records**
- Wildcard records (`*`) catch all subdomains that do not have explicit DNS entries.
- Used for flexible domain management without pre-defining subdomains.
- Example:
  ```yaml
  - Type: A
    Name: *.example.com
    Value: 192.168.1.1
  ```
- **Best Practice:** Avoid proxying wildcard records unless necessary, as it may lead to unpredictable caching behavior.

---
