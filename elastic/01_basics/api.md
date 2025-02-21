
https://www.elastic.co/guide/en/elasticsearch/reference/current/indices.html

---

## **Authentication for Elastic Cloud API Usage**
Elastic Cloud provides a **REST API** for managing resources programmatically. Authentication is required to interact with the API securely.

### **Authentication Methods**
| Method | Description |
|--------|-------------|
| **API Keys** | Secure, revocable authentication tokens for automated access. |
| **Personal Tokens** | User-based tokens for API authentication. |
| **OAuth 2.0** | Authentication via identity providers like Okta, Azure AD. |

### **Generating an API Key**
1. Go to **Elastic Cloud Console** → **Security** → **API Keys**.
2. Click **Create API Key**.
3. Set **permissions and expiration** (optional).
4. Copy and store the API key securely.

#### **Using an API Key for Authentication**
```sh
curl -H "Authorization: ApiKey YOUR_API_KEY" \
     -X GET "https://api.elastic-cloud.com/v1/deployments"
```

### **Generating a Personal Token**
1. Navigate to **Account Settings** in the Elastic Cloud Console.
2. Under **API Access**, click **Generate Token**.
3. Use the token to authenticate API requests.

#### **Using a Personal Token for Authentication**
```sh
curl -H "Authorization: Bearer YOUR_PERSONAL_TOKEN" \
     -X GET "https://api.elastic-cloud.com/v1/users/me"
```

---
