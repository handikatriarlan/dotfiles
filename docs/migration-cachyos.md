# Fedora 44 → CachyOS Migration Guide

Personal migration reference for dual-boot Fedora 44 KDE → CachyOS (Arch-based) on 326GB NVMe Btrfs, retaining Windows partition.

---

## Pre-Migration Checklist

Run all steps below on Fedora **before** wiping the system.

### Backup dotfiles

```bash
# Config dirs
cp -r ~/.config docs/backups/dotfiles/

# Shell configs
cp ~/.zshrc docs/backups/
cp ~/.gitconfig docs/backups/ 2>/dev/null
```

### Backup system configs

```bash
sudo mkdir -p docs/backups/etc
sudo cp -r /etc/nginx docs/backups/etc/
sudo cp -r /etc/php-fpm.d docs/backups/etc/
sudo cp -r /etc/valkey docs/backups/etc/ 2>/dev/null
sudo cp /etc/my.cnf* docs/backups/etc/ 2>/dev/null
sudo cp /etc/ssh/sshd_config docs/backups/etc/ 2>/dev/null
sudo cp /etc/hostname docs/backups/etc/
```

### Backup SSH and GPG keys

```bash
mkdir -p ~/migration-backup/{ssh,gnupg}
cp -r ~/.ssh/* ~/migration-backup/ssh/
cp -r ~/.gnupg/* ~/migration-backup/gnupg/
chmod 600 ~/migration-backup/ssh/*

# Export GPG private keys
gpg --export-secret-keys --armor > ~/migration-backup/gnupg/private-keys.asc

# Backup SSH authorized_keys if separate
cp ~/.ssh/authorized_keys ~/migration-backup/ssh/authorized_keys 2>/dev/null
```

### Export package lists

```bash
mkdir -p ~/migration-backup/packages

# dnf
dnf list installed > ~/migration-backup/packages/dnf.txt

# flatpak
flatpak list --app > ~/migration-backup/packages/flatpak.txt

# npm global
npm list -g --depth=0 > ~/migration-backup/packages/npm-global.txt

# Go binaries
ls ~/go/bin/ > ~/migration-backup/packages/go-bin.txt

# Cargo
cargo install --list > ~/migration-backup/packages/cargo.txt

# VSCode extensions
code --list-extensions > ~/migration-backup/packages/vscode-extensions.txt
```

### Database dump

```bash
# Requires MySQL root credentials
mysqldump -u root --all-databases > ~/migration-backup/all-dbs.sql
```

### Backup browser profiles

```bash
mkdir -p ~/migration-backup/browsers
cp -r ~/.mozilla ~/migration-backup/browsers/ 2>/dev/null
cp -r ~/.config/chromium ~/migration-backup/browsers/ 2>/dev/null
```

### List project repos

```bash
ls ~/Projects/ > ~/migration-backup/projects.txt
```

Copy `~/migration-backup/` to external media or separate partition.

---

## Installation Steps

### Write ISO to USB

```bash
# Identify USB device first with lsblk, then:
sudo dd if=CachyOS-*.iso of=/dev/sdX bs=4M status=progress && sync
```

