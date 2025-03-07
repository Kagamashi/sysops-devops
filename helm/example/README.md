# Advanced Helm Chart

This Helm chart deploys an advanced web application with:
- Configurable replicas, ingress, and resource limits
- Environment-specific values (`values-dev.yaml`, `values-prod.yaml`)
- Dependencies (Redis, PostgreSQL)
- Autoscaling (HPA)

## Installation

```sh
helm install my-release ./example \
  -f values-prod.yaml \
  --set redis.enabled=false \
  --set postgresql.enabled=true \
  --set postgresql.auth.password=MySecureP@ssw0rd
```
