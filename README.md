# AliasVault Home Assistant Add-on

Home Assistant add-on om **AliasVault** te draaien als self-hosted password & alias manager.

> ⚠️ Dit project is community/experimenteel. Test goed voordat je het in productie gebruikt.

## Wat doet deze add-on?

- Draait AliasVault binnen Home Assistant
- Biedt toegang via HTTP en HTTPS
- Gebruikt het officiële AliasVault container-image als basis
- Bevat add-on-specifieke aanpassingen voor Home Assistant runtime

## Installatie (Home Assistant)

1. Ga naar **Settings → Add-ons → Add-on Store**
2. Voeg deze repository toe als custom repository
3. Installeer **AliasVault**
4. Start de add-on
5. Open de webinterface

## Toegang

- HTTP: `http://<home-assistant-ip>:3000`
- HTTPS: `https://<home-assistant-ip>:3443`

Bij self-signed certificaten kan je browser een waarschuwing tonen.

## Beheer

AliasVault admin setup gebeurt via de AliasVault tooling in de container. Zie add-on logs voor actuele statusinformatie.

## Disclaimer

Deze add-on is **niet** de officiële AliasVault distributie. Voor officiële installatie-instructies, documentatie en support, gebruik de bronnen hieronder.

## Licentie

Dit project is gelicenseerd onder **GNU AGPL-3.0**. Zie `LICENSE`.

## Bronvermelding (upstream)

- Originele organisatie/repository: **AliasVault**
- GitHub org: https://github.com/aliasvault
- Hoofdrepository: https://github.com/aliasvault/aliasvault
- Officiële docs: https://docs.aliasvault.net

---

Wil je bijdragen of issues melden voor deze Home Assistant add-on? Gebruik de issues van deze repository.
