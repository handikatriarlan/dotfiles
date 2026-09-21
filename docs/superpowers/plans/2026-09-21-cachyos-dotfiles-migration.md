# CachyOS Dotfiles Migration & Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Migrate Fedora dotfiles to CachyOS (Arch-based), sync all active configurations, and prune heavy binary assets reducing repo size from ~1.8 GB to < 5 MB.

**Architecture:** Pure mirror architecture separating application configs (`config/`), shell & dev dotfiles (`home/`), desktop environment (`kde/`), display manager (`sddm/`), and native Arch package manifests (`packages/`), backed by a modular `install.sh` script.

**Tech Stack:** CachyOS (Arch Linux), KDE Plasma 6.7.5, Wayland, Zsh (Oh My Zsh via system packages), Starship, Kitty, Pacman/Paru, systemd-boot.

**Spec:** `docs/superpowers/specs/2026-09-21-cachyos-dotfiles-migration-design.md`

## Global Constraints

- Never delete or corrupt active system dotfiles in `$HOME`.
- Repository working tree size must be under 5 MB after bloat pruning.
- Retain all configuration files, active color schemes, and desktop wallpapers.
- Add `migration-backup/` to `.gitignore` to protect sensitive keys and multi-gigabyte SQL dumps.
- All package manifests must be sorted and formatted for pacman/paru consumption.

---

### Task 1: Security & Size Protection (.gitignore)

**Files:**
- Modify: `.gitignore`

- [ ] **Step 1: Update .gitignore**

Add sensitive backup files, SQL dumps, and keys to `.gitignore`:

```gitignore
# Migration and backup directories
migration-backup/
docs/backups/

# Sensitive credentials and keys
*.pem
*.key
*.asc
*.sql
*.backup

# Fonts archive
fonts/*.zip
```

- [ ] **Step 2: Verify git status ignores migration-backup**

Run: `git status -s`
Expected: `migration-backup/` does not appear as untracked.

- [ ] **Step 3: Commit**

```bash
git add .gitignore
git commit -m "chore: ignore migration-backup and sensitive dump files"
```

---

### Task 2: Delete Heavy Bloat & Unused Assets

**Files:**
- Move: `themes/color-schemes/*.colors` -> `kde/color-schemes/`
- Delete: `themes/`
- Delete: `fonts/`
- Delete: `grub/`
- Delete: `home/custom/`
- Delete: `sddm/themes/`

- [ ] **Step 1: Preserve lightweight color schemes**

Copy all `.colors` files from `themes/color-schemes/` to `kde/color-schemes/`:
```bash
mkdir -p kde/color-schemes
cp themes/color-schemes/*.colors kde/color-schemes/
```

- [ ] **Step 2: Remove heavy directories**

Run git remove on bloat directories:
```bash
git rm -rf themes/ fonts/ grub/ home/custom/ sddm/themes/
```

- [ ] **Step 3: Verify repository size reduction**

Run: `du -sh kde/color-schemes/`
Expected: ~16K

- [ ] **Step 4: Commit**

```bash
git add kde/color-schemes/
git commit -m "refactor: prune heavy assets (themes, fonts, grub, vendored omz plugins)"
```

---

### Task 3: Synchronize Shell & Git Configs (home/)

**Files:**
- Modify: `home/.zshrc`
- Create: `home/.gitconfig`

- [ ] **Step 1: Copy live .zshrc and .gitconfig**

Copy files from `$HOME`:
```bash
cp ~/.zshrc home/.zshrc
cp ~/.gitconfig home/.gitconfig
```

- [ ] **Step 2: Verify zsh syntax**

Run: `zsh -n home/.zshrc`
Expected: Exit code 0 (no syntax errors).

- [ ] **Step 3: Commit**

```bash
git add home/.zshrc home/.gitconfig
git commit -m "feat(home): sync CachyOS .zshrc and .gitconfig"
```

---

### Task 4: Synchronize App Configs (config/)

**Files:**
- Modify: `config/fastfetch/config.jsonc`
- Create: `config/btop/btop.conf`
- Create: `config/Code - OSS/User/settings.json`
- Create: `config/Cursor/User/settings.json`
- Verify: `config/kitty/kitty.conf`
- Verify: `config/starship.toml`

- [ ] **Step 1: Sync fastfetch, btop, and editor settings**

```bash
cp ~/.config/fastfetch/config.jsonc config/fastfetch/config.jsonc
mkdir -p config/btop
cp ~/.config/btop/btop.conf config/btop/btop.conf
mkdir -p "config/Code - OSS/User"
cp ~/.config/Code\ -\ OSS/User/settings.json "config/Code - OSS/User/settings.json"
mkdir -p "config/Cursor/User"
cp ~/.config/Cursor/User/settings.json "config/Cursor/User/settings.json"
```

