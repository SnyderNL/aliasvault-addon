# Known Issues

Deze lijst bevat bekende beperkingen van de Home Assistant add-on wrapper.

Laatste validatie: **2026-02-16** op **v0.0.4**.

## 1) Tijdelijke upstream connection refused bij startup

Tijdens startup kunnen kort `connection refused` / `111` meldingen in logs verschijnen
 totdat alle services volledig gestart zijn.

**Status:** Verwacht gedrag tijdens opstartfase (tijdelijk).

---

## 2) Browserwaarschuwing bij self-signed cert

Als je geen eigen certificaat hebt ingesteld, kan de browser een TLS-waarschuwing tonen.

**Workaround:** Gebruik een eigen certificaat via `/ssl` + `ssl/certfile/keyfile` opties.

---

## 3) Config wijziging soms pas actief na restart

Na aanpassen van add-on opties is een restart van de add-on nodig om alles consistent te laden.

**Workaround:** Handmatig add-on herstarten na config wijzigingen.

---

## 4) Scope van support

Deze repository beheert alleen de HA add-on laag.
Functionele bugs in AliasVault zelf horen upstream.

- Upstream: https://github.com/aliasvault/aliasvault
