# Changelog (archief)

Historische wijzigingen die niet meer in de Home Assistant changelog-weergave hoeven te staan.

## 0.1.5
### What’s changed

#### ⬆️ Upstream AliasVault update
- Updated bundled AliasVault image from `0.26.6` to `0.27.0` (automated via Renovate).
- Upstream release notes: https://github.com/aliasvault/aliasvault/releases/tag/v0.27.0

### Notes
This remains an **unofficial community Home Assistant add-on** for AliasVault.
For core AliasVault bugs/features, please use the upstream project:
https://github.com/aliasvault/aliasvault

Oudere wijzigingen: zie `aliasvault/CHANGELOG_ARCHIVE.md` en GitHub Releases.

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

## 0.1.3
### What’s changed

#### 🩹 Startup hotfix for mountpoint replacement
- Fixed init wrapper crash on some systems where `/database` is a busy mountpoint and cannot be removed/replaced with a symlink.
- Wrapper now detects mountpoints, skips symlink replacement safely, and seeds runtime data from `/data` when appropriate.

### Notes
This remains an **unofficial community add-on** for AliasVault.
For AliasVault core issues, report upstream:
https://github.com/aliasvault/aliasvault

Oudere wijzigingen: zie `aliasvault/CHANGELOG_ARCHIVE.md` en GitHub Releases.

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

## 0.0.9
- Automated upstream update: AliasVault image bumped to `ghcr.io/aliasvault/aliasvault:0.26.6`.
- Updated `peter-evans/create-pull-request` action to v8.
- Auto-bump flow now creates a PR for version/changelog updates instead of direct push to `main`.
- Auto-bump PR scope was limited to release-related files.
- Added manual workflow trigger (`workflow_dispatch`) for easier validation.

## 0.0.8
- Automated upstream update: AliasVault image bumped to `ghcr.io/aliasvault/aliasvault:0.26.5`.
- Workflow dependency refresh (`actions/checkout` to v6).

## 0.0.7
- Synced add-on version to `0.0.7` so Home Assistant store version matches GitHub release/tag.

## 0.0.6
- Pinned upstream AliasVault image tag in Dockerfile (`ghcr.io/aliasvault/aliasvault:0.26.4`).
- Added Renovate hint comment so upstream AliasVault version updates can be raised automatically.

## 0.0.5
- Fixed Home Assistant Web UI link to always open HTTPS on the mapped TLS port.
  - Changed `webui` from protocol-placeholder form to explicit `https://[HOST]:[PORT:443]`.

## 0.0.4
- Add-on metadata hardening:
  - Bumped version to `0.0.4`
  - Added `webui` metadata for easier access from Home Assistant UI
  - Reduced mounted paths to only required map (`ssl`)
- Persistence reliability improvements:
  - `ha-persist-finish.sh` now clears destination including hidden files before sync
- SSL option parsing robustness:
  - `ha-persist-init.sh` now parses `/data/options.json` using Python JSON parsing (with safe defaults)
- Added GitHub Actions CI workflow:
  - Shellcheck for shell scripts
  - JSON validation for `config.json`
  - YAML lint for issue templates
- Dockerfile improvement:
  - Introduced `UPSTREAM_IMAGE` build arg to support pinning upstream image tag/digest

## 0.0.3
- Added Home Assistant `/ssl` certificate support via add-on options:
  - `ssl` (enable/disable)
  - `certfile`
  - `keyfile`
- Add-on now loads user-provided cert/key from `/ssl` when enabled.

## 0.0.2
- Add-on store UI metadata improvements:
  - Set repository URL, documentation link, and issue tracker.
- Added a dedicated add-on changelog file.

## 0.0.1
- Initial public Home Assistant add-on release for AliasVault.
- Uses upstream AliasVault all-in-one image.
- Added Home Assistant icon/logo assets.
- Added persistent data sync hooks for HA runtime.

Project repository: https://github.com/SnyderNL/aliasvault-addon
Upstream AliasVault: https://github.com/aliasvault/aliasvault
