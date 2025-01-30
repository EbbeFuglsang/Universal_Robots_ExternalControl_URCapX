#!/bin/bash

# Ensure a file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file.urcapx>"
    exit 1
fi

URCAPX_FILE="$1"
TEMP_DIR=$(mktemp -d)

# Ensure the provided file exists
if [ ! -f "$URCAPX_FILE" ]; then
    echo "Error: File '$URCAPX_FILE' not found."
    exit 1
fi

# Extract the .urcapx tar file
tar -xf "$URCAPX_FILE" -C "$TEMP_DIR"

# Locate manifest.yaml
MANIFEST_FILE="$TEMP_DIR/manifest.yaml"
if [ ! -f "$MANIFEST_FILE" ]; then
    echo "Error: manifest.yaml not found in the package."
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Extract the urcapID field from YAML
URCAP_ID=$(awk -F': ' '/urcapID:/ {gsub(/ /, "", $2); print $2}' "$MANIFEST_FILE")

# Cleanup
rm -rf "$TEMP_DIR"

# Print the result
if [ -n "$URCAP_ID" ]; then
    echo "$URCAP_ID"
else
    echo "Error: urcapID not found in manifest.yaml."
    exit 1
fi
