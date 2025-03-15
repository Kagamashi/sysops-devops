# Restart Pods associated with a Deployment, StatefulSet, or DaemonSet. It triggers a rolling restart of the resources.
kubectl rollout [subcommand] [resource-type]/[resource-name]


# Tips:
# - `kubectl restart` is useful when you need to apply changes such as configuration updates, environment variable changes, or to resolve stuck Pods.
# - The restart doesn't change the Pod template spec, but it triggers a rolling update, cycling through each Pod in the resource.
# - Works well with Deployments and StatefulSets but is not supported for individual Pods.

# Useful Subcommands:
# - `status`: Show the status of the rollout (e.g., "in progress", "completed").
# - `pause`: Temporarily pause a rollout.
# - `resume`: Resume a paused rollout.
# - `undo`: Roll back to the previous revision.

kubectl set image deployment/frontend www=image:v2               # Rolling update "www" containers of "frontend" deployment, updating the image
kubectl rollout history deployment/frontend                      # Check the history of deployments including the revision
kubectl rollout undo deployment/frontend                         # Rollback to the previous deployment
kubectl rollout undo deployment/frontend --to-revision=2         # Rollback to a specific revision
kubectl rollout status -w deployment/frontend                    # Watch rolling update status of "frontend" deployment until completion
kubectl rollout restart deployment/frontend                      # Rolling restart of the "frontend" deployment

cat pod.json | kubectl replace -f -                              # Replace a pod based on the JSON passed into stdin

# Force replace, delete and then re-create the resource. Will cause a service outage.
kubectl replace --force -f ./pod.json

# Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000
kubectl expose rc nginx --port=80 --target-port=8000

# Update a single-container pod's image version (tag) to v4
kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -

kubectl label pods my-pod new-label=awesome                      # Add a Label
kubectl label pods my-pod new-label-                             # Remove a label
kubectl label pods my-pod new-label=new-value --overwrite        # Overwrite an existing value
kubectl annotate pods my-pod icon-url=http://goo.gl/XXBTWq       # Add an annotation
kubectl annotate pods my-pod icon-url-                           # Remove annotation
kubectl autoscale deployment foo --min=2 --max=10                # Auto scale a deployment "foo"