- Download ISO from [cachyos.org](https://cachyos.org)
- Boot from USB, run the Calamares installer
- Select **Replace Fedora, keep Windows** (dual boot)
- Set hostname to same as current (check `/etc/hostname` in backup)
- Create user with same username
- Enable KDE Plasma 6 when prompted

---

## Post-Install Config Restore

### Clone dotfiles

```bash
sudo pacman -S git
git clone https://github.com/handikatriarlan/dotfiles.git ~/dotfiles
```

### Restore configs

```bash
cp -r ~/dotfiles/config/* ~/.config/
cp ~/dotfiles/home/.zshrc ~/
```

### Restore SSH keys

```bash
cp -r ~/migration-backup/ssh/* ~/.ssh/
chmod 600 ~/.ssh/*
chmod 700 ~/.ssh
```

### Restore GPG keys

```bash
gpg --import ~/migration-backup/gnupg/private-keys.asc
gpg --import ~/migration-backup/gnupg/public-keys.asc 2>/dev/null
```

### Restore SSH authorized_keys

```bash
cp ~/migration-backup/ssh/authorized_keys ~/.ssh/authorized_keys 2>/dev/null
```

---

## Package Install Sections

### AUR helper (yay)

```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd ..
```

### Core CLI

```bash
sudo pacman -S --needed base-devel git curl wget htop neofetch tree unzip zip
```

### Dev tools

```bash
sudo pacman -S --needed nodejs npm go rust php composer docker podman nginx mariadb valkey openssh cronie
```

Install Bun:

```bash
curl -fsSL https://bun.sh/install | bash
```

### KDE extras

```bash
sudo pacman -S --needed kde-applications plasma-wayland-protocols
```

### Media

```bash
sudo pacman -S --needed obs-studio ffmpeg vlc gimp
```

### Fonts (JetBrains Mono Nerd Font)

```bash
mkdir -p ~/.local/share/fonts
cp ~/dotfiles/fonts/*.ttf ~/.local/share/fonts/
cp ~/dotfiles/fonts/*.otf ~/.local/share/fonts/ 2>/dev/null
fc-cache -fv
```

---

## Flatpak Restore

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub app.zen_browser.zen com.discordapp.Discord \
  com.obsproject.Studio org.localsend.localsend_app org.telegram.desktop
```

---

## NPM Global Tools Restore

```bash
npm install -g @gitlawb/openclaude@0.11.0 @google/gemini-cli@0.41.2 \
  @nestjs/cli@11.0.16 9router@0.5.45 agent-browser@0.26.0 \
  better-sqlite3@12.6.2 codebase-memory-mcp@0.9.0 intelephense@1.16.5 \
  nodemon@3.1.14 outray@0.1.7 systray2@2.1.4 uipro-cli@2.2.3 vercel@50.13.2
```

---

## VSCode Extensions Restore

```bash
code --install-extension adityaputrapratama.sholat-reminder
code --install-extension cardinal90.multi-cursor-case-preserve
code --install-extension dbaeumer.vscode-eslint
code --install-extension devsense.phptools-vscode
code --install-extension eamodio.gitlens
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-close-tag
code --install-extension formulahendry.auto-rename-tag
code --install-extension github.codespaces
code --install-extension kisstkondoros.vscode-gutter-preview
code --install-extension laravel.vscode-laravel
code --install-extension pkief.material-icon-theme
code --install-extension smcpeak.default-keys-windows
code --install-extension steoates.autoimport
code --install-extension usernamehw.errorlens
code --install-extension wakatime.vscode-wakatime
```

---

## Go & Rust Tools Restore

```bash
# Go tools
go install github.com/geminicommit/geminicommit@latest
go install golang.org/x/tools/gopls@latest
go install honnef.co/go/tools/cmd/staticcheck@latest

# Rust/Cargo
cargo install eza
```

---

## Service Setup

Enable and start all services:

```bash
sudo systemctl enable --now nginx mariadb php-fpm valkey sshd cronie
```

---

## Nginx Config Restore

```bash
sudo cp docs/backups/etc/nginx-sites/* /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

If `sites-enabled` directory does not exist, create it first:

```bash
sudo mkdir -p /etc/nginx/sites-enabled
```

---

## PHP-FPM Config Restore

```bash
sudo cp docs/backups/etc/www.conf /etc/php-fpm.d/www.conf
sudo systemctl restart php-fpm
```

---

## MySQL Import

```bash
sudo mysql < ~/migration-backup/all-dbs.sql
```

Verify with:

```bash
sudo mysql -e "SHOW DATABASES;"
```

---

## CachyOS vs Fedora Command Equivalents

| Fedora | CachyOS (Arch) |
|--------|----------------|
| `dnf install` | `sudo pacman -S` |
| `dnf remove` | `sudo pacman -R` |
| `dnf update` | `sudo pacman -Syu` |
| `dnf search` | `pacman -Ss` |
| `dnf groupinstall` | `sudo pacman -S` (no groups) |
| `dnf autoremove` | `sudo pacman -Rns $(pacman -Qtdq)` |
| `dnf list installed` | `pacman -Q` |
| `sudo systemctl` | `sudo systemctl` (same) |
| SELinux | AppArmor / none (Arch) |
| `/etc/sysconfig/` | `/etc/default/` |
| `dnf provides` | `pacman -F` |
| `dnf history` | `/var/log/pacman.log` |
| `firewall-cmd` | `iptables` / `nftables` |

---

## Quick Reference (minimal commands after fresh install)

```bash
# Clone dotfiles + restore configs
sudo pacman -S git
git clone https://github.com/handikatriarlan/dotfiles.git ~/dotfiles
cp -r ~/dotfiles/config/* ~/.config/
cp ~/dotfiles/home/.zshrc ~/

# Full tool install
sudo pacman -S --needed base-devel git curl wget htop neofetch tree unzip zip \
  nodejs npm go rust php composer docker podman nginx mariadb valkey \
  openssh cronie kde-applications plasma-wayland-protocols obs-studio ffmpeg \
  vlc gimp

# Services
sudo systemctl enable --now nginx mariadb php-fpm valkey sshd cronie

# Flatpak apps
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub app.zen_browser.zen com.discordapp.Discord \
  com.obsproject.Studio org.localsend.localsend_app org.telegram.desktop

# Fonts
mkdir -p ~/.local/share/fonts
cp ~/dotfiles/fonts/*.ttf ~/.local/share/fonts/
fc-cache -fv
```
