# AliasVault gebruiken vanuit Home Assistant

Handleiding voor de **onofficiële community-add-on**. AliasVault draait als eigen
dienst naast Home Assistant. Je opent je kluis via de webapp, browserextensie of
mobiele app.

Werkt je installatie al? Gebruik dit als naslag. Je hoeft geen instellingen te
wijzigen, opnieuw te installeren of een back-up terug te zetten om deze
handleiding te lezen.

## Inhoud

- [Installatie en eerste gebruik](#installatie-en-eerste-gebruik)
- [Het juiste serveradres](#het-juiste-serveradres)
- [Browserextensie koppelen](#browserextensie-koppelen)
- [Mobiele app koppelen](#mobiele-app-koppelen)
- [HTTPS en certificaten](#https-en-certificaten)
- [Back-up en kluisexport](#back-up-en-kluisexport)
- [Problemen oplossen](#problemen-oplossen)
- [Support en achtergrond](#support-en-achtergrond)

## Installatie en eerste gebruik

Heb je de add-on al geïnstalleerd? Sla de installatiestappen over.

1. Open **Settings → Add-ons → Add-on Store** in Home Assistant
   (in nieuwere versies heet Add-ons **Apps**).
2. Open **⋮ → Repositories** en voeg toe:
   `https://github.com/SnyderNL/aliasvault-addon`.
3. Installeer **AliasVault**, start de add-on en kies **Open Web UI**.
4. Kies in AliasVault voor een nieuwe kluis als je nog geen account op deze
   server hebt. Volg de stappen voor gebruikersnaam en hoofdwachtwoord.
   Heb je al een account? Meld je daarmee aan.
5. Maak een eerste login-item met een websiteadres, gebruikersnaam en wachtwoord.
   Gebruik eventueel een testitem om de synchronisatie met je clients te controleren.

Je AliasVault-account is **niet** je Home Assistant-account en ook niet
automatisch een account op de AliasVault-cloud. Bewaar je gebruikersnaam en
hoofdwachtwoord zorgvuldig. Een serverback-up vervangt je hoofdwachtwoord niet.

De beheerpagina `/admin` staat los van je persoonlijke kluis en gebruikt een
apart beheeraccount. Een nieuwe kluis aanmaken vereist geen aanmelding als
`admin`. Als registratie op de server is uitgeschakeld, bepaalt de beheerder
hoe nieuwe gebruikers toegang krijgen.

## Het juiste serveradres

Standaard publiceert de add-on HTTP op **3000** en HTTPS op **3443**. Bij een
aangepaste poorttoewijzing gebruik je jouw ingestelde poort. **Open Web UI**
verwijst naar HTTPS.

| Doel | Rechtstreeks naar de add-on | Via een al ingerichte HTTPS-reverse-proxy |
| --- | --- | --- |
| Webapp / Client URL | `https://<ha-adres>:3443` | `https://vault.example.com` |
| API URL voor de clients | `https://<ha-adres>:3443/api` | `https://vault.example.com/api` |

Vervang de voorbeeldadressen door je eigen bereikbare adres. Gebruik bij een
certificaat voor een domeinnaam die domeinnaam, niet zomaar het IP-adres. Een
IP-adres werkt zonder naamfout alleen als het certificaat ook daarvoor geldig is.

- Vul niet het HA-dashboardadres op poort `8123` in.
- Gebruik niet de Home Assistant Cloud-dashboardlink als AliasVault-serveradres.
- `localhost` op je telefoon of laptop verwijst naar dat apparaat zelf, niet naar HA.
- Een lokaal adres werkt thuis of via een passende VPN-verbinding. De installatie
  publiceert je kluis niet automatisch op internet; een lokale installatie hoeft
  niet publiek te worden om deze te gebruiken.

## Browserextensie koppelen

1. Installeer de officiële AliasVault-extensie voor je browser via het
   [officiële browseroverzicht](https://docs.aliasvault.com/installation/browser-extensions/).
2. Open de extensie en ga bij het aanmeldscherm naar de instellingen voor
   **Server Configuration**. Kies **Self-hosted**.
3. Vul **API URL** in met `/api`, bijvoorbeeld
   `https://vault.example.com:3443/api` bij directe toegang op de standaardpoort.
4. Vul **Client URL** in zonder `/api`, bijvoorbeeld
   `https://vault.example.com:3443`. Gebruik in beide velden je eigen adres en poort.
5. Ga terug naar aanmelden en gebruik het AliasVault-account van deze server.
6. Controleer of je testitem verschijnt. Open de bijbehorende website om
   automatisch invullen te proberen. Geef de extensie daarvoor de door je browser
   gevraagde toegang tot die website.

Menuvertalingen kunnen per clientversie verschillen. Het gaat om de velden
**API URL** en **Client URL**, niet om de standaardkeuze voor de cloudserver.

## Mobiele app koppelen

1. Installeer de officiële app voor
   [Android](https://docs.aliasvault.com/installation/mobile-apps/android/) of
   [iOS](https://docs.aliasvault.com/installation/mobile-apps/ios/).
2. Open bij het aanmeldscherm de serverinstellingen en kies **Self-hosted**.
3. Vul bij de aangepaste **API URL** jouw HTTPS-adres **inclusief `/api`** in,
   bijvoorbeeld `https://vault.example.com:3443/api`.
4. Meld je aan met hetzelfde AliasVault-account als in de webapp en controleer
   of je testitem verschijnt.
5. Wil je automatisch invullen? Selecteer AliasVault ook als aanbieder voor
   wachtwoorden/autofill in de instellingen van Android of iOS.

Test eerst terwijl je telefoon en HA via hetzelfde netwerk bereikbaar zijn.
Werkt het thuis maar niet via mobiel internet, controleer dan de bereikbaarheid
via je bestaande VPN of domeinnaam; verander niet meteen de add-oninstellingen.

De mobiele release-apps vereisen HTTPS. Een certificaatwaarschuwing accepteren
in de browser maakt het certificaat niet automatisch vertrouwd door de app.

## HTTPS en certificaten

### Wat betekent de optie `ssl`?

| Optie | Betekenis |
| --- | --- |
| `ssl: false` | De wrapper neemt geen eigen certificaatbestanden uit HA `/ssl` over. Dit schakelt HTTPS **niet** uit. Eerder opgeslagen certificaten kunnen blijven bestaan; anders geldt de upstream-certificaatafhandeling. |
| `ssl: true` | De wrapper probeert bij opstart `certfile` en `keyfile` uit HA `/ssl` over te nemen. |
| `certfile` / `keyfile` | Bestandsnamen binnen HA `/ssl`, standaard `fullchain.pem` en `privkey.pem`. |

De standaard HTTPS-poort blijft **3443**. De `ssl`-optie beheert niet de
HTTP-poort, een reverse-proxy of het afdwingen van een HTTPS-redirect.

### Eigen certificaat uit Home Assistant gebruiken

Dit is optioneel. Laat een werkende certificaat-/proxyconfiguratie staan als je
die al hebt.

1. Zorg voor een geldig certificaat voor de naam waarmee je AliasVault opent.
   Plaats de certificaatketen en bijbehorende privésleutel in HA `/ssl`.
2. Vul in de add-onconfiguratie de bestandsnamen in, zonder `/ssl/` ervoor:

   ```yaml
   ssl: true
   certfile: fullchain.pem
   keyfile: privkey.pem
   ```

3. Sla op en herstart **alleen de AliasVault-add-on** om de bestanden in te lezen.
4. Controleer de add-onlog op `custom SSL cert loaded from /ssl`.
   Open daarna je HTTPS-adres en controleer in de browser de naam, geldigheid en
   certificaatketen. De logregel bevestigt alleen het kopiëren, niet dat het
   certificaat geldig of vertrouwd is.

Staat er `SSL enabled but cert/key not found in /ssl`, controleer dan de
bestandsnamen en aanwezigheid in HA `/ssl`. De wrapper stopt in dat geval niet
automatisch; upstream-certificaatafhandeling blijft actief.

De wrapper kopieert de bestanden bij opstart, niet doorlopend. Na vernieuwing
van deze bestanden is opnieuw starten van de add-on nodig om ze over te nemen.
Dit geldt voor deze `/ssl`-route; een externe reverse-proxy beheert zijn eigen
certificaat en vernieuwing. De add-on vraagt zelf geen Let's Encrypt-certificaat aan.

### Self-signed en mobiele apparaten

Een self-signed certificaat is versleuteling zonder automatisch vertrouwde
uitgever. Daarnaast moet de naam of het IP-adres in het certificaat overeenkomen
met je verbindingsadres. Alleen handmatig vertrouwen lost een verkeerde naam
niet op.

Een door het apparaat vertrouwd certificaat voor je eigen domeinnaam is meestal
de eenvoudigste route. Upstream beschrijft handmatig vertrouwen voor
[Android](https://docs.aliasvault.com/installation/mobile-apps/android/ssl-setup/) en
[iOS](https://docs.aliasvault.com/installation/mobile-apps/ios/ssl-setup/).
De servercommando's voor `install.sh` en Docker Compose op die pagina's horen
**niet** bij deze HA-add-on. Deze add-on heeft geen `HOSTNAME`-optie in zijn
configuratiescherm. Alleen importeren van een certificaat met een verkeerde naam
maakt de mobiele verbinding niet werkend.

Deel voor certificaatvertrouwen uitsluitend het **publieke certificaat**,
nooit `privkey.pem` of een andere privésleutel.

## Back-up en kluisexport

Dit zijn twee verschillende hulpmiddelen:

| Hulpmiddel | Bedoeld voor | Niet hetzelfde als |
| --- | --- | --- |
| HA-back-up met AliasVault geselecteerd | De add-oninstellingen en de door HA meegenomen opgeslagen add-ondata herstellen | Een losse, overdraagbare kluisexport |
| AliasVault-kluisexport | Kluisgegevens bewaren of overzetten via een ondersteund importformaat | Een kopie van de volledige server, accounts, e-mailopslag en HA-instellingen |

### Home Assistant-back-up

1. Ga naar **Settings → System → Backups**.
2. Controleer dat **AliasVault** bij de opgenomen add-ons/apps staat. Alleen
   Home Assistant-instellingen selecteren neemt deze add-on niet automatisch mee.
3. Gebruik je eigen bestanden uit HA `/ssl`? Controleer dat ook de HA-onderdelen
   met die bestanden in je back-up zitten. Een externe reverse-proxy of externe
   certificaatvoorziening valt niet vanzelf onder deze add-onback-up.
4. Controleer of de back-up zonder fouten is afgerond en bewaar een kopie buiten
   de HA-machine. Bewaar bij versleutelde back-ups ook de benodigde
   herstelsleutel/emergency kit buiten HA.

Zie de [officiële HA-back-uphandleiding](https://www.home-assistant.io/common-tasks/general/backups/)
voor de keuzes en herstelstappen in jouw HA-versie. Een back-upbestand bewijst
nog geen geslaagd herstel; deze documentatie bevat geen uitgevoerde hersteltest
van de add-on. Probeer herstel niet uit over je werkende installatie heen.

### Kluisexport uit AliasVault

1. Ontgrendel je kluis en open **Settings → Import / Export**
   (de exacte vertaling kan verschillen).
2. Kies voor een beveiligde kluiskopie de **versleutelde `.avex`-export**.
3. Bevestig met je hoofdwachtwoord en kies het aparte exportwachtwoord als
   daarom wordt gevraagd. Bewaar dat wachtwoord los van het exportbestand.
4. Sla het bestand op een door jou gekozen beveiligde locatie op.

De exportmogelijkheden zijn afhankelijk van je clientversie. Upstream 0.31.2
ondersteunt `.avex` ook in de browserextensie en mobiele app; zie de
[upstreamrelease](https://github.com/aliasvault/aliasvault/releases/tag/0.31.2).
Gebruik eventueel de webapp als jouw client die keuze nog niet toont.

**`.avux` en CSV zijn niet versleuteld.** CSV bevat bovendien niet alle
kluisgegevens die de AliasVault-exportformaten kunnen bewaren. Gebruik die
formaten bewust voor een passende migratie, niet als uitwisselbare naam voor
een versleutelde back-up. Ook een versleutelde kluisexport vervangt geen volledige
serverback-up.

## Problemen oplossen

Begin met controleren; opnieuw installeren of herstellen is geen eerste stap
bij een verbindingsprobleem.

| Situatie | Controleer eerst |
| --- | --- |
| Webinterface opent niet | Draait de add-on? Kloppen adres en ingestelde HTTPS-poort? Open de log om te zien of opstarten nog bezig is of een fout meldt. |
| Kort `connection refused` tijdens opstart | Kijk of de melding verdwijnt zodra de diensten zijn gestart. Een blijvende fout is niet automatisch normale opstart. |
| Webapp werkt, app/extensie niet | Staat **Self-hosted** geselecteerd? Klopt de API URL inclusief `/api` en poort? Gebruik je hetzelfde serveraccount? Vertrouwt de client het certificaat? |
| Certificaat toont `localhost` of verkeerde naam | Vergelijk de adresnaam met het certificaat. Controleer bij eigen `/ssl`-bestanden de bestandsnamen en opstartlog. |
| Werkt thuis, niet onderweg | Kan het apparaat je serveradres bereiken via VPN of reeds ingerichte externe toegang? Een lokaal IP werkt niet rechtstreeks via mobiel internet. |
| Geen of andere kluisgegevens zichtbaar | Controleer serverkeuze, gebruikersnaam en synchronisatiemeldingen. Maak niet meteen een nieuw account en importeer niet blind een export. |
| Nieuwe add-onversie niet zichtbaar | Vernieuw de add-onwinkel en vergelijk met [GitHub Releases](https://github.com/SnyderNL/aliasvault-addon/releases). Add-on- en upstreamversienummers zijn verschillend. |

Meer context: [bekende aandachtspunten](../KNOWN_ISSUES.md).

## Support en achtergrond

- Problemen met installatie, HA-opties of deze wrapper:
  [issue in deze repository](https://github.com/SnyderNL/aliasvault-addon/issues).
- Problemen in de kluis, browserextensie of mobiele app zelf:
  [officieel AliasVault-project](https://github.com/aliasvault/aliasvault).
- Technische werking en releases: [ontwikkelaarsdocumentatie](../DEVELOPMENT.md).

Vermeld bij een melding je HA-versie, add-onversie, clientversie en foutmelding.
Deel geen wachtwoorden, exports, privésleutels of complete ongeschoonde logs.

Deze uitleg is gebaseerd op add-on **0.3.3**, upstream **0.31.2** en de officiële
client-/HA-documentatie. De stappen zijn niet als volledige praktijktest op alle
HA-, browser- en telefoonvarianten uitgevoerd.
