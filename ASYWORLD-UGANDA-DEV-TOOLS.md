# ASYWORLD-UGANDA DEV TOOLS

## Java 8 (Oracle JDK — **do not use OpenJDK**)

These steps install **Oracle JDK 8** on Linux from the **official Oracle download** (manual install). This avoids OpenJDK builds.

### 1) Remove OpenJDK (if installed)

```bash
java -version
```

If it says `OpenJDK`, remove it first (Debian/Ubuntu):

```bash
sudo apt update
sudo apt remove -y 'openjdk-*' || true
sudo apt autoremove -y
```

### 2) Download Oracle JDK 8 from Oracle

- Go to Oracle’s Java 8 archive downloads page: `https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html`
- Download the **JDK** (not JRE) for Linux x64, typically **“Compressed Archive (.tar.gz)”**
- You may need to sign in to Oracle and accept the license terms.

### 3) Install (extract) the JDK

Assuming you downloaded a file like `jdk-8u381-linux-x64.tar.gz` into `~/Downloads`:

```bash
sudo mkdir -p /usr/lib/jvm
cd ~/Downloads
sudo tar -xzf jdk-8u*-linux-x64.tar.gz -C /usr/lib/jvm
```

Confirm the extracted folder name (example: `jdk1.8.0_381`):

```bash
ls /usr/lib/jvm
```

### 4) Set `JAVA_HOME` and update `PATH`

Add this to your shell profile (for bash, `~/.bashrc`):

```bash
export JAVA_HOME="/usr/lib/jvm/jdk1.8.0_381"
export PATH="$JAVA_HOME/bin:$PATH"
```

Reload your shell config:

```bash
source ~/.bashrc
```

### 5) Register Oracle Java 8 as the system default

```bash
sudo update-alternatives --install /usr/bin/java java "$JAVA_HOME/bin/java" 1081
sudo update-alternatives --install /usr/bin/javac javac "$JAVA_HOME/bin/javac" 1081
sudo update-alternatives --set java "$JAVA_HOME/bin/java"
sudo update-alternatives --set javac "$JAVA_HOME/bin/javac"
```

If you have multiple Java versions installed, you can also pick interactively:

```bash
sudo update-alternatives --config java
sudo update-alternatives --config javac
```

### 6) Verify you’re on Oracle JDK 8 (not OpenJDK)

```bash
java -version
javac -version
echo "$JAVA_HOME"
which java
```

Expected `java -version` output should mention **`Java(TM)`** / **Oracle** and **not** `OpenJDK`.
