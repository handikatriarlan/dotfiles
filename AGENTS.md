# PROJECT KNOWLEDGE BASE

**Generated:** 2026-07-30
**Commit:** `27fb571b1`
**Branch:** `main`

## OVERVIEW

Fedora KDE dotfiles. Configs for Kitty, Zsh (Oh My Zsh), Starship prompt, KDE Plasma, GRUB, SDDM. Package manifests. Vendored themes and fonts.

## STRUCTURE

```
/
├── config/       # App configs (kitty, fastfetch, starship.toml)
├── fonts/        # JetBrains Mono Nerd Font TTF/OTF files (357M)
├── grub/         # GRUB themes (catppuccin)
├── home/         # $HOME configs: .zshrc + vendored zsh plugins
├── kde/          # KDE Plasma settings (kwin, shortcuts, applets)
├── packages/     # Package lists (dnf, flatpak, npm, cargo, vscode)
├── screenshots/  # Desktop screenshots
├── sddm/         # SDDM config + vendored themes
└── themes/       # Icon/cursor themes, color-schemes, plasma themes (1.2G)
```

## WHERE TO LOOK

| Task            | Location                        | Notes                                                         |
| --------------- | ------------------------------- | ------------------------------------------------------------- |
| Shell config    | `home/.zshrc`                   | Oh My Zsh, aliases, PATH, Starship init                       |
| Prompt config   | `config/starship.toml`          | Nord palette, tool modules                                    |
| Terminal config | `config/kitty/kitty.conf`       | Kitty terminal                                                |
| KDE settings    | `kde/`                          | kwinrc, kdeglobals, applets, shortcuts                        |
| Package restore | `packages/dnf.txt`              | `sudo dnf install $(cat packages/dnf.txt)`                    |
| SDDM login      | `sddm/sddm.conf`                | Display manager                                               |
| Zsh plugins     | `home/custom/plugins/`          | Vendored (zsh-autosuggestions, zsh-syntax-highlighting, etc.) |
| System info     | `config/fastfetch/config.jsonc` | Fastfetch display config                                      |

## CONVENTIONS

- **Manual install**: No bootstrap script. `cp -r config/* ~/.config/` per README.
- **No symlink automation**: No GNU Stow, chezmoi, or symlink scripts.
- **Vendored dependencies**: zsh plugins, SDDM themes, icon/cursor themes are full copies in the repo (not submodules or package refs).
- **Shell config**: `.zshrc` in `home/` (not repo root), must be manually copied to `~/.zshrc`.

## ANTI-PATTERNS

- **Large binary assets tracked**: themes/ (1.2G SVG icons), fonts/ (357M TTF/OTF), sddm/themes/ (163M). `.gitignore` only ignores `fonts/*.zip`.
- **No linter/formatter config**: No `.editorconfig`, `.shellcheckrc`, `.gitattributes`, or any linting rules at project root.
- **No CI/CD**: No `.github/workflows/`, no Makefile, no install scripts.
- **Redundant nested dirs**: `sddm/themes/themes/`, `fonts/fonts/`, `grub/themes/grub/` have double nesting.
- **VSCode extensions listed but no VSCode settings**: `packages/vscode-extensions.txt` exists, no `config/Code/User/settings.json`.
- **No `.gitconfig`**: Missing common dev dotfile.

## UNIQUE STYLES

- **WSL cross-env**: `.zshrc` PATH includes `/mnt/c/` WSL paths — dual-boot or migrated from WSL.
- **Podman commented out**: Docker aliases exist but commented out, with podman equivalents nearby.
- **Laravel aliases**: `art`, `arts`, `9000`, `gas`, `artm`, `artmfs`, `sail` — active PHP/Laravel dev.
- **Herd/PHP tools**: `herd-lite` and custom PHP configs in PATH.

## COMMANDS

```bash
# Restore all configs
cp -r config/* ~/.config/

# Restore home dotfiles
cp home/.zshrc ~/

# Install packages
sudo dnf install $(cat packages/dnf.txt)
```

## NOTES

- Repo is 1.8G+ on disk — mostly vendored theme/font SVGs and binaries.
- No automated install path. Full restore is manual multi-step: `config/` → `~/.config/`, `home/` → `~/`, plus package install, font install.
- zsh plugin tests exist but belong to upstream repos (zsh-autosuggestions RSpec, zsh-syntax-highlighting custom zsh tests).
