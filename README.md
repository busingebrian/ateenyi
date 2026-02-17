# busingebrian.io

## Docker without `sudo` (Linux)

If you currently have to run `sudo docker ...`, you can enable running Docker as your normal user.

### Option A: Add your user to the `docker` group (most common)

Run:

```bash
sudo groupadd docker 2>/dev/null || true
sudo usermod -aG docker "$USER"

# Apply new group membership (choose ONE):
newgrp docker
# or log out and log back in
```

Then verify:

```bash
docker run --rm hello-world
```

### Option B: Rootless Docker (more locked-down environments)

If you prefer not to grant your user access to the Docker daemon socket, use rootless Docker instead.
Follow Docker’s rootless setup docs (distro-specific).

### Helper script

This repo includes:

```bash
./scripts/docker-without-sudo.sh
```

It configures Option A and prints the next steps to apply the change.
