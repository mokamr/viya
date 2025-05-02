# Getting Started
### Prequisites
- The https://github.com/mokamr/viya cloned on the oc deployment client 
- Ensure a valid 2025.04 Stable sas-bases folder is placed under viya/deployment/stable2025-04/
## Run scripts to add missing HPAs and PDBs in sas-bases
```bash
cd viya/deployment/stable2025.04
./add-hpa-missing.sh
./add-pdb-missing.sh
```
## Running Helper Scripts for Initial Setup

### Update fsGroup ConfigMap

This script updates a Kubernetes ConfigMap YAML file with the appropriate `fsGroup` value derived from an OpenShift project (namespace). It is intended for use with SAS Viya deployments that require setting `fsGroup` in a security configuration.

#### Prerequisites

- Viya namespace already created
- OpenShift CLI (`oc`) installed and configured to access your OpenShift cluster
- You must have read and write access to the project root and `site-config/` directory

#### Usage

```bash
cd viya/deployment/stable2025.04
./update-fsgroup.sh <namespace>
```

### Update SC names and NS from files in site-config
```bash
cd viya/deployment/stable2025.04
./replace_placeholder.sh SC <RWO Storage Class Name>
./replace_placeholder.sh NS <Viya NS>
./replace_placeholder.sh RWXSC <RWX Storage Class Name>
```
### TLS
#### Certificate Distribution to Routes (when cert-utils operator is unavailable)
- Generate Viya 4 ingress certificates and private key then place them under site-config/security/
- Naming convention of the certs and key should be ${viyaurl}.cer.txt and ${viyaurl}.key
- Modify lines 7 and 8 in [site-config/security/sas-custom-ingress-certificate-configmap.yaml](https://github.com/mokamr/viya/blob/main/deployment/stable2025-04/site-config/security/sas-custom-ingress-certificate-configmap.yaml) with the path to the certificate and key files
  ```yaml
  files:
  - tls.crt=site-config/security/${viyaurl}.cer.txt
  - tls.key=site-config/security/${viyaurl}.key

