
## Trigger Authentication
Some triggers require authentication, such as cloud services (AWS, Azure, Google Cloud) or databases.

### **Using TriggerAuthentication CRD**
To securely store credentials for triggers, use `TriggerAuthentication`.

#### **Example YAML (Using Kubernetes Secret)**
```yaml
apiVersion: keda.sh/v1alpha1
kind: TriggerAuthentication
metadata:
  name: rabbitmq-auth
spec:
  secretTargetRef:
    - parameter: host
      name: rabbitmq-secret
      key: host
```

#### **Example Secret Definition**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: rabbitmq-secret
  namespace: default
stringData:
  host: "amqp://user:password@rabbitmq.default.svc.cluster.local:5672/"
```


### **Using Environment Variables**
For simpler configurations, you can refer to environment variables in the `ScaledObject` or `ScaledJob`:
```yaml
triggers:
  - type: azure-servicebus
    metadata:
      queueName: my-queue
      connectionFromEnv: SERVICEBUS_CONNECTION_STRING
```

Using `TriggerAuthentication`, KEDA ensures secrets and sensitive credentials remain secure while enabling dynamic autoscaling.


### **Azure Key Vault secrets**
You can pull secrets from Azure Key Vault into the trigger by using the azureKeyVault key.

Pod identity providers or azure-workloads cna be used to authenticate to the key vault by specifying TriggerAuthentication / ClusterTriggerAuthentication definition.
(pod identity binding needs to be applied in keda namespace)

Other option is to register an application with AAD and specify credentials: clientId and tenantId.

```yaml
azureKeyVault:                                          # Optional.
  vaultUri: {key-vault-address}                         # Required.
  credentials:                                          # Optional. Required when not using pod identity.
    clientId: {azure-ad-client-id}                      # Required.
    clientSecret:                                       # Required.
      valueFrom:                                        # Required.
        secretKeyRef:                                   # Required.
          name: {k8s-secret-with-azure-ad-secret}       # Required.
          key: {key-within-the-secret}                  # Required.
    tenantId: {azure-ad-tenant-id}                      # Required.
  cloud:                                                # Optional.
    type: AzurePublicCloud | AzureUSGovernmentCloud | AzureChinaCloud | AzureGermanCloud | Private # Required.
    keyVaultResourceURL: {key-vault-resource-url-for-cloud}           # Required when type = Private.
    activeDirectoryEndpoint: {active-directory-endpoint-for-cloud}    # Required when type = Private.
  secrets:                                              # Required.
  - parameter: {param-name-used-for-auth}               # Required.
    name: {key-vault-secret-name}                       # Required.
    version: {key-vault-secret-version}                 # Optional.
```

---
