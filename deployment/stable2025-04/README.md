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
- The namespace must exist in the cluster and include the `openshift.io/sa.scc.supplemental-groups` annotation
- You must have read and write access to the project root and `site-config/` directory

#### Usage

```bash
./update-fsgroup.sh <namespace>
