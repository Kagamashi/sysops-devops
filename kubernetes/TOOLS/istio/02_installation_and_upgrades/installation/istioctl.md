# Installing Istio with Manifests

This guide outlines how to install Istio using manifests and `istioctl`.

---

## Step 1: Download the Istio Release
- Download the Istio release that matches your platform and version requirements:
  ```bash
  curl -L https://istio.io/downloadIstio | sh -
  cd istio-<version>
  export PATH=$PWD/bin:$PATH
  ```

---

## Install Istio Using the Default Profile
Profiles descriptions:
  - default: Balanced configuration with essential features enabled.
  - minimal: Installs only the core control plane components.
  - demo: Includes additional features for testing and exploration.

- Install Istio with the default profile:
  ```bash
  istioctl install --set profile=default # || demo || minimal
  ```
- Optionally, enable access logs:
  ```bash
  istioctl install --set meshConfig.accessLogFile=/dev/stdout
  ```

---

## Customize the Installation
- Create a custom configuration file for Istio:
  ```yaml
  cat <<EOF > ./my-config.yaml
  apiVersion: install.istio.io/v1alpha1
  kind: IstioOperator
  spec:
    meshConfig:
      accessLogFile: /dev/stdout
  EOF
  ```
- Apply the custom configuration:
  ```bash
  istioctl install -f my-config.yaml
  ```

---

## Check Installed Components
- Verify the installed components and configuration:
  ```bash
  kubectl -n istio-system get IstioOperator installed-state -o yaml > install-state.yaml
  ```

---

## Generate and Verify a Manifest
generated manifest can be used to inspect what exactly is installed as well as to track changes to the manifest over time

- Generate a manifest before installation to capture potential changes:
  ```bash
  istioctl manifest generate > $HOME/generated-manifest.yaml
  ```
- Compare manifests for differences:
  ```bash
  istioctl manifest diff 1.yaml 2.yaml
  ```
- Verify the generated manifest:
  ```bash
  istioctl verify-install -f $HOME/generated-manifest.yaml
  ```

---

## Uninstall Istio
- Uninstall Istio and remove all related resources:
  ```bash
  istioctl uninstall --purge
  ```
