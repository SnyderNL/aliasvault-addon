# AliasVault Home Assistant Add-on — Developer Documentation

Deze documentatie beschrijft de Home Assistant add-on wrapper rond AliasVault.

## Scope

Deze repository beheert de **HA add-on integratie**:
- add-on metadata/configuratie
- runtime hooks voor persistentie
- release-automatisering van de add-on

Voor functionele/core issues in AliasVault: rapporteer upstream.

## Ondersteunde architecturen

- `amd64`
- `aarch64`

## Architectuur (kort)

- Base image: `ghcr.io/aliasvault/aliasvault` (pinned tag, door Renovate beheerd)
- Runtime start via upstream `/init`
- HA persistentie via hooks:
  - `/etc/cont-init.d/10-ha-persist`
  - `/etc/cont-finish.d/90-ha-persist`

## Persistentie

Data wordt tussen runtime en `/data` gesynchroniseerd voor:
- `/database`
- `/logs`
- `/secrets`
- `/certificates`

## SSL via Home Assistant `/ssl`

Configuratieopties:
- `ssl`
- `certfile`
- `keyfile`

Bij `ssl=true` en geldige bestanden in `/ssl`, worden cert/key naar `/certificates/ssl` gekopieerd.

## Releaseflow

1. Upstream image bump in `aliasvault/Dockerfile` (meestal via Renovate)
2. Auto-bump workflow maakt PR met:
   - `aliasvault/config.json`
   - `aliasvault/CHANGELOG.md`
   - indien nodig `aliasvault/CHANGELOG_ARCHIVE.md`
3. Na merge maakt releaseflow tag/release `vX.Y.Z`
4. Verify-workflow controleert tag-versie ↔ `config.json`

## Changelogbeleid

- `aliasvault/CHANGELOG.md` bevat alleen de laatste 3 versies (HA leesbaarheid)
- Oudere entries gaan naar `aliasvault/CHANGELOG_ARCHIVE.md`
- CI controleert en faalt bij >3 versies in `CHANGELOG.md`

## Troubleshooting (kort)

- **HA ziet nieuwe versie niet**: controleer `config.json` op `main` en refresh add-on store.
- **Release/tag mismatch**: controleer verify-workflow + `config.json` versie.
- **TLS waarschuwing browser**: gebruik eigen certificaat via `/ssl`.

## Upstream referenties

- AliasVault GitHub: https://github.com/aliasvault/aliasvault
- AliasVault docs: https://docs.aliasvault.net
