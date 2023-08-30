#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

echo "Running smoke tests"
APP_URL=$(kubectl get kservice fullstack -o yaml | yq '.status.url' | tr -d '\n' )
if ! node "$SCRIPT_DIR/../frontend/smoke-test.js" "$APP_URL"; then
    echo "Smoke test failed" 1>&2
    exit 1
fi

echo "Smoke tests succeeded"
