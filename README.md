# busingebrian.io

## Notes

### Maven dependency resolution (internal SNAPSHOT artifacts)

If you see errors like:

- `Could not find artifact ug.go.ura.domain.utility:ura-domain-service:jar:1.0-SNAPSHOT`
- `Could not find artifact ug.go.ura.domain.utility:ura-application-service:jar:1.0-SNAPSHOT`

…those artifacts are **not in Maven Central**, so Maven can only resolve them if:

- you build/install them locally (reactor build / `mvn install`), or
- you have access to an internal Maven repository (Nexus/Artifactory/GitHub Packages) that hosts them.

See `docs/maven/internal-snapshot-deps.md` for concrete fix options (including a helper install script).
