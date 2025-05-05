#!/bin/bash

# Function to set file permission only if different
set_permission_if_needed() {
  local file="$1"
  local desired_perm="$2"
  if [ -f "$file" ]; then
    current_perm=$(stat -c "%a" "$file")
    if [[ "$current_perm" != "$desired_perm" ]]; then
      echo "Setting permission $desired_perm on $file"
      chmod "$desired_perm" "$file"
    else
      echo "Permission $desired_perm already set on $file"
    fi
  else
    echo "Warning: $file not found"
  fi
}

# Function to append PDB if not already present
createpdb() {
  local file="../sas-bases/base/components/${component}/resources.yaml"
  if grep -q "kind: PodDisruptionBudget" "$file"; then
    echo "PDB already exists in $file"
    return
  fi

  echo "Appending PDB to $file"
  cat << EOF >> "$file"

---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  annotations:
    sas.com/ha-class: centralized
    sas.com/kustomize-base: base
  name: ${component}
spec:
  minAvailable: 0
  selector:
    matchLabels:
      app.kubernetes.io/name: ${component}
EOF
}

# List of components
components=(
  sas-code-debugger
  sas-studio-app
  sas-import-9
  sas-readiness
  sas-config-reconciler
  sas-redis-operator
  sas-data-server-operator
  sas-opendistro-operator
  sas-cas-operator
  sas-migration-manager
  sas-risk-cirrus-builder
  sas-risk-cirrus-core
  sas-risk-cirrus-rm
  sas-risk-cirrus-rcc
  sas-risk-cirrus-mrm
  sas-prepull
)

# Loop over components
for component in "${components[@]}"; do
  file="../sas-bases/base/components/${component}/resources.yaml"
  set_permission_if_needed "$file" 664
  createpdb
done
