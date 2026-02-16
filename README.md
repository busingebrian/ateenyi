# busingebrian.io

> Read this guide in a markdown viewer.

## ASYWORLD-UGANDA DEV TOOLS

### Java 8

Install Java 8. Please use Oracle JDK. OpenJDK should **not** be used.

#### Installation Steps for Oracle JDK 8

##### Linux (Ubuntu/Debian)

1. **Download Oracle JDK 8** from the official Oracle website:
   - Visit https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html
   - Accept the license agreement and download the `.tar.gz` archive for your platform (e.g., `jdk-8u381-linux-x64.tar.gz`).
   - Note: You will need an Oracle account to download.

2. **Create a directory for the JDK and extract the archive:**

   ```bash
   sudo mkdir -p /usr/lib/jvm
   sudo tar -xzf jdk-8u381-linux-x64.tar.gz -C /usr/lib/jvm
   ```

3. **Set up environment variables.** Add the following to your profile file (`.bashrc`, `.zshrc`, `.bash_profile`, etc.):

   ```bash
   export JAVA_HOME="/usr/lib/jvm/jdk1.8.0_381"
   export PATH="$JAVA_HOME/bin:$PATH"
   ```

4. **Apply the changes:**

   ```bash
   source ~/.bashrc
   ```

5. **Register the Java installation with the system alternatives (optional but recommended):**

   ```bash
   sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_381/bin/java 1
   sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_381/bin/javac 1
   sudo update-alternatives --set java /usr/lib/jvm/jdk1.8.0_381/bin/java
   sudo update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_381/bin/javac
   ```

6. **Verify the installation:**

   ```bash
   java -version
   ```

   Expected output:

   ```
   java version "1.8.0_381"
   Java(TM) SE Runtime Environment (build 1.8.0_381-b09)
   Java HotSpot(TM) 64-Bit Server VM (build 25.381-b09, mixed mode)
   ```

##### macOS

1. **Download Oracle JDK 8** from the official Oracle website:
   - Visit https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html
   - Accept the license agreement and download the `.dmg` installer for macOS.

2. **Run the `.dmg` installer** and follow the on-screen instructions.

3. **Set up environment variables.** Add the following to your shell profile (`~/.zshrc` or `~/.bash_profile`):

   ```bash
   export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
   export PATH="$JAVA_HOME/bin:$PATH"
   ```

4. **Apply the changes:**

   ```bash
   source ~/.zshrc
   ```

5. **Verify the installation:**

   ```bash
   java -version
   ```

##### Windows

1. **Download Oracle JDK 8** from the official Oracle website:
   - Visit https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html
   - Accept the license agreement and download the `.exe` installer for Windows.

2. **Run the installer** and follow the wizard. Note the installation path (e.g., `C:\Program Files\Java\jdk1.8.0_381`).

3. **Set environment variables:**
   - Open **System Properties** > **Advanced** > **Environment Variables**.
   - Under **System variables**, click **New** and add:
     - Variable name: `JAVA_HOME`
     - Variable value: `C:\Program Files\Java\jdk1.8.0_381`
   - Find the `Path` variable, click **Edit**, and add: `%JAVA_HOME%\bin`

4. **Verify the installation** by opening a new Command Prompt:

   ```cmd
   java -version
   ```

> **Important:** Do not use OpenJDK. The project requires Oracle JDK 8 specifically.
