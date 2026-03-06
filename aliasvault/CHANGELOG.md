# Changelog

## 0.1.6
### What’s changed

#### ⬆️ Upstream AliasVault update
- Updated bundled AliasVault image from `0.27.0` to `0.27.1` (manual fallback bump).
- Upstream release notes: https://github.com/aliasvault/aliasvault/releases/tag/v0.27.1

### Notes
This remains an **unofficial community Home Assistant add-on** for AliasVault.
For core AliasVault bugs/features, please use the upstream project:
https://github.com/aliasvault/aliasvault

## 0.1.5
### What’s changed

#### ⬆️ Upstream AliasVault update
- Updated bundled AliasVault image from `0.26.6` to `0.27.0` (automated via Renovate).
- Upstream release notes: https://github.com/aliasvault/aliasvault/releases/tag/v0.27.0

### Notes
This remains an **unofficial community Home Assistant add-on** for AliasVault.
For core AliasVault bugs/features, please use the upstream project:
https://github.com/aliasvault/aliasvault

## 0.1.4
### What’s changed

#### 🧪 Config parsing hardening for SSL options
- Added a fallback parser for `/data/options.json` when `python3` is unavailable in the runtime image.
- Added explicit init diagnostics logging of resolved SSL options (`ssl`, `certfile`, `keyfile`).
- Prevents silent fallback to self-signed cert behavior when SSL options were not being parsed.

### Notes
This remains an **unofficial community add-on** for AliasVault.
For AliasVault core issues, report upstream:
https://github.com/aliasvault/aliasvault

Oudere wijzigingen: zie `aliasvault/CHANGELOG_ARCHIVE.md` en GitHub Releases.
