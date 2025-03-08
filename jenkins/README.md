## Jenkins

**Jenkins** is an open-source **automation server** for **CI/CD (Continuous Integration/Continuous Deployment)**. It automates building, testing, and deploying applications.

- **Official Docs**: [https://www.jenkins.io/doc/](https://www.jenkins.io/doc/)
- **GitHub Repository**: [https://github.com/jenkinsci/jenkins](https://github.com/jenkinsci/jenkins)
- **Plugin Index**: [https://plugins.jenkins.io/](https://plugins.jenkins.io/)
- **Pipeline Syntax Guide**: [https://www.jenkins.io/doc/book/pipeline/syntax/](https://www.jenkins.io/doc/book/pipeline/syntax/)
- **Jenkins CLI Reference**: [https://www.jenkins.io/doc/book/managing/cli/](https://www.jenkins.io/doc/book/managing/cli/)

---

### Dictionary (Key Jenkins Terms)

- **Job**: A unit of work defining what to build/test/deploy.
- **Pipeline**: A series of steps for automation (defined in a `Jenkinsfile`).
- **Node**: A machine (agent) where Jenkins runs jobs.
- **Agent**: A machine or container executing pipeline steps.
- **Executor**: A slot in an agent that runs a build.
- **Workspace**: A directory where Jenkins builds code.
- **Plugin**: An extension to Jenkins functionality.
- **Blue Ocean**: A modern UI for Jenkins pipelines.
- **Webhook**: A trigger for automation (e.g., GitHub webhooks for CI/CD).
- **Credential Store**: A secure vault for storing secrets.

---

### CRDs (Custom Resource Definitions)

Jenkins itself **does not introduce Kubernetes CRDs**.  
However, **Jenkins Operator for Kubernetes** provides the following CRDs:

1. **Jenkins** – Defines a Jenkins instance in Kubernetes.
2. **JenkinsPipelineRun** – Manages pipeline execution in a Kubernetes-native way.
3. **JenkinsAgent** – Configures Jenkins agent nodes inside Kubernetes.

To install the **Jenkins Operator**:
```sh
kubectl apply -f https://github.com/jenkinsci/kubernetes-operator/releases/latest/download/operator.yaml
