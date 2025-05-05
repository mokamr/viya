#!/usr/bin/env bash

# Usage:
#   ./replace_placeholder.sh SC my-storage-class
#   ./replace_placeholder.sh NS my-namespace
#   ./replace_placeholder.sh RWXSC my-readwrite-many-storage-class

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <SC|NS|RWXSC> <replacement-value>"
  exit 1
fi

PLACEHOLDER="$1"
VALUE="$2"

# Validate allowed placeholders
case "$PLACEHOLDER" in
  SC|NS|RWXSC)
    ;;
  *)
    echo "Error: placeholder must be one of 'SC', 'NS', or 'RWXSC'"
    exit 1
    ;;
esac

# Find and replace in YAML files
find ../site-config/ -type f -name "*.yaml" -print0 | while IFS= read -r -d '' file; do
  sed -i "s/\\\$$PLACEHOLDER/$VALUE/g" "$file"
  echo "Updating $file for \$$PLACEHOLDER"
done

echo "Replacement complete."