- [ ] **Step 2: Verify JSON syntax**

```bash
python3 -c "import json; json.load(open('config/Code - OSS/User/settings.json'))"
```
Expected: Exit code 0.

- [ ] **Step 3: Commit**

```bash
git add config/
git commit -m "feat(config): sync fastfetch, btop, and code editor settings"
```

---

### Task 5: Synchronize KDE Plasma 6 & SDDM Configs (kde/, sddm/)

**Files:**
- Modify: `kde/kwinrc`
- Modify: `kde/kdeglobals`
- Modify: `kde/kglobalshortcutsrc`
- Modify: `kde/plasma-org.kde.plasma.desktop-appletsrc`
- Modify: `kde/plasmarc`
- Modify: `sddm/sddm.conf`

- [ ] **Step 1: Copy live KDE Plasma 6 and SDDM configs**

```bash
cp ~/.config/kwinrc kde/kwinrc
cp ~/.config/kdeglobals kde/kdeglobals
cp ~/.config/kglobalshortcutsrc kde/kglobalshortcutsrc
cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc kde/plasma-org.kde.plasma.desktop-appletsrc
cp ~/.config/plasmarc kde/plasmarc
cp /etc/sddm.conf sddm/sddm.conf
```

- [ ] **Step 2: Verify KDE config contents**

Run: `grep "Current=" sddm/sddm.conf`
Expected: `Current=catppuccin-macchiato-mauve`

- [ ] **Step 3: Commit**

```bash
git add kde/ sddm/
git commit -m "feat(kde,sddm): sync KDE Plasma 6 and SDDM configs"
```

---

### Task 6: Generate CachyOS Package Manifests (packages/)

**Files:**
- Create: `packages/pacman.txt`
- Create: `packages/aur.txt`
- Modify: `packages/npm-global.txt`
- Modify: `packages/vscode-extensions.txt`
- Delete: `packages/dnf.txt`
- Delete: `packages/all-rpm.txt`
- Delete: `packages/flatpak.txt`
- Delete: `packages/cargo.txt`
- Delete: `packages/go-packages.txt`

- [ ] **Step 1: Export pacman and AUR packages**

```bash
pacman -Qne | awk '{print $1}' | sort > packages/pacman.txt
{ pacman -Qme | awk '{print $1}'; echo "kora-icon-theme"; } | sort -u > packages/aur.txt
npm list -g --depth=0 --parseable 2>/dev/null | tail -n +2 | xargs -n1 basename | sort > packages/npm-global.txt
code --list-extensions | sort > packages/vscode-extensions.txt
```

- [ ] **Step 2: Remove Fedora package files**

```bash
git rm -f packages/dnf.txt packages/all-rpm.txt packages/flatpak.txt packages/cargo.txt packages/go-packages.txt
```

- [ ] **Step 3: Verify package count**

Run: `wc -l packages/pacman.txt packages/aur.txt`
Expected: ~236 pacman packages, ~6 AUR packages.

- [ ] **Step 4: Commit**

```bash
git add packages/
git commit -m "feat(packages): replace Fedora RPMs with CachyOS pacman & AUR manifests"
```

---

### Task 7: Create Bootstrap Installation Script (install.sh)

**Files:**
- Create: `install.sh`

- [ ] **Step 1: Write install.sh**

Create modular script supporting automated and interactive deployment of configs and packages.

- [ ] **Step 2: Make executable and verify syntax**

Run: `chmod +x install.sh && bash -n install.sh`
Expected: Exit code 0.

- [ ] **Step 3: Commit**

```bash
git add install.sh
git commit -m "feat: add modular CachyOS dotfiles install.sh script"
```

---

### Task 8: Update Documentation & AI Knowledge Base (README.md, AGENTS.md)

**Files:**
- Modify: `README.md`
- Modify: `AGENTS.md`

- [ ] **Step 1: Update README.md**

Document CachyOS setup, new folder structure, and restore instructions.

- [ ] **Step 2: Update AGENTS.md**

Update codebase conventions, commands, and rules for future AI coding sessions.

- [ ] **Step 3: Final verification of repository size & status**

Run: `du -sh . && git status`
Expected: Repo working tree size < 5 MB, working directory clean.

- [ ] **Step 4: Commit**

```bash
git add README.md AGENTS.md
git commit -m "docs: update README and AGENTS.md for CachyOS"
```
