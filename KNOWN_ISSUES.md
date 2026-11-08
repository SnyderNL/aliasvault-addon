# Bekende aandachtspunten

De eerder vastgelegde praktijkvalidatie was op **2026-02-20**, met **v0.1.0**.
De onderstaande uitleg is documentatie; er wordt geen nieuwe praktijktest van
alle situaties mee geclaimd.

Voor installatie, serveradressen en dagelijks gebruik:
[gebruikershandleiding](aliasvault/DOCS.md).

## 1. Tijdelijk `connection refused` tijdens opstart

Korte `111`/`connection refused`-meldingen kunnen voorkomen terwijl de diensten
nog starten. Controleer of de webinterface daarna bereikbaar wordt en de
meldingen verdwijnen. Aanhoudende fouten zijn niet automatisch normale opstart;
controleer dan de add-onlog en de ingestelde poorten.

## 2. Certificaatwaarschuwing in browser of mobiele app

Een standaard self-signed certificaat wordt niet automatisch vertrouwd.
Een browseruitzondering wordt niet automatisch door de mobiele app overgenomen.
Ook moet de naam of het IP-adres op het certificaat bij het gebruikte adres passen.

Zie [HTTPS en certificaten](aliasvault/DOCS.md#https-en-certificaten) voor eigen
certificaten via `/ssl`, de betekenis van `ssl` en clientvertrouwen.

## 3. Gewijzigde opties of vernieuwde eigen certificaten

Opties en eigen bestanden uit `/ssl` worden bij opstart ingelezen. Na een
bewuste wijziging of certificaatvernieuwing is een herstart van de add-on nodig
om die over te nemen. Dit betekent niet dat een al werkende installatie nu
moet worden gewijzigd of herstart.

## 4. HTTPS toont nog een `localhost`-certificaat

Als je eigen certificaten wilt gebruiken, controleer dan:

- `ssl: true` en de juiste bestandsnamen bij `certfile` en `keyfile`.
- Aanwezigheid van beide bestanden in HA `/ssl`.
- De opstartlog: `custom SSL cert loaded from /ssl` bevestigt het kopiëren.
- De naam en geldigheid van het daadwerkelijk aangeboden certificaat.

`SSL enabled but cert/key not found in /ssl` betekent dat de bestanden niet zijn
gevonden. De wrapper laat dan de upstream-certificaatafhandeling actief.
Een succesvolle kopieerlog is op zichzelf geen certificaatvalidatie.

`ssl: false` zet HTTPS niet uit en verwijdert geen eerder opgeslagen certificaat.

## 5. Webapp werkt, app of extensie niet

Controleer **Self-hosted**, de API URL **inclusief `/api`**, de ingestelde poort,
het serveraccount en certificaatvertrouwen. De extensie heeft daarnaast een
**Client URL zonder `/api`**. Een lokaal adres moet ook vanaf het clientapparaat
bereikbaar zijn.

Zie [browserextensie koppelen](aliasvault/DOCS.md#browserextensie-koppelen) en
[mobiele app koppelen](aliasvault/DOCS.md#mobiele-app-koppelen).

## Support

- HA-installatie en wrapper: [deze repository](https://github.com/SnyderNL/aliasvault-addon/issues).
- AliasVault-core en officiële clients: [upstream](https://github.com/aliasvault/aliasvault).

Deel bij een melding alleen relevante, geschoonde foutmeldingen; geen
wachtwoorden, privésleutels of kluisexports.
