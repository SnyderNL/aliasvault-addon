# AliasVault Home Assistant Add-on (BETA)

⚠️ **Let op: Deze add-on is in BETA.**
Deze versie is bedoeld voor testen. Gebruik in productie op eigen risico.

Deze add-on integreert AliasVault in Home Assistant als een veilige wachtwoord-
en aliasmanager.

---

## ✨ Functionaliteiten

- AliasVault binnen Home Assistant
- Self-signed HTTPS ondersteuning
- HTTP en HTTPS toegang
- Gebruikt officiële AliasVault Docker image

---

## 📦 Installatie

1. Voeg deze repository toe aan Home Assistant
2. Installeer de **AliasVault** add-on
3. Start de add-on
4. Wacht tot de installatie voltooid is
5. Open de webinterface

---

## 🌐 Toegang

Na installatie is AliasVault bereikbaar via:

### HTTPS (aanbevolen)

https://<HOME-ASSISTANT-IP>:3443

Er verschijnt een beveiligingswaarschuwing omdat een self-signed certificaat
wordt gebruikt.

### HTTP

http://<HOME-ASSISTANT-IP>:3000

Niet aanbevolen voor gevoelige data.

---

## 🔐 Admin configuratie

Na eerste start is er geen admin wachtwoord ingesteld.

Om dit te configureren:

docker exec -it aliasvault /bin/bash
aliasvault reset-admin-password

(Wordt later vereenvoudigd via de add-on)

---

## 🚧 Status

🟡 BETA / TESTFASE

Bekende aandachtspunten:

- Self-signed certificaten
- Admin setup via CLI
- Beperkte configuratie

Feedback is welkom.

---

## 📄 Licentie

Deze add-on gebruikt de licentie van AliasVault.

Meer info:
https://docs.aliasvault.net

---
