# Resolving missing internal SNAPSHOT dependencies (Maven)

This is what the error usually means:

> `Could not find artifact ug.go.ura.domain.utility:ura-domain-service:jar:1.0-SNAPSHOT`

`ug.go.ura.domain.utility:*` is an **internal** coordinate, so Maven will not find it in Maven Central unless your organization publishes it to an accessible repository.

---

## Option A (preferred): resolve from an internal Maven repo (Nexus/Artifactory/GitHub Packages)

### 1) Add a snapshots repository (if the project POM doesn’t already have one)

Add this to the POM that declares the dependency (or the parent POM if you have one):

```xml
<repositories>
  <repository>
    <id>ura-snapshots</id>
    <url>https://YOUR_NEXUS_OR_ARTIFACTORY_HOST/repository/maven-snapshots/</url>
    <releases>
      <enabled>false</enabled>
    </releases>
    <snapshots>
      <enabled>true</enabled>
    </snapshots>
  </repository>
</repositories>
```

If the repo also hosts releases, add a second `<repository>` entry for releases (or enable releases in the same repo entry, if that’s how your repo is set up).

### 2) Configure credentials in `~/.m2/settings.xml` (if required)

If the repository requires auth, add:

```xml
<settings>
  <servers>
    <server>
      <id>ura-snapshots</id>
      <username>${env.MAVEN_REPO_USERNAME}</username>
      <password>${env.MAVEN_REPO_PASSWORD}</password>
    </server>
  </servers>
</settings>
```

Make sure the `<id>` matches the repository `<id>` in the POM.

### 3) Force Maven to re-check SNAPSHOTs

```bash
mvn -U clean verify
```

If Maven cached a “not found”, delete the cached directory and retry:

```bash
rm -rf ~/.m2/repository/ug/go/ura/domain/utility
mvn -U clean verify
```

---

## Option B: build and install those artifacts locally (reactor / local install)

If you have the source code for:

- `ug.go.ura.domain.utility:ura-domain-service:1.0-SNAPSHOT`
- `ug.go.ura.domain.utility:ura-application-service:1.0-SNAPSHOT`

Build and install them into your local Maven repo:

```bash
cd /path/to/ura-domain-utility
mvn -DskipTests install
```

Then build your `api` module again.

---

## Option C: you only have JAR files (install into `~/.m2` from disk)

If your team shares the JARs but not a Maven repository, you can install them into your local Maven repo with:

- `scripts/maven/install-ura-domain-utility.sh`

Example:

```bash
./scripts/maven/install-ura-domain-utility.sh /path/to/jars
```

The script expects these filenames by default:

- `ura-domain-service-1.0-SNAPSHOT.jar`
- `ura-application-service-1.0-SNAPSHOT.jar`

---

## Quick checklist

- Is `1.0-SNAPSHOT` the correct version, and does it exist in the internal repo?
- Are you building from the project root (so all modules are in the Maven reactor), or only from `api/`?
- Are your `<repositories>` and `~/.m2/settings.xml` `server` ids aligned?
- Did you try `mvn -U` and clearing the cached “not found” directory?
