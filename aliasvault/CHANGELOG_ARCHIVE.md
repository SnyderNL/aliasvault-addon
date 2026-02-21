# Changelog (archief)

Historische wijzigingen die niet meer in de Home Assistant changelog-weergave hoeven te staan.

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
