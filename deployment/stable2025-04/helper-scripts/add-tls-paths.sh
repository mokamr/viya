#!/bin/bash

# Exit on any error
set -e

# Validate input
if [ -z "$1" ]; then
  echo "Usage: $0 <viyaurl>"
  exit 1
fi

VIYAURL="$1"
CONFIG_FILE="../site-config/security/sas-custom-ingress-certificate-configmap.yaml"
CERT_FILE="../site-config/security/${VIYAURL}.cer.txt"
KEY_FILE="../site-config/security/${VIYAURL}.key"

# Ensure the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: $CONFIG_FILE does not exist."
  exit 2
fi

# Ensure the certificate and key files exist
if [ ! -f "$CERT_FILE" ]; then
  echo "Error: Certificate file $CERT_FILE does not exist."
  exit 3
fi

if [ ! -f "$KEY_FILE" ]; then
  echo "Error: Key file $KEY_FILE does not exist."
  exit 4
fi

# Perform substitution
sed -i "s|\${viyaurl}|$VIYAURL|g" "$CONFIG_FILE"

echo "Successfully updated $CONFIG_FILE with viyaurl=$VIYAURL"

