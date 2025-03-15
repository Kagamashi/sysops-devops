
# Checks the mutual TLS (mTLS) status between two services or pods to identify security issues with service-to-service communication.

istioctl authn tls-check <source-pod> <destination-pod> -n <namespace>
