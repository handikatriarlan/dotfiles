<p align="center">
  <img src="./screenshots/desktop.png" width="100%" />
</p>

<h1 align="center">CachyOS KDE Plasma 6 Dotfiles</h1>

<p align="center">
  Personal, lightweight CachyOS (Arch-based) setup powered by KDE Plasma 6, Wayland, Kitty, Zsh, Starship prompt, and Catppuccin Macchiato.
</p>

## Overview

A clean, modern dotfiles repository configured for **CachyOS Linux**. Designed to be lightweight (< 5 MB), fast to clone, and easy to maintain without gigabytes of vendored binary assets or duplicate font files.

## Environment

* **OS:** CachyOS Linux (Arch-based, rolling)
* **Desktop Environment:** KDE Plasma 6.7.5 (Wayland)
* **Terminal:** Kitty
* **Shell:** Zsh (Oh My Zsh with system plugins)
* **Prompt:** Starship (Nord/Catppuccin palette)
* **Bootloader:** systemd-boot
* **Editor:** Cursor / Code - OSS
* **Font:** JetBrains Mono Nerd Font (`ttf-jetbrains-mono-nerd`) & BearSansUI
* **Theme:** Catppuccin Macchiato Mauve + Kora Icons (`kora-icon-theme`)

## Repository Structure

```text
.
├── config/              # Application configs (mirrors ~/.config/)
│   ├── btop/            # Resource monitor config
│   ├── Code - OSS/      # VSCode OSS editor settings
│   ├── Cursor/          # Cursor AI editor settings
│   ├── fastfetch/       # Fastfetch system info layout (CachyOS)
│   ├── kitty/           # Kitty terminal emulator config
│   └── starship.toml    # Shell prompt theme
├── home/                # User home root dotfiles
│   ├── .zshrc           # Zsh configuration (system plugins, pacman aliases)
│   └── .gitconfig       # Git configuration (delta pager, GPG signing)
├── kde/                 # KDE Plasma 6 configuration & assets
│   ├── kdeglobals       # Global KDE theme and appearance
│   ├── kglobalshortcutsrc # Global keyboard shortcuts
│   ├── kwinrc           # KWin window manager settings
│   ├── plasma-org.kde.plasma.desktop-appletsrc # Desktop panels & widgets
│   ├── plasmarc         # Plasma shell state
│   ├── color-schemes/   # Lightweight color schemes (Catppuccin, Dracula, etc.)
│   └── wallpapers/      # Desktop wallpapers (Dark & Light)
├── packages/            # Package manifests for quick replication
│   ├── pacman.txt       # Native Arch/CachyOS explicit packages (pacman -Qne)
│   ├── aur.txt          # Foreign/AUR packages (kora-icon-theme, beekeeper, etc.)
│   ├── npm-global.txt   # Global Node.js tools
│   └── vscode-extensions.txt # VSCode / Cursor extensions
├── sddm/                # SDDM display manager configuration
│   └── sddm.conf        # SDDM theme pointer
├── install.sh           # Modular restoration and setup script
└── screenshots/         # Desktop screenshots
```

## Quick Installation & Restoration

Clone the repository:

```bash
git clone https://github.com/handikatriarlan/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Option 1: Automated Assistant (Recommended)

Run the included `install.sh` script:

```bash
# Interactive menu
./install.sh

# Or restore specific components directly:
./install.sh configs   # Restores configs to ~/.config, ~/, and ~/.local/share/
./install.sh pacman    # Installs all native pacman packages
./install.sh aur       # Installs all AUR packages (via paru or yay)
./install.sh npm       # Installs global npm packages
./install.sh code      # Installs code editor extensions
./install.sh all       # Runs all restoration tasks
```

### Option 2: Manual Setup

```bash
# 1. Restore app configs
cp -r config/* ~/.config/

# 2. Restore shell and git configs
cp home/.zshrc ~/
cp home/.gitconfig ~/

# 3. Restore KDE Plasma configs and assets
mkdir -p ~/.local/share/wallpapers ~/.local/share/color-schemes
cp -r kde/wallpapers/* ~/.local/share/wallpapers/
cp -r kde/color-schemes/* ~/.local/share/color-schemes/
cp kde/kde* kde/kwinrc kde/plasma* kde/plasmarc ~/.config/

# 4. Install native packages
sudo pacman -S --needed - < packages/pacman.txt

# 5. Install AUR packages (via paru or yay)
paru -S --needed - < packages/aur.txt
```

## Notes

- **No Heavy Bloat:** Third-party icon packs (Papirus, WhiteSur, Tela) and raw font binaries (JetBrains Mono TTFs) are removed in favor of official package manager packages (`pacman` and `paru`).
- **Sensitive Data:** Private keys and database dumps are protected via `.gitignore` and never committed.
