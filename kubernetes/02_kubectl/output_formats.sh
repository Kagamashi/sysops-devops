
-o=custom-columns=<spec>	        # Print a table using a comma separated list of custom columns
-o=custom-columns-file=<filename>	# Print a table using the custom columns template in the <filename> file
-o=go-template=<template>	        # Print the fields defined in a golang template
-o=go-template-file=<filename>	  # Print the fields defined by the golang template in the <filename> file
-o=json	                      # Output a JSON formatted API object
-o=jsonpath=<template>	      # Print the fields defined in a jsonpath expression
-o=jsonpath-file=<filename>	  # Print the fields defined by the jsonpath expression in the <filename> file
-o=name	       # Print only the resource name and nothing else
-o=wide	       # Output in the plain-text format with any additional information, and for pods, the node name is included
-o=yaml	       # Output a YAML formatted API object

# All images running in a cluster
kubectl get pods -A -o=custom-columns='DATA:spec.containers[*].image'

# All images running in namespace: default, grouped by Pod
kubectl get pods --namespace default --output=custom-columns="NAME:.metadata.name,IMAGE:.spec.containers[*].image"

# All images excluding "registry.k8s.io/coredns:1.6.2"
kubectl get pods -A -o=custom-columns='DATA:spec.containers[?(@.image!="registry.k8s.io/coredns:1.6.2")].image'

# All fields under metadata regardless of name
kubectl get pods -A -o=custom-columns='DATA:metadata.*'
