03-values-and-configuration
Focuses on customizing Helm charts with values:

values-file-basics/

Structuring values.yaml, passing overrides with -f or --set
Hierarchical data, dealing with booleans, strings, arrays
multiple-environment-overlays/

dev/staging/prod value files, best practices for environment-specific overrides
Handling secrets or sensitive data
best-practices-for-parameterization/

Minimizing duplication, default vs optional values
Strategies for complex variable structures
04-lifecycle-and-release-management
Installing, upgrading, rolling back, and deleting Helm releases:

helm-install-and-upgrade/

helm install, helm upgrade, setting version constraints, --atomic, etc.
Handling version increments (chart.yaml version vs appVersion)
rollback-and-history/

Viewing release history (helm history), rolling back (helm rollback)
Handling partial failures, stuck deployments
managing-repositories/

Adding/removing Helm repos (helm repo add, helm repo update), searching for charts
Private repositories, chartmuseum usage
05-security-and-signing
Securing Helm, verifying chart integrity, and dealing with sensitive data:

chart-signing-and-verification/

Creating chart provenance files (helm package --sign), verifying signatures (helm verify)
Basic GPG usage, recommended key management
helm-secrets-and-encryption/

Using external plugins like helm-secrets to manage encrypted values (SOPS, GPG)
Best practices for storing secrets in Git
rbac-and-permissions/

Ensuring cluster roles and permissions are in place for Helm installs/upgrades
Minimizing privileges for CI/CD usage
06-advanced-topics
For deeper Helm usage and specialized features:

library-charts-and-reusability/

Creating library charts, reusing chart components
DRY patterns across multiple microservices
helmfile-and-other-automation-tools/

Overview of Helmfile, plus other higher-level tools integrating with Helm
Managing multiple releases and environment configs at once
plugins-and-community-extensions/

Popular Helm plugins (like helm-diff, helm-secrets)
Installing, removing, and best use cases
