#!/usr/bin/env bash
set -euo pipefail

GROUP_ID="ug.go.ura.domain.utility"
VERSION="1.0-SNAPSHOT"

usage() {
  cat <<'EOF'
Installs internal URA domain utility JARs into your local Maven repo (~/.m2).

Usage:
  ./scripts/maven/install-ura-domain-utility.sh /path/to/jars

Expected filenames in the provided directory:
  ura-domain-service-1.0-SNAPSHOT.jar
  ura-application-service-1.0-SNAPSHOT.jar

Notes:
  - This is a stopgap when you don't have a Maven repository (Nexus/Artifactory).
  - Prefer using an internal Maven repo or building these artifacts from source.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

JAR_DIR="${1:-}"
if [[ -z "${JAR_DIR}" ]]; then
  echo "ERROR: missing JAR directory argument."
  echo
  usage
  exit 2
fi

if [[ ! -d "${JAR_DIR}" ]]; then
  echo "ERROR: not a directory: ${JAR_DIR}"
  exit 2
fi

if ! command -v mvn >/dev/null 2>&1; then
  echo "ERROR: mvn not found. Install Maven and retry."
  exit 127
fi

install_jar() {
  local artifact_id="$1"
  local jar_path="$2"

  if [[ ! -f "${jar_path}" ]]; then
    echo "ERROR: missing file: ${jar_path}"
    exit 2
  fi

  mvn -q \
    org.apache.maven.plugins:maven-install-plugin:3.1.1:install-file \
    -Dfile="${jar_path}" \
    -DgroupId="${GROUP_ID}" \
    -DartifactId="${artifact_id}" \
    -Dversion="${VERSION}" \
    -Dpackaging=jar \
    -DgeneratePom=true
}

install_jar "ura-domain-service" "${JAR_DIR}/ura-domain-service-${VERSION}.jar"
install_jar "ura-application-service" "${JAR_DIR}/ura-application-service-${VERSION}.jar"

echo "Installed:"
echo "  ${GROUP_ID}:ura-domain-service:${VERSION}"
echo "  ${GROUP_ID}:ura-application-service:${VERSION}"
