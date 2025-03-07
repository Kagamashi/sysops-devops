# https://github.com/databus23/helm-diff

# generates a diff between latest deployed version of a release and 'helm upgrade --debug --dry-run'
# can also be used to compare 2 revisions/versions of Helm releases

helm plugin install https://github.com/databus23/helm-diff
helm diff upgrade my-release ./mychart
