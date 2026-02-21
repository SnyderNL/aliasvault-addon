# Changelog

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

## 0.0.9
### What’s changed

#### ⬆️ Dependency updates
- Automated upstream update: AliasVault image bumped to `ghcr.io/aliasvault/aliasvault:0.26.6`.
- Updated `peter-evans/create-pull-request` action to v8.

#### 🛠️ CI / release flow improvements
- Auto-bump flow now creates a PR for version/changelog updates instead of direct push to `main`.
- Auto-bump PR scope was limited to release-related files.
- Added manual workflow trigger (`workflow_dispatch`) for easier validation.

### Notes
This remains an **unofficial community add-on** for AliasVault.
For AliasVault core issues, report upstream:
https://github.com/aliasvault/aliasvault

Oudere wijzigingen: zie `aliasvault/CHANGELOG_ARCHIVE.md` en GitHub Releases.
