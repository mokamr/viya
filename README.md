# Pre-Reqs

## SAS Viya SCC GitOps Setup

This repository is used to manage SAS Viya Security Context Constraints (SCCs), related Kubernetes RBAC resources, and CRDs with GitOps. It supports adding custom cluster roles, SCC bindings, and CRDs required for a compliant Viya deployment.

---

## 📁 Directory Structure

Run the following to set up the required directory structure:

```bash
mkdir -p platform-gitops/sas-viya-scc/overlays/pp1190
mkdir -p platform-gitops/sas-viya-scc/components/pp1190
mkdir -p platform-gitops/sas-viya-scc/base
```

---

## 🔐 Create Aggregated Cluster Role

Create a file `sas-admin-extended-rbac.yaml` under `platform-gitops/sas-viya-scc/base/`:

```bash
cat << EOF > platform-gitops/sas-viya-scc/base/sas-admin-extended-rbac.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: sas-extended-admin-rbac
  namespace: sasviyadev
  labels:
    rbac.authorization.k8s.io/aggregate-to-admin: "true"
    rbac.authorization.k8s.io/aggregate-to-nsadmin: "true"
rules:
# postgres-operator
- apiGroups: ["postgres-operator.crunchydata.com"]
  resources: ["crunchybridgeclusters", "crunchybridgeclusters/finalizers","crunchybridgeclusters/status",
              "pgupgrades", "pgupgrades/finalizers", "pgupgrades/status",
              "pgadmins", "pgadmins/finalizers", "pgadmins/status",
              "postgresclusters", "postgresclusters/finalizers", "postgresclusters/status"]
  verbs: ["create", "get", "list", "patch", "update", "delete", "watch"]
- apiGroups: [""]
  resources: ["endpoints", "endpoints/restricted"]
  verbs: ["create", "delete", "deletecollection", "patch"]
# sas-cas-control, sas-viya-backuprunner
- apiGroups: ["viya.sas.com"]
  resources: ["casdeployments", "casdeployments/finalizers", "casdeployments/status"]
  verbs: ["create", "get", "list", "update", "patch", "watch", "delete", "deletecollection"]
# sas-cas-operator
- apiGroups: ["route.openshift.io"]
  resources: ["routes", "routes/custom-host"]
  verbs: ["get", "list", "create", "update", "patch", "delete", "watch"]
- apiGroups: ["projectcontour.io"]
  resources: ["httpproxies"]
  verbs: ["get", "list", "create", "update", "patch", "delete", "watch"]
# sas-commonfiles, sas-decisions-runtime-builder, sas-launcher, sas-risk-cirrus-core, sas-workload-orchestrator
- apiGroups: [""]
  resources: ["pod", "pods/log", "pods/finalizers", "podtemplates"]
  verbs: ["get", "create", "update", "delete", "list", "patch", "watch"]
- apiGroups: ["extensions"]
  resources: ["jobs", "jobs/finalizers"]
  verbs: ["get", "delete", "list", "create", "update", "watch"]
# sas-data-server-operator
- apiGroups: ["webinfdsvr.sas.com"]
  resources: ["dataservers", "dataservers/finalizers", "dataservers/status"]
  verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
# sas-opendistro-operator
- apiGroups: ["opendistro.sas.com"]
  resources: ["opendistroclusters", "opendistroclusters/finalizers", "opendistroclusters/status"]
  verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
# sas-data-server-operator-leader-election-role
- apiGroups: [""]
  resources: ["configmaps/status"]
  verbs: ["get", "update", "patch"]
# sas-launcher
- apiGroups: ["batch"]
  resources: ["jobs/finalizers"]
  verbs: ["get", "delete", "list", "create", "update", "watch"]
# sas-redis-operator
- apiGroups: ["apps"]
  resources: ["deployments/finalizers"]
  verbs: ["update"]
- apiGroups: ["redis.kun"]
  resources: ["*"]
  verbs: ["delete", "create", "deletecollection", "get", "list", "patch", "update", "watch"]
# sas-start-all-opensearch
- apiGroups: ["opendistro.sas.com"]
  resources: ["opendistroclusters"]
  verbs: ["get", "list", "patch", "watch"]
# sas-viya-backuprunner
- apiGroups: ["iot.sas.com"]
  resources: ["espservers"]
  verbs: ["get", "delete", "list", "deletecollection"]
# sas-certframe-role
- apiGroups: ["cert-manager.io"]
  resources: ["certificaterequests", "certificates"]
  verbs: ["create", "get", "list", "update", "delete"]
# sas-data-server-operator, sas-launcher, sas-opendistro-operator-leader-election, sas-start-all, sas-stop-all, sas-workload-orchestrator
- apiGroups: ["coordination.k8s.io"]
  resources: ["leases"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
EOF
```

This cluster role grants extended permissions required for SAS Viya workloads and aggregates to `admin` and `nsadmin`.

---

## 📅 Copy Required CRDs

Download the following CRDs from:

📁 GitHub Repo: [mokamr/viya — crds/stable-2025-04](https://github.com/mokamr/viya/tree/main/crds/stable-2025-04)

Place them in:

```bash
platform-gitops/sas-viya-scc/base/
```

---

## 🔀 Add SCCs and RoleBindings

Download the following SCC and role binding manifests from:

📁 GitHub Repo: [mokamr/viya — sccs-accounts](https://github.com/mokamr/viya/tree/main/sccs-accounts)

Place them in:

```bash
platform-gitops/sas-viya-scc/base/
```

---

## ✏️ Update Namespace

Edit the following files:

- `cas-scc-rolebinding.yaml`
- `sas-scc-rolebinding.yaml`

Update:
- Line 7 (`metadata.namespace`)
- Line 11 (`subjects.namespace`)

Replace with your target namespace.

---

## ⚙️ Define Kustomization Manifests

### Component Kustomization

Create `kustomization.yaml` under `components/pp1190`:

```bash
cat << EOF > platform-gitops/sas-viya-scc/components/pp1190/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../../base
EOF
```

### Overlay Kustomization

Create `kustomization.yaml` under `overlays/pp1190`:

```bash
cat << EOF > platform-gitops/sas-viya-scc/overlays/pp1190/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ../../components/pp1190
EOF
```

### Base Kustomization

Create `kustomization.yaml` under `base`:

```bash
cat << EOF > platform-gitops/sas-viya-scc/base/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - ./cas-scc-rolebinding.yaml
  - ./sas-scc-rolebinding.yaml
  - ./cas-server-scc.yaml
  - ./cr-sas-cas-server.yaml
  - ./sas-extended-admin-rbac.yaml
  - ./CustomResourceDefinition-casdeployments.viya.sas.com
  - ./CustomResourceDefinition-dataservers.webinfdsvr.sas.com
  - ./CustomResourceDefinition-distributedredisclusters.redis.kun
  - ./CustomResourceDefinition-opendistroclusters.opendistro.sas.com
EOF
```



