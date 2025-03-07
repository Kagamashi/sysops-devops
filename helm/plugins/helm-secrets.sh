# https://github.com/jkroepke/helm-secrets

# manage encrypted values
helm plugin install https://github.com/zendesk/helm-secrets
helm secrets upgrade my-release ./mychart -f secrets.enc.yaml
