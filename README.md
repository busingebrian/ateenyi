# busingebrian.io

This repository currently contains a small Node/Express server (`server.js`) and static HTML/CSS/JS assets.

## ASYCUDA PDK build (SOClass / EMS)

Before building ASYCUDA, first install:

- **SOClass Server**
- **SOClass Client**
- **SOClass ADK**
- **SOClass Report**
- **SOClass VectorGraphics**

### Steps to build

1. Create `build/custom.properties` from `build/custom.properties.template` (see comments inside the template).
2. Create `build/platform.properties` from `build/platform.properties.template` (see comments inside the template).
3. Execute:

```bash
ant createPDK
```

In folder `release/` is placed the PDK of ASYCUDA. You can then:

- Go to `release/` and run `java -jar setup.jar`
- Archive/burn/send that folder to the production system and run `java -jar setup.jar` to install ASYCUDA on:
  - SOClass server
  - SOClass client
  - or deploy ULA / create End User Client Setup (prepares a folder to deploy client jars and reference tables)

### EMS version notes

ASYCUDA is built for **EMS 1.4.0.3** (SOClass up to **2.2.31**).

To build for EMS **1.5** or **1.6** (SOClass **2.2.31+**):

- Uncomment `so.ems.version` in `build/custom.properties`, or invoke:

```bash
ant -Dso.ems.version=1.5 createPDK
```

