
## **Enabling Single Sign-On (SSO) via SAML**
SSO enables users to authenticate with external identity providers like **Okta, Azure AD, and Keycloak**.

### **Configuring SAML Authentication**
1. **Enable SAML in `elasticsearch.yml`**:
   ```yaml
   xpack.security.authc.realms.saml.saml1:
     order: 2
     idp.metadata.path: "/etc/elasticsearch/idp-metadata.xml"
     idp.entity_id: "https://idp.example.com/"
     sp.entity_id: "https://elasticsearch.example.com/"
     sp.acs: "https://elasticsearch.example.com/_security/saml/acs"
     sp.logout: "https://elasticsearch.example.com/_security/saml/logout"
     attributes.principal: "nameid:persistent"
   ```
2. **Restart Elasticsearch** to apply changes.
3. **Configure Kibana to Use SAML**:
   ```yaml
   xpack.security.authc.providers:
     saml.saml1:
       order: 0
       realm: "saml1"
       description: "Login with SAML"
   ```

### **Testing SAML Login**
- Navigate to `https://kibana.example.com/login`.
- Click **Login with SAML**.
- Authenticate with the configured **Identity Provider (IdP)**.

---
