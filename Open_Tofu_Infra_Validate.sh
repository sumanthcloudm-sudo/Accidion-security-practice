#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
INFRA_DIR="${ROOT_DIR}/infra"

# Candidate baseline: verify before adopting.
EXPECTED_TOFU_VERSION="1.13.2"

if ! command -v tofu >/dev/null 2>&1; then
  echo "ERROR: OpenTofu is not installed." >&2
  exit 1
fi

ACTUAL_TOFU_VERSION="$(
  tofu version -json |
    sed -n 's/.*"terraform_version":"\([^"]*\)".*/\1/p'
)"

if [[ "${ACTUAL_TOFU_VERSION}" != "${EXPECTED_TOFU_VERSION}" ]]; then
  echo "ERROR: Expected OpenTofu ${EXPECTED_TOFU_VERSION}; found ${ACTUAL_TOFU_VERSION:-unknown}." >&2
  exit 1
fi

cd "${INFRA_DIR}"

echo "Checking OpenTofu formatting..."
tofu fmt -check -recursive

echo "Initializing without a remote backend..."
tofu init -backend=false -input=false

echo "Validating configuration..."
tofu validate -no-color

echo "SUCCESS: Validation passed. No infrastructure was deployed."


How to run it:
chmod +x Open_Tofu_Infra_validate.sh
.Open_Tofu_Infra_validate.sh
