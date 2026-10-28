#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
INFRA_DIR="${REPO_ROOT}/infra"

cd "${INFRA_DIR}"

echo "Checking Terraform formatting..."
tofu fmt -check -recursive

echo "Initializing Terraform without backend..."
tofu init -backend=false -input=false

echo "Validating Terraform configuration..."
tofu validate -no-color
