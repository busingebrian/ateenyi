# SQL Developer for Linux

This repo contains a simple static site and documentation focused on installing and running **Oracle SQL Developer on Linux**.

## Install Oracle SQL Developer (Linux)

### 1) Install Java (recommended: OpenJDK 17)

Ubuntu/Debian:

```bash
sudo apt update
sudo apt install -y openjdk-17-jdk
java -version
```

Fedora:

```bash
sudo dnf install -y java-17-openjdk
java -version
```

### 2) Download SQL Developer (ZIP)

Download the **Linux** ZIP from Oracle (you may need to accept a license / sign in):

- `https://www.oracle.com/database/sqldeveloper/technologies/download/`

You’ll end up with something like `sqldeveloper-*.zip`.

### 3) Extract and run

Example install to your home directory:

```bash
mkdir -p "$HOME/apps"
unzip -q sqldeveloper-*.zip -d "$HOME/apps"
"$HOME/apps/sqldeveloper/sqldeveloper.sh"
```

On first launch, SQL Developer may ask for a **Java home**. Typical values:

- Ubuntu/Debian OpenJDK 17: `/usr/lib/jvm/java-17-openjdk-amd64`
- Fedora OpenJDK 17: `/usr/lib/jvm/java-17-openjdk`

### 4) Set Java home permanently (if prompted repeatedly)

Edit one of these files (the location can vary by version):

- `~/.sqldeveloper/<version>/product.conf`
- `<sqldeveloper-install>/sqldeveloper/bin/sqldeveloper.conf`

Add or update the Java path line:

```
SetJavaHome /usr/lib/jvm/java-17-openjdk-amd64
```

### 5) Install missing Linux libraries (common fixes)

If SQL Developer launches and immediately exits, or you see errors about X11/Font libraries, install:

Ubuntu/Debian:

```bash
sudo apt install -y \
  libxtst6 libxi6 libxrender1 libxrandr2 libxext6 libx11-6 \
  libfreetype6 libfontconfig1
```

Fedora:

```bash
sudo dnf install -y \
  libXtst libXi libXrender libXrandr libXext libX11 \
  freetype fontconfig
```

### 6) (Optional) Create a desktop launcher

Create `~/.local/share/applications/sqldeveloper.desktop`:

```ini
[Desktop Entry]
Type=Application
Name=Oracle SQL Developer
Exec=/home/YOUR_USER/apps/sqldeveloper/sqldeveloper.sh
Icon=/home/YOUR_USER/apps/sqldeveloper/icon.png
Terminal=false
Categories=Development;Database;
```

Then update the menu cache (optional, depending on your desktop environment):

```bash
update-desktop-database ~/.local/share/applications 2>/dev/null || true
```

## Alternatives (often simpler)

- **SQL Developer Extension for VS Code**: lightweight UI inside VS Code
- **SQLcl**: Oracle’s command-line SQL tool (great for terminals/CI)

## Run the local site

This repo also includes a small Express server to serve the static pages:

```bash
npm install
npm start
```

Then open `http://localhost:3000`.
