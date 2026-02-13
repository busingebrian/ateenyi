# busingebrian.io

## Apache Ant 1.9.16 (download/install)

This repo includes a helper script to download, verify (SHA-512), and extract **Apache Ant 1.9.16** locally (not committed to git).

```bash
bash scripts/install-ant-1.9.16.sh
export ANT_HOME="$PWD/.tools/ant"
export PATH="$ANT_HOME/bin:$PATH"
ant -version
```
