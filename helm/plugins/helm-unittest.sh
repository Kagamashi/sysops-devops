# https://github.com/helm-unittest/helm-unittest

# validates Helm templates before applying them to the cluster
helm plugin install https://github.com/quintush/helm-unittest
helm unittest ./mychart
