
# https://github.com/kedacore/keda/releases

# Apply manifests (here for version 2.9.3)
kubectl apply -f https://github.com/kedacore/keda/releases/download/v2.9.3/keda-2.9.3.yaml

# Alternatively files can be downloaded and deployed from local path:
kubectl apply -f keda-2.9.3.yaml


# alternatively repo with the files can be cloned:
# https://github.com/kedacore/keda/tree/main/config
git clone https://github.com/kedacore/keda && cd keda

VERSION=2.9.3 make deploy
