# Apache ActiveMQ (Classic) Installation on Linux

This guide installs **Apache ActiveMQ Classic** from the official binary distribution, configures it to run as a dedicated user, and sets it up as a `systemd` service.

## Prerequisites

- **Java**: ActiveMQ Classic runs on Java. Install **Java 11+** (Java 17 is a solid default).
- **Tools**: `curl` (or `wget`), `tar`, `sudo`

### Install Java

#### Ubuntu / Debian

```bash
sudo apt update
sudo apt install -y openjdk-17-jre-headless curl tar
java -version
```

#### RHEL / CentOS / Fedora

```bash
sudo dnf install -y java-17-openjdk-headless curl tar
java -version
```

## Download and install ActiveMQ

Pick a version from the Apache ActiveMQ download page and set it here (example version below).

```bash
AMQ_VERSION="5.18.3"
cd /tmp
curl -fsSLO "https://archive.apache.org/dist/activemq/${AMQ_VERSION}/apache-activemq-${AMQ_VERSION}-bin.tar.gz"
tar -xzf "apache-activemq-${AMQ_VERSION}-bin.tar.gz"
```

Install to `/opt` and create a stable symlink at `/opt/activemq`:

```bash
sudo mkdir -p /opt
sudo mv "/tmp/apache-activemq-${AMQ_VERSION}" "/opt/apache-activemq-${AMQ_VERSION}"
sudo ln -sfn "/opt/apache-activemq-${AMQ_VERSION}" /opt/activemq
```

## Create a dedicated user

```bash
sudo useradd --system --home /opt/activemq --shell /usr/sbin/nologin activemq || true
sudo chown -R activemq:activemq "/opt/apache-activemq-${AMQ_VERSION}"
```

## Quick start (foreground)

Run it in the foreground once to validate the install:

```bash
sudo -u activemq /opt/activemq/bin/activemq console
```

Stop with `Ctrl+C`.

## Configure `systemd`

### 1) Create an optional environment file

This makes it easy to override `JAVA_HOME` and other settings without editing the unit.

Create `/etc/default/activemq`:

```bash
sudo tee /etc/default/activemq >/dev/null <<'EOF'
# Optional overrides for the systemd unit
ACTIVEMQ_HOME=/opt/activemq

# Set if your distro doesn't provide JAVA_HOME automatically
# Example paths:
# - Ubuntu/Debian: /usr/lib/jvm/java-17-openjdk-amd64
# - RHEL/Fedora:   /usr/lib/jvm/java-17-openjdk
#JAVA_HOME=
EOF
```

### 2) Install the `systemd` unit

Create `/etc/systemd/system/activemq.service`:

```bash
sudo tee /etc/systemd/system/activemq.service >/dev/null <<'EOF'
[Unit]
Description=Apache ActiveMQ Classic
After=network.target

[Service]
Type=forking
User=activemq
Group=activemq
EnvironmentFile=-/etc/default/activemq
WorkingDirectory=/opt/activemq

ExecStart=/opt/activemq/bin/activemq start
ExecStop=/opt/activemq/bin/activemq stop
ExecReload=/opt/activemq/bin/activemq restart

Restart=on-failure
RestartSec=5
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
EOF
```

Enable and start:

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now activemq
sudo systemctl status activemq --no-pager
```

## Verify it’s running

### Check listening ports

Default ports:

- **61616/tcp**: OpenWire (JMS)
- **8161/tcp**: Web console (Jetty)

```bash
sudo ss -lntp | awk 'NR==1 || /:61616|:8161/'
```

### Web console

By default it listens on `http://localhost:8161/`.

If you’re on the server:

```bash
curl -I http://localhost:8161/ | head -n 1
```

If you need remote access, use SSH port-forwarding:

```bash
ssh -L 8161:localhost:8161 your_user@your_server
```

Then browse `http://localhost:8161/`.

## Common configuration locations

- **Broker configuration**: `/opt/activemq/conf/activemq.xml`
- **Web console users/roles**: `/opt/activemq/conf/jetty-realm.properties`
- **Logs**: `/opt/activemq/data/activemq.log` (and other files under `/opt/activemq/data/`)

## Hardening checklist (recommended)

- Change default credentials in `conf/jetty-realm.properties`
- Restrict web console bind address and/or firewall access to `8161`
- Run behind SSH tunnel or VPN instead of exposing `8161` publicly

