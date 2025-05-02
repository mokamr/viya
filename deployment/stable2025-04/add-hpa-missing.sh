#!/bin/bash

# Function to set file permissions only if needed
set_permission_if_needed() {
  file="$1"
  desired_perm="$2"
  current_perm=$(stat -c "%a" "$file" 2>/dev/null)

  if [[ "$current_perm" != "$desired_perm" ]]; then
    echo "Setting permission $desired_perm on $file"
    chmod "$desired_perm" "$file"
  else
    echo "Permission $desired_perm already set on $file"
  fi
}

# List of components and their desired permissions
declare -A component_perms=(
  ["sas-opendistro-operator"]=644
  ["sas-redis-operator"]=664
  ["sas-data-server-operator"]=664
  ["sas-readiness"]=664
  ["sas-cas-operator"]=664
  ["sas-prepull"]=664
  ["sas-config-reconciler"]=664
)

# Set permissions
for component in "${!component_perms[@]}"; do
  file="sas-bases/base/components/${component}/resources.yaml"
  set_permission_if_needed "$file" "${component_perms[$component]}"
done

# Append HPA only if not already present
createhpa() {
  file="sas-bases/base/components/${component}/resources.yaml"
  if grep -q "kind: HorizontalPodAutoscaler" "$file"; then
    echo "HPA already exists in $file"
    return
  fi

  echo "Appending HPA to $file"
  cat << EOF >> "$file"

---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  annotations:
    sas.com/ha-class: centralized
    sas.com/kustomize-base: golang
  name: ${component}
spec:
  maxReplicas: 1
  metrics:
  - resource:
      name: cpu
      target:
        averageUtilization: 80
        type: Utilization
    type: Resource
  minReplicas: 1
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: ${component}
EOF
}

# Run the HPA appending logic
for component in "${!component_perms[@]}"; do
  createhpa
done
