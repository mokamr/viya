#!/bin/bash

# Exit on any error
set -e

# Check for required namespace parameter
if [ -z "$1" ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

# Assign the first argument as the namespace
NS="$1"

# Copy the input file to the working location
cp sas-bases/examples/security/container-security/configmap-inputs.yaml site-config/security/update-fsgroup-configmap.yaml

# Retrieve the fsGroup value from the namespace annotations
FSGROUP=$(oc get project "$NS" -o jsonpath='{.metadata.annotations.openshift\.io/sa\.scc\.supplemental-groups}' | cut -f1 -d /)

# Confirm value is not empty
if [ -z "$FSGROUP" ]; then
  echo "Error: Could not retrieve fsGroup for namespace '$NS'"
  exit 2
fi

echo "Using FSGROUP: $FSGROUP"

# Substitute placeholder with actual fsGroup
sed -i "s|{{ FSGROUP_VALUE }}|$FSGROUP|" site-config/security/update-fsgroup-configmap.yaml
