# PROJECT KNOWLEDGE BASE

**Updated:** 2026-09-21
**OS:** CachyOS Linux (Arch-based, rolling)
**Branch:** `cachyos-migration`

## OVERVIEW

CachyOS KDE Plasma 6 dotfiles. Lightweight (< 5 MB), modern, and modular. Configs for Kitty, Zsh (Oh My Zsh via pacman system packages), Starship prompt, KDE Plasma 6 Wayland, SDDM, Cursor / Code - OSS, btop, and fastfetch. Package manifests for pacman, AUR, npm, and VSCode/Cursor extensions.

## STRUCTURE

```
/
├── config/       # App configs (kitty, fastfetch, starship.toml, btop, Code - OSS, Cursor)
├── home/         # $HOME configs (.zshrc, .gitconfig)
├── kde/          # KDE Plasma 6 configs (kwinrc, kdeglobals, shortcuts, applets, color-schemes, wallpapers)
├── packages/     # Package manifests (pacman.txt, aur.txt, npm-global.txt, vscode-extensions.txt)
├── sddm/         # SDDM config (sddm.conf)
├── screenshots/  # Desktop screenshots
├── install.sh    # Modular bootstrap / restore script
└── docs/         # Specifications and migration documentation
```

## WHERE TO LOOK

| Task            | Location                        | Notes                                                          |
| --------------- | ------------------------------- | -------------------------------------------------------------- |
| Shell config    | `home/.zshrc`                   | Oh My Zsh via `/usr/share/oh-my-zsh`, pacman aliases, Starship |
| Git config      | `home/.gitconfig`               | GPG signing, Delta pager, credential helper                    |
| Prompt config   | `config/starship.toml`          | Starship prompt configuration                                  |
| Terminal config | `config/kitty/kitty.conf`       | Kitty terminal settings                                        |
| System info     | `config/fastfetch/config.jsonc` | Fastfetch CachyOS layout                                       |
| Resource info   | `config/btop/btop.conf`         | btop system monitor config                                     |
| Editor settings | `config/Code - OSS/`, `Cursor/` | VSCode & Cursor `settings.json`                                |
| KDE settings    | `kde/`                          | kwinrc, kdeglobals, applets, shortcuts, color schemes          |
| SDDM login      | `sddm/sddm.conf`                | Display manager (Catppuccin Macchiato Mauve)                   |
| Package restore | `packages/pacman.txt`           | `sudo pacman -S --needed - < packages/pacman.txt`              |
| AUR restore     | `packages/aur.txt`              | `paru -S --needed - < packages/aur.txt`                        |
| Bootstrap       | `install.sh`                    | Interactive / CLI restore assistant                            |

## CONVENTIONS

- **Pure Configs**: Never track large binary assets (> 1 MB) such as full icon packs, font archives, or database dumps in git.
- **Package Manager First**: Install fonts (`ttf-jetbrains-mono-nerd`) and icon themes (`kora-icon-theme`) via `pacman` or `paru`, not vendored git copies.
- **System Zsh Plugins**: Zsh plugins are managed by pacman and loaded from `/usr/share/zsh/plugins/`.
- **Mirroring Structure**: `config/` mirrors `~/.config/`, `home/` mirrors `$HOME/`.

## COMMANDS

```bash
# Automated assistant
./install.sh

# Restore all configs manually
cp -r config/* ~/.config/
cp home/.zshrc home/.gitconfig ~/
cp -r kde/wallpapers/* ~/.local/share/wallpapers/
cp -r kde/color-schemes/* ~/.local/share/color-schemes/
cp kde/k* kde/plasma* ~/.config/

# Install packages
sudo pacman -S --needed - < packages/pacman.txt
paru -S --needed - < packages/aur.txt
```
