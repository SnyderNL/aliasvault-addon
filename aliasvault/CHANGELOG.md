# Changelog

## 0.1.3
### What’s changed

#### 🩹 Startup hotfix for mountpoint replacement
- Fixed init wrapper crash on some systems where `/database` is a busy mountpoint and cannot be removed/replaced with a symlink.
- Wrapper now detects mountpoints, skips symlink replacement safely, and seeds runtime data from `/data` when appropriate.

### Notes
This remains an **unofficial community add-on** for AliasVault.
For AliasVault core issues, report upstream:
https://github.com/aliasvault/aliasvault

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

Oudere wijzigingen: zie `aliasvault/CHANGELOG_ARCHIVE.md` en GitHub Releases.
