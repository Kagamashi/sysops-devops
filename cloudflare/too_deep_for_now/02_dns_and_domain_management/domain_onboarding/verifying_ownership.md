
## **Verifying Domain Ownership in Azure**
If you are using Azure DNS or need to verify domain ownership, follow these steps:

### **Methods to Verify Domain Ownership**
1. **TXT Record Verification** (Preferred for Azure):
   - Go to **Azure Portal → DNS Zones → Your Domain**.
   - Add a TXT record with Cloudflare-provided verification details.
   - Example:
     ```
     Name: @
     Type: TXT
     Value: cloudflare-verification=123456789
     ```
   - Save the record and allow propagation (can take a few minutes to an hour).

2. **File Upload Method** (For Web-Based Verification):
   - Upload a verification file provided by Cloudflare to the root directory of your website.
   - Example file: `https://example.com/.well-known/cloudflare-verification.html`.

---
