# Design Specification: Dotfiles Migration to CachyOS (Arch-based) & Repository Optimization

- **Date:** 2026-09-21
- **Status:** Approved
- **Target Environment:** CachyOS (Linux 6.x, KDE Plasma 6.7.5, Wayland, zsh)

---

## 1. Context & Motivation

The dotfiles repository was originally configured for Fedora KDE and accumulated significant bloat (~1.8 GB on disk with ~265,000 files in git index). The bloat consists of:
- `themes/` (1.2 GB, ~265,000 files): massive uncompressed SVG icon packs (Papirus, Tela, WhiteSur, McMojave-circle, kora).
- `fonts/` (234 MB): full set of raw JetBrains Mono Nerd Font TTF files.
- `grub/` (21 MB): GRUB Catppuccin themes.
- `sddm/themes/01-breeze-fedora` (1.3 MB): obsolete Fedora-specific theme.
- `home/custom/` (4.8 MB): vendored Oh My Zsh plugins and themes.
- `migration-backup/` (3.0 GB, untracked): contains SQL database dumps and sensitive keys.

The user has now fully migrated their operating system to **CachyOS (Arch Linux-based)** with KDE Plasma 6 on Wayland and `systemd-boot`. The goal is to:
1. Prune all unused binary bloat and vendor assets, reducing repository size from ~1.8 GB to < 5 MB (>99.7% reduction).
2. Modernize the repository structure to cleanly mirror `$HOME` and `~/.config/`.
3. Synchronize all configurations from the live CachyOS system (shell, git, fastfetch, kitty, starship, btop, code editors, and KDE Plasma 6).
4. Replace Fedora package manifests (`dnf.txt`, `all-rpm.txt`) with native Arch/CachyOS package lists (`pacman.txt`, `aur.txt`, `npm-global.txt`, `vscode-extensions.txt`).
5. Add an intuitive `install.sh` bootstrap script and update documentation.

---

## 2. Target Directory Structure

```
dotfiles/
├── config/                      # Mirror of ~/.config/ (app text configs only)
│   ├── btop/
│   │   └── btop.conf
│   ├── Code - OSS/
│   │   └── User/
│   │       └── settings.json
│   ├── Cursor/
│   │   └── User/
│   │       └── settings.json
│   ├── fastfetch/
│   │   └── config.jsonc
│   ├── kitty/
│   │   └── kitty.conf
│   └── starship.toml
├── home/                        # Mirror of $HOME root configs
│   ├── .zshrc                   # CachyOS zshrc (system OMZ plugins, pacman aliases, etc.)
│   └── .gitconfig               # Active gitconfig (gpg sign, delta pager)
├── kde/                         # KDE Plasma 6 configs & visual assets
│   ├── kdeglobals
│   ├── kglobalshortcutsrc
│   ├── kwinrc
│   ├── plasma-org.kde.plasma.desktop-appletsrc
│   ├── plasmarc
│   ├── color-schemes/           # *.colors (CatppuccinMacchiatoMauve, Dracula, etc. - 16KB)
│   └── wallpapers/              # Wallpaper/Dark.png, Light.png (2.8MB)
├── sddm/                        # Display manager config
│   └── sddm.conf                # SDDM config (Current=catppuccin-macchiato-mauve)
├── packages/                    # CachyOS package manifests
│   ├── pacman.txt               # Explicit native packages (pacman -Qne)
│   ├── aur.txt                  # Explicit foreign/AUR packages (pacman -Qme + kora-icon-theme)
│   ├── npm-global.txt           # Active npm global packages
│   └── vscode-extensions.txt    # Active VSCode / Cursor extensions
├── install.sh                   # Modular, interactive restoration script
├── .gitignore                   # Protects against migration-backup/, keys, dumps
├── README.md                    # Updated guide for CachyOS restoration & structure
└── AGENTS.md                    # Updated knowledge base for AI coding agents
```

---

## 3. Detailed Component Plan

### 3.1 Cleanup of Heavy Bloat
- **`themes/` removal**: Delete raw icon directories (`Papirus*`, `Tela*`, `WhiteSur*`, `McMojave-circle*`, `kora*`, `Catppuccin-*-Cursors`, `hicolor`).
  - Move lightweight `.colors` files to `kde/color-schemes/`.
  - Move active wallpapers (`Dark.png`, `Light.png`) to `kde/wallpapers/Wallpaper/`.
  - Icon theme `kora-icon-theme` is added to `packages/aur.txt`.
