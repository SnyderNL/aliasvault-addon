# Contributing

Bedankt dat je wilt bijdragen! 🙌

## Waarvoor deze repo is

Dit project bevat de **Home Assistant add-on wrapper** voor AliasVault.

- HA wrapper issues/features: **deze repo**
- AliasVault core issues/features: **upstream**  
  https://github.com/aliasvault/aliasvault

## Hoe bijdragen

1. Fork de repo
2. Maak een feature branch
3. Houd wijzigingen klein en gericht
4. Update documentatie indien nodig
5. Update `aliasvault/CHANGELOG.md` bij user-visible wijzigingen
6. Open een PR met duidelijke beschrijving

## Releaseproces (kort)

Voor elke versie:
1. Version bump in `aliasvault/config.json`
2. Changelog update in `aliasvault/CHANGELOG.md`
3. Commit + push naar `main`

### Changelog policy (Home Assistant overzicht)

- `aliasvault/CHANGELOG.md` bevat alleen de **laatste 3 versies**.
- Oudere entries verplaatsen naar `aliasvault/CHANGELOG_ARCHIVE.md`.
- CI controleert dit en faalt bij meer dan 3 versie-secties.

Daarna doet automation de rest:
- workflow maakt tag `vX.Y.Z` als die nog niet bestaat
- workflow publiceert GitHub Release met notes uit de changelog
- aparte workflow verifieert dat release/tag versie exact matcht met `aliasvault/config.json`

> Release Drafter is verwijderd; releases lopen volledig via config.json + changelog + release-on-version workflow.

## Bug reports

Gebruik bij voorkeur de bug template en voeg toe:

- Home Assistant versie
- Add-on versie
- Host type (Pi / NUC / VM / etc.)
- Relevante logs
- Repro stappen

## Gedrag

We houden feedback technisch, respectvol en concreet.
