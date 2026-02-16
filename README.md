# AliasVault Home Assistant Add-on

> ⚠️ **Unofficial community add-on**  
> Dit project is geen officiële AliasVault distributie.  
> Officiële projectlinks: [AliasVault GitHub](https://github.com/aliasvault/aliasvault) · [AliasVault docs](https://docs.aliasvault.net)

[![Project stage](https://img.shields.io/badge/project%20stage-experimental-yellow.svg)](#)
[![Latest release](https://img.shields.io/github/v/release/SnyderNL/aliasvault-addon)](https://github.com/SnyderNL/aliasvault-addon/releases)
[![License](https://img.shields.io/github/license/SnyderNL/aliasvault-addon)](./LICENSE)

Home Assistant add-on om **AliasVault** te draaien als self-hosted password & alias manager.

## Quick links

- 🚀 [Installatie](#installatie-home-assistant)
- 📚 [Add-on documentatie](./aliasvault/DOCS.md)
- 🐞 [Issues melden](https://github.com/SnyderNL/aliasvault-addon/issues)
- 🏷️ [Releases](https://github.com/SnyderNL/aliasvault-addon/releases)
- 🔗 [Officieel AliasVault project](https://github.com/aliasvault/aliasvault)

## Wat doet deze add-on?

- Draait AliasVault binnen Home Assistant
- Biedt toegang via HTTP en HTTPS
- Gebruikt het officiële AliasVault container-image als basis
- Bevat add-on-specifieke aanpassingen voor Home Assistant runtime

## Installatie (Home Assistant)

1. Ga naar **Settings → Add-ons → Add-on Store**
2. Klik rechtsboven op **⋮ → Repositories**
3. Voeg toe: `https://github.com/SnyderNL/aliasvault-addon`
4. Installeer **AliasVault**
5. Start de add-on
6. Open de webinterface

## Toegang

- HTTP: `http://<home-assistant-ip>:3000`
- HTTPS: `https://<home-assistant-ip>:3443`

`Open Web UI` gebruikt vanaf **v0.0.5** expliciet HTTPS om protocolfouten te voorkomen.

## Eigen SSL-certificaat gebruiken

1. Plaats certificaatbestanden in HA `/ssl` map (bijv. `fullchain.pem` en `privkey.pem`)
2. Open add-on configuratie
3. Zet `ssl` op `true`
4. Vul `certfile` en `keyfile` in
5. Herstart de add-on

Voorbeeld:

```yaml
ssl: true
certfile: fullchain.pem
keyfile: privkey.pem
```

## Known Issues

Zie: [KNOWN_ISSUES.md](./KNOWN_ISSUES.md)

## Roadmap

Zie: [ROADMAP.md](./ROADMAP.md)

## Support scope

- Problemen met deze Home Assistant wrapper? → **issue in deze repo**
- Problemen in AliasVault core? → **upstream**: https://github.com/aliasvault/aliasvault

## Changelog

Zie: [aliasvault/CHANGELOG.md](./aliasvault/CHANGELOG.md)

## Bijdragen

Zie: [CONTRIBUTING.md](./CONTRIBUTING.md)

## Licentie

Dit project is gelicenseerd onder **GNU AGPL-3.0**. Zie [LICENSE](./LICENSE).
