# Known Issues

Laatste validatie: **2026-02-20** op **v0.1.0**.

## 1) Tijdelijke `connection refused` tijdens startup

Korte 111/connection refused meldingen kunnen voorkomen tot alle services volledig gestart zijn.

**Status:** verwacht tijdens opstart, tijdelijk.

## 2) Browserwaarschuwing bij self-signed certificaat

Zonder eigen certificaat kan de browser een TLS-waarschuwing tonen.

**Workaround:** gebruik `/ssl` met `ssl/certfile/keyfile` opties.

## 3) Optiewijzigingen vragen restart

Na wijziging van add-on opties is meestal een herstart nodig.

## 4) Support scope

Deze repo beheert alleen de HA add-on wrapper.
Core AliasVault issues horen upstream:
https://github.com/aliasvault/aliasvault