- **`fonts/` removal**: Delete 234 MB of raw TTF files. Font is installed via `ttf-jetbrains-mono-nerd` in `packages/pacman.txt`.
- **`grub/` removal**: Delete 21 MB GRUB themes. CachyOS boots via `systemd-boot`.
- **`home/custom/` removal**: Delete vendored OMZ plugins. CachyOS uses system-provided plugins at `/usr/share/zsh/plugins/`.
- **`sddm/themes/` cleanup**: Delete Fedora breeze themes.
- **`.gitignore` update**: Add `migration-backup/`, `*.sql`, `*.asc`, `*.key`, `*.pem`, `*.backup` to prevent any accidental leakage or bloat.

### 3.2 Configuration Synchronization
- **`home/.zshrc`**: Copy directly from live `~/.zshrc`.
  - Includes OMZ with system plugins (`zsh-syntax-highlighting`, `zsh-autosuggestions`, `zsh-history-substring-search`, `command-not-found`).
  - Includes CachyOS pacman aliases (`update`, `rmpkg`, `cleanch`, `fixpacman`, `cleanup`, `rip`).
  - Includes PATH for Bun, NVM, Composer, local binaries.
  - Includes Laravel and dev aliases.
- **`home/.gitconfig`**: Copy directly from live `~/.gitconfig`.
  - Name, email, GPG signing configuration, delta pager, conflict style.
- **`config/fastfetch/config.jsonc`**: Copy from `~/.config/fastfetch/config.jsonc`.
  - Uses `CachyOS_small` logo, date format module, cleaned layout.
- **`config/kitty/kitty.conf`**: Verified matching live system.
- **`config/starship.toml`**: Verified matching live system.
- **`config/Code - OSS/User/settings.json`**: Copy from live `~/.config/Code - OSS/User/settings.json`.
- **`config/Cursor/User/settings.json`**: Copy from live `~/.config/Cursor/User/settings.json`.
- **`config/btop/btop.conf`**: Copy from live `~/.config/btop/btop.conf`.
- **`kde/`**: Copy live configs from `~/.config/`:
  - `kwinrc`: Window manager rules, kzones, rounded corners.
  - `kdeglobals`: Color scheme Catppuccin, icon theme kora, font settings.
  - `kglobalshortcutsrc`: Active Plasma 6 shortcut definitions.
  - `plasma-org.kde.plasma.desktop-appletsrc`: Panel widgets, system tray, desktop wallpaper links.
  - `plasmarc`: Plasma shell settings.
- **`sddm/sddm.conf`**: Copy from `/etc/sddm.conf` (`Current=catppuccin-macchiato-mauve`).

### 3.3 Package Manifests
Generate clean, sorted lists directly from package managers:
- `packages/pacman.txt`: Generated with `pacman -Qne | awk '{print $1}' | sort`.
- `packages/aur.txt`: Generated with `pacman -Qme | awk '{print $1}' | sort` + `kora-icon-theme`.
- `packages/npm-global.txt`: Generated with `npm list -g --depth=0`.
- `packages/vscode-extensions.txt`: Generated with `code --list-extensions | sort`.
- Old Fedora manifests (`dnf.txt`, `all-rpm.txt`, `flatpak.txt`, `cargo.txt`, `go-packages.txt`) are deleted.

### 3.4 Installation Script (`install.sh`)
Create an interactive, POSIX-compatible bash script that allows:
1. `install.sh configs`: Restores configs to `~/.config/`, `~/.zshrc`, `~/.gitconfig`, `~/.local/share/wallpapers/`, `~/.local/share/color-schemes/`.
2. `install.sh packages`: Installs native packages using `sudo pacman -S --needed - < packages/pacman.txt`.
3. `install.sh aur`: Installs AUR packages using `paru -S --needed - < packages/aur.txt` (or `yay`).
4. Interactive menu if run without arguments.

### 3.5 Documentation Updates
- Update `README.md` with:
  - System specs (CachyOS, KDE Plasma 6, Wayland, zsh).
  - Quick install & restore instructions.
  - Repository structure explanation.
- Update `AGENTS.md` with:
  - New overview, conventions, commands, and file paths.

---

## 4. Verification Strategy
1. **Size verification**: Run `du -sh .` and `du -sh *` to confirm repository size is < 5 MB.
2. **Git status & index verification**: Ensure no unintended files or untracked sensitive files remain.
3. **Syntax / Config verification**:
   - Verify `zsh -n home/.zshrc` passes syntax checking.
   - Verify JSON / JSONC syntax for `fastfetch` and editor `settings.json`.
   - Verify `.gitignore` rules correctly ignore `migration-backup/`.
4. **Package manifests verification**: Ensure package names are valid and match system installations.
