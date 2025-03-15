
### Single Sign-On (SSO) in ArgoCD

ArgoCD supports SSO using OAuth2 and OpenID Connect (OIDC).

#### Example: Configuring OIDC in `argocd-cm` ConfigMap
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
data:
  oidc.config: |
    name: Google
    issuer: https://accounts.google.com
    clientID: <CLIENT_ID>
    clientSecret: <CLIENT_SECRET>
    requestedIDTokenClaims:
      email:
        essential: true
    requestedScopes: ["openid", "profile", "email"]
```

---

Enabling OIDC Authentication:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
data:
  url: https://argocd.example.com
  oidc.config: |
    name: MyOIDC
    issuer: https://identity.example.com
    clientID: my-client-id
    clientSecret: $oidc-client-secret
    requestedScopes: ["openid", "profile", "email"]
```

---

Enabling LDAP Authentication:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
data:
  dex.config: |
    connectors:
    - type: ldap
      id: ldap
      name: LDAP
      config:
        host: ldap.example.com:389
        bindDN: "cn=admin,dc=example,dc=com"
        bindPW: $ldap-bind-password
        userSearch:
          baseDN: "dc=example,dc=com"
          filter: "(objectClass=person)"
          username: cn
          idAttr: uid
```

---
