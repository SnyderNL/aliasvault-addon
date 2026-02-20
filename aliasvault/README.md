# Home Assistant Add-on: AliasVault

[![Version](https://img.shields.io/github/release/SnyderNL/aliasvault-addon.svg?label=version)](https://github.com/SnyderNL/aliasvault-addon/releases)
![Project stage](https://img.shields.io/badge/project%20stage-community-yellow.svg)
![Maintained](https://img.shields.io/badge/maintained-yes-brightgreen.svg)
![License](https://img.shields.io/badge/license-AGPL--3.0-orange.svg)

AliasVault add-on voor Home Assistant (community maintained).

## Over deze add-on

Deze add-on draait het officiële AliasVault image binnen Home Assistant, met add-on-specifieke persistentie en SSL-integratie.

Toegang is primair bedoeld via HTTPS. HTTP kan technisch werken, maar valt buiten officiële AliasVault-support.

- Ondersteund: `amd64`, `aarch64`

> Dit is een **onofficiële community add-on**. Voor AliasVault core issues: https://github.com/aliasvault/aliasvault

## Screenshots

<table>
  <tr>
    <th align="center">Web app</th>
    <th align="center">Browser extension</th>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/fa5bf64a-704d-4f09-b4e0-0310ab662204" alt="AliasVault web app" />
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/b5218609-217b-4c8d-8d5d-8c71e19bf057" alt="AliasVault browser extension" />
    </td>
  </tr>
  <tr>
    <th align="center">Mobiele app</th>
    <th align="center">Features</th>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/5d09ad78-d145-48a1-b8da-c5a1dc708886" alt="AliasVault mobile app" />
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/34fe650d-f08d-4c92-92e0-4e750b7a662a" alt="AliasVault features" />
    </td>
  </tr>
</table>

## Installatie

1. Ga naar **Settings → Add-ons → Add-on Store**
2. Voeg repository toe: `https://github.com/SnyderNL/aliasvault-addon`
3. Installeer **AliasVault**
4. Start de add-on
5. Open Web UI

## Configuratie (voorbeeld)

```yaml
ssl: true
certfile: fullchain.pem
keyfile: privkey.pem
```

## Links

- Add-on documentatie: https://github.com/SnyderNL/aliasvault-addon/blob/main/aliasvault/DOCS.md
- Changelog: https://github.com/SnyderNL/aliasvault-addon/blob/main/aliasvault/CHANGELOG.md
- Issues: https://github.com/SnyderNL/aliasvault-addon/issues
- Upstream AliasVault: https://github.com/aliasvault/aliasvault
