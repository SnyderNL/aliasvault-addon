## 🚀 Highlights

This release focuses on reliability improvements and project maintainability for the Home Assistant AliasVault add-on.

### Added
- `webui` metadata in add-on config for easier access from Home Assistant UI.
- Initial CI workflow (`.github/workflows/ci.yml`) with:
  - Shell script linting (shellcheck)
  - JSON validation for add-on config
  - YAML linting for issue templates

### Changed
- Version bumped to **0.0.4**
- Add-on mount map reduced to only required path (`ssl`) for a tighter scope.
- Persistence sync improved:
  - `ha-persist-finish.sh` now clears destination including hidden files before syncing.
- SSL options parsing hardened:
  - `ha-persist-init.sh` now parses `/data/options.json` via Python JSON parsing with safe defaults.
- Dockerfile now supports easier upstream image pinning via `UPSTREAM_IMAGE` build argument.

### Documentation / Maintainer UX
- Added/updated project docs and contribution flow:
  - README improvements
  - `KNOWN_ISSUES.md`
  - `ROADMAP.md`
  - `CONTRIBUTING.md`
  - GitHub issue templates

## ✅ Validation
Tested with clean install and startup in Home Assistant test environment.  
Observed expected startup behavior and successful service readiness.

## ⚠️ Notes
This remains an **unofficial community add-on** for AliasVault.  
For AliasVault core issues, please use the upstream project:
https://github.com/aliasvault/aliasvault
