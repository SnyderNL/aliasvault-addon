# Changelog

## 0.1.2
### What’s changed

#### 🛠️ Runtime fix for Home Assistant persistence + SSL import
- Fixed add-on startup integration to hook into AliasVault's actual s6 init flow.
- Replaced unused `/etc/cont-init.d` approach with an init wrapper that runs before upstream init.
- Wrapper now:
  - links runtime paths to persistent `/data` (`/database`, `/logs`, `/secrets`, `/certificates`)
  - imports HA `/ssl` certificate/key when `ssl=true`
  - writes `.hostname_marker` so upstream does not overwrite custom certs with self-signed `localhost` certs.

### Notes
This remains an **unofficial community add-on** for AliasVault.
For AliasVault core issues, report upstream:
https://github.com/aliasvault/aliasvault

## 0.1.1
### What’s changed

#### 🛡️ SSL fix (Home Assistant /ssl certs)
- Fixed a startup edge case where AliasVault could regenerate and serve a self-signed `localhost` certificate even when custom HA `/ssl` certs were configured.
- Add-on now writes `/certificates/ssl/.hostname_marker` when importing `/ssl` cert/key, preventing unintended upstream cert regeneration.

### Notes
This remains an **unofficial community add-on** for AliasVault.
For AliasVault core issues, report upstream:
https://github.com/aliasvault/aliasvault

## 0.1.0
### What’s changed

#### 🧩 Compatibility
- Updated add-on architecture metadata to target `amd64` and `aarch64`.

#### 🖼️ Documentation & presentation improvements
- README improved with screenshots and clearer project badges.
- Added dedicated add-on detail page: `aliasvault/README.md` for richer Home Assistant rendering.
- Developer docs (`aliasvault/DOCS.md`) refreshed and aligned with current release flow.

#### 🛠️ CI / release flow improvements
- Auto-bump/version flow stabilized and validated in practice.
- Release/tag sync checks hardened.
- Changelog handling improved with compact Home Assistant view + archive policy.

### Notes
This remains an **unofficial community add-on** for AliasVault.
For AliasVault core issues, report upstream:
https://github.com/aliasvault/aliasvault

Oudere wijzigingen: zie `aliasvault/CHANGELOG_ARCHIVE.md` en GitHub Releases.
