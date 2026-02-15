# AliasVault Home Assistant Add-on — Developer Documentation

Deze documentatie beschrijft de **Home Assistant add-on wrapper** rond AliasVault.

## Doel van deze add-on

Deze repository levert een HA add-on die het officiële AliasVault image gebruikt en geschikt maakt voor Home Assistant gebruik.

Belangrijk:
- Dit is een community add-on-laag
- AliasVault zelf blijft upstream/software van het AliasVault project

## Architectuur (kort)

- Base image: `ghcr.io/aliasvault/aliasvault:latest`
- Runtime start via upstream init (`/init`)
- HA-specifieke persistentie wordt afgehandeld via s6 hooks:
  - `/etc/cont-init.d/10-ha-persist`
  - `/etc/cont-finish.d/90-ha-persist`

## Persistentiegedrag

Omdat Home Assistant add-ons standaard `/data` persistent maken, synchroniseert deze add-on bij start/stop data tussen `/data/*` en runtime directories die AliasVault gebruikt, waaronder:

- `/database`
- `/logs`
- `/secrets`
- `/certificates`

### SSL certificaten (HA `/ssl` integratie)

Deze add-on ondersteunt het gebruik van een **custom TLS certificaat** vanuit Home Assistant.

- In `config.json` is `map: ["ssl", ...]` ingeschakeld.
- De gebruiker configureert via add-on opties:
  - `ssl: true|false`
  - `certfile` (bijv. `fullchain.pem`)
  - `keyfile` (bijv. `privkey.pem`)

**Werking:**

1. Home Assistant mount `/ssl` in de container.
2. Tijdens container init leest `ha-persist-init.sh` `/data/options.json`.
3. Als `ssl=true` en bestanden bestaan, kopieert de hook:
   - `/ssl/<certfile>` → `/certificates/ssl/cert.pem`
   - `/ssl/<keyfile>` → `/certificates/ssl/key.pem`
4. Als bestanden ontbreken of `ssl=false`, valt AliasVault terug op zijn standaard certificaatlogica (self-signed of bestaande certs in `/certificates/ssl`).

**Notitie:** `certfile`/`keyfile` zijn bestandsnamen (geen volledige paden). De bronmap is altijd `/ssl`.

## Bestandsstructuur

- `aliasvault/config.json` — add-on metadata/configuratie
- `aliasvault/Dockerfile` — Docker build voor de add-on
- `aliasvault/ha-persist-init.sh` — restore bij startup
- `aliasvault/ha-persist-finish.sh` — sync bij shutdown
- `README.md` — gebruikersdocumentatie

## Lokale ontwikkeling

Voor wijziging aan add-on:
1. Pas bestanden aan
2. Verhoog add-on versie in `config.json`
3. Commit + push
4. Refresh custom repo in Home Assistant
5. Rebuild/update add-on

## Troubleshooting

### 1) `bash\r` / shebang fouten
CRLF line endings veroorzaken scriptfouten in Linux containers.
Gebruik LF line endings en `.gitattributes` om regressies te voorkomen.

### 2) Database opnieuw geïnitialiseerd bij restart
Controleer of persist hooks aanwezig zijn en logs tonen dat restore/sync uitgevoerd wordt.

### 3) Tijdelijke nginx upstream connection refused
Tijdens startup kunnen korte 111-errors normaal zijn totdat API volledig gestart is.

## Upstream bronvermelding

Deze add-on bouwt op AliasVault upstream:

- GitHub org: https://github.com/aliasvault
- Hoofdrepo: https://github.com/aliasvault/aliasvault
- Docs: https://docs.aliasvault.net

Voor core-bugs/features in AliasVault zelf: rapporteer upstream.
Voor HA add-on integratieproblemen: gebruik deze add-on repository issues.
