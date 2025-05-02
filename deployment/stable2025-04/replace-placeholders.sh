#!/usr/bin/env bash

# Usage: ./replace_placeholder.sh SC my-namespace
#        ./replace_placeholder.sh NS dev-namespace

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <SC|NS> <replacement-value>"
  exit 1
fi

PLACEHOLDER="$1"
VALUE="$2"

if [ "$PLACEHOLDER" != "SC" ] && [ "$PLACEHOLDER" != "NS" ]; then
  echo "Error: placeholder must be either 'SC' or 'NS'"
  exit 1
fi

find site-config/ -type f -name "*.yaml" -print0 | while IFS= read -r -d '' file; do
  echo "Updating $file for \$$PLACEHOLDER"
  sed -i "s/\\\$$PLACEHOLDER/$VALUE/g" "$file"
done

echo "Replacement complete."

