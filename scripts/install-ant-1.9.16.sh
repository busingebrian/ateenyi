#!/usr/bin/env bash
set -euo pipefail

ANT_VERSION="1.9.16"
ANT_TARBALL="apache-ant-${ANT_VERSION}-bin.tar.gz"
ANT_URL="https://archive.apache.org/dist/ant/binaries/${ANT_TARBALL}"

# Published at: https://archive.apache.org/dist/ant/binaries/apache-ant-1.9.16-bin.tar.gz.sha512
EXPECTED_SHA512="8d542a7a636a491e76170148881b6f413f4564aad1ab034f426bd946be93382001862bd6c60865aa2b57b39b9633e0181fe8997dd6323123aaf76b410ec4a366"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

TOOLS_DIR="${ROOT_DIR}/.tools"
DIST_DIR="${TOOLS_DIR}/dist"
TARBALL_PATH="${DIST_DIR}/${ANT_TARBALL}"
ANT_DIR="${TOOLS_DIR}/apache-ant-${ANT_VERSION}"
ANT_SYMLINK="${TOOLS_DIR}/ant"

if [[ -x "${ANT_DIR}/bin/ant" ]]; then
  echo "Ant ${ANT_VERSION} already installed at: ${ANT_DIR}"
  echo "ANT_HOME=${ANT_DIR}"
  exit 0
fi

mkdir -p "${DIST_DIR}"

download() {
  local url="$1"
  local out="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fL --retry 3 --retry-delay 1 -o "${out}" "${url}"
    return 0
  fi

  if command -v wget >/dev/null 2>&1; then
    wget -O "${out}" "${url}"
    return 0
  fi

  echo "ERROR: neither 'curl' nor 'wget' is available to download ${url}" >&2
  return 1
}

if [[ ! -f "${TARBALL_PATH}" ]]; then
  echo "Downloading ${ANT_URL}"
  download "${ANT_URL}" "${TARBALL_PATH}"
else
  echo "Using cached tarball: ${TARBALL_PATH}"
fi

if ! command -v sha512sum >/dev/null 2>&1; then
  echo "ERROR: 'sha512sum' is required to verify the Ant tarball." >&2
  exit 1
fi

ACTUAL_SHA512="$(sha512sum "${TARBALL_PATH}" | cut -d ' ' -f1)"
if [[ "${ACTUAL_SHA512}" != "${EXPECTED_SHA512}" ]]; then
  echo "ERROR: SHA-512 mismatch for ${TARBALL_PATH}" >&2
  echo "Expected: ${EXPECTED_SHA512}" >&2
  echo "Actual:   ${ACTUAL_SHA512}" >&2
  echo "Delete the tarball and retry:" >&2
  echo "  rm -f \"${TARBALL_PATH}\"" >&2
  exit 1
fi

echo "Checksum OK. Extracting to ${TOOLS_DIR}"
tar -xzf "${TARBALL_PATH}" -C "${TOOLS_DIR}"
ln -sfn "${ANT_DIR}" "${ANT_SYMLINK}"

echo "Installed Ant ${ANT_VERSION} at: ${ANT_DIR}"
echo
echo "To use it in your current shell:"
echo "  export ANT_HOME=\"${ANT_DIR}\""
echo "  export PATH=\"${ANT_DIR}/bin:\$PATH\""
echo
echo "Or use the stable symlink:"
echo "  export ANT_HOME=\"${ANT_SYMLINK}\""
echo "  export PATH=\"${ANT_SYMLINK}/bin:\$PATH\""
