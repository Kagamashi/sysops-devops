'''
kubernetes package allows programmatic interactions with K8s cluster

'pip install kubernetes'
'''

# list pods in a namespace
from kubernetes import client, config

config.load_kube_config()  # Load kubeconfig (for local development)

v1 = client.CoreV1Api()
pods = v1.list_namespaced_pod(namespace="default")

for pod in pods.items:
    print(f"Pod Name: {pod.metadata.name}")


# creating a deployment with python
from kubernetes import client, config

config.load_kube_config()
apps_v1 = client.AppsV1Api()

deployment = client.V1Deployment(
    metadata=client.V1ObjectMeta(name="python-app"),
    spec=client.V1DeploymentSpec(
        replicas=2,
        selector=client.V1LabelSelector(match_labels={"app": "python-app"}),
        template=client.V1PodTemplateSpec(
            metadata=client.V1ObjectMeta(labels={"app": "python-app"}),
            spec=client.V1PodSpec(
                containers=[
                    client.V1Container(
                        name="python-app",
                        image="my-python-app:latest",
                        ports=[client.V1ContainerPort(container_port=5000)],
                    )
                ]
            ),
        ),
    ),
)

apps_v1.create_namespaced_deployment(namespace="default", body=deployment)
