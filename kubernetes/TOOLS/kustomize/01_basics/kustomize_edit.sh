
kustomize edit add
kustomize edit add configmap db-creds --from-literal=passwrd=password1
kustomize edit add secrt my-secret --from-literal=login=user1 --from-literal=password=mypassword
kustomize edit add resource db/db-depl.yaml # Add a resource to the kustomization.yaml file (e.g., adding a service YAML).
kustomize edit add patch patch-file.yaml    # Add a strategic merge patch to the kustomization.yaml file.

# kustomization.yaml
configMapGenerator:
- literals:
  - password=password1
  - username=root
  name: db-creds
secretGenerator:
- literals;
  - login=user1
  - password=mypassword
  name: my-secret
  type: Opaque
resources:
- db/db-depl.yaml

###

kustomize edit set
kustomize edit set image nginx=nginx:1.2.2  # Set or replace an image in the kustomization.yaml file.
kustomize edit set namespace staging
kustomize edit set label org:KodeKloud env:staging
kustomize edit set replicas nginx-deployment=5

# kustomization.yaml
images:
- name: nginx
  newTag: 1.2.2
namespace: staging
commonLabels:
  env: staging
  org: KodeKloud
replicas:
- count: 5
  name: nginx-deployment
