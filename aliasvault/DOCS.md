# AliasVault Home Assistant Add-on - Developer Documentation

⚠️ Status: BETA / Experimental

Deze documentatie is bedoeld voor ontwikkelaars en maintainers.

---

## 📐 Architectuur

Deze add-on gebruikt het officiële AliasVault Docker image:

ghcr.io/aliasvault/aliasvault:latest

De container bevat:

- Nginx reverse proxy
- PostgreSQL database
- AliasVault services
- Self-signed TLS

---

## 🗂️ Projectstructuur

aliasvault-addon/
├── Dockerfile
├── config.json
├── README.md
└── DOCS.md

---

## 🐳 Dockerfile

De add-on gebruikt direct het upstream image:

FROM ghcr.io/aliasvault/aliasvault:latest

Er vindt geen herconfiguratie plaats.

---

## ⚙️ Home Assistant Config

### Poortmapping

| Container | Host | Protocol |
|-----------|------|----------|
| 80        | 3000 | HTTP     |
| 443       | 3443 | HTTPS    |

Geconfigureerd in config.json.

---

### config.json

Belangrijkste instellingen:

"ports": {
  "80/tcp": 3000,
  "443/tcp": 3443
}

Hiermee worden interne webpoorten beschikbaar gemaakt.

---

## 🔐 TLS / HTTPS

AliasVault genereert automatisch self-signed certificaten bij eerste start.

Deze worden gebruikt door de interne Nginx reverse proxy.

Browsers tonen een waarschuwing bij eerste bezoek.

---

## 💾 Persistent Storage

Home Assistant mount:

/data

AliasVault gebruikt deze map voor:

- Database
- Configuratie
- Certificaten
- Logs

Hierdoor blijven gegevens behouden.

---

## 🧩 Services

De container start automatisch:

- PostgreSQL
- API Service
- Admin Service
- SMTP Service
- TaskRunner
- Nginx

Status is zichtbaar in logs.

---

## 🚀 Build & Deployment

### Lokaal testen

docker build -t aliasvault-addon .
docker run -p 3000:80 -p 3443:443 aliasvault-addon

### Home Assistant

- Kopieer add-on map
- Rebuild add-on
- Start service

---

## ⚠️ Bekende Beperkingen

- Geen Ingress ondersteuning
- Geen Let's Encrypt
- Geen Supervisor API integratie
- Geen automatische admin setup

---

## 🗺️ Roadmap

Geplande verbeteringen:

- Ingress integratie
- HA SSL integratie
- Backup support
- Add-on configuratie opties
- GUI admin setup
- Health monitoring

---

## 🧪 Debugging

### Logs bekijken

Home Assistant:

Settings → Add-ons → AliasVault → Logs

### Container shell

docker exec -it aliasvault /bin/bash

---

## 📬 Onderhoud

Bij updates:

1. Test op clean install
2. Test upgrade scenario
3. Controleer dat data behouden blijft
4. Controleer HTTPS
