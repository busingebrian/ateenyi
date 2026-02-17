#!/usr/bin/env bash
set -euo pipefail

if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
  echo "Do not run this script as root. Run it as your normal user." >&2
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed or not on PATH." >&2
  echo "Install Docker Engine first, then re-run this script." >&2
  exit 1
fi

echo "Configuring Docker to run without sudo (docker group method)."
echo

if getent group docker >/dev/null 2>&1; then
  echo "- docker group already exists"
else
  echo "- creating docker group (requires sudo)"
  sudo groupadd docker
fi

echo "- adding user '$USER' to docker group (requires sudo)"
sudo usermod -aG docker "$USER"

echo
echo "Done. Group membership changes require a NEW login session."
echo
echo "Next step (choose one):"
echo "  - Log out and log back in"
echo "  - Or run: newgrp docker"
echo
echo "Then verify with:"
echo "  docker run --rm hello-world"

