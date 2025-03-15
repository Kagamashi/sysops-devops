
# To disable the Ingress Gateway:
istioctl install --set components.ingressGateways.enabled=false

# To enable the Egress Gateway:
istioctl install --set components.egressGateways.enabled=true

# To install Istio with a minimal profile:
istioctl install --set profile=minimal # || demo || default

# run to ensure that Istio was installed correctly
istioctl verify-install
