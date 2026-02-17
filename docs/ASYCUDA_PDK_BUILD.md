## Prerequisites (SOClass)

Before building ASYCUDA, first install:

- **SOClass Server**
- **SOClass Client**
- **SOClass ADK**
- **SOClass Report**
- **SOClass VectorGraphics**

These components are vendor-provided installers and are not distributed with this repository.

## Build steps

1. Create `build/custom.properties` using the template file `build/custom.properties.template` (follow the comments in the template).
2. Create `build/platform.properties` using the template file `build/platform.properties.template` (follow the comments in the template).
3. Execute:

```bash
ant createPDK
```

## Output: PDK in `release/`

After the build completes, the `release/` folder contains the PDK of ASYCUDA. You can then:

### Install locally

- Go to `release/` and run:

```bash
java -jar setup.jar
```

### Deploy to production

- Archive/burn/send the `release/` folder to the production system and run:

```bash
java -jar setup.jar
```

This installs ASYCUDA on SOClass server, SOClass client, or can be used to:

- deploy ULA, or
- create **End User Client Setup** (prepares a folder used to deploy client jars and reference tables on client computers)

## EMS compatibility

ASYCUDA is built for **EMS 1.4.0.3** (SOClass up to **2.2.31**).

To build ASYCUDA for EMS **1.5** or **1.6** (SOClass **2.2.31+**):

- Uncomment `so.ems.version` in `build/custom.properties`, or invoke:

```bash
ant -Dso.ems.version=1.5 createPDK
```

