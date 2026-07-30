# Fedora → CachyOS Migration Preparation Plan

> **TL;DR**: Create migration docs, update package manifests, backup system configs, and set up .gitignore for sensitive files. All data already gathered from live system.

**Goal**: Produce complete migration kit in the dotfiles repo so user can reinstall to CachyOS and restore full environment.

**Architecture**: One-shot file creation + backups. No code changes. All data collected from Fedora 44 system: package lists, running services, nginx configs, PHP-FPM config, valkey, systemd units, 28 dev projects.

**Tech Stack**: Fedora 44 KDE Plasma 6 → CachyOS (Arch-based). Source data: dnf (525 user pkgs), flatpak (5 apps), npm (15 pkgs), go (3 bins), vscode (16 exts).

## System State Reference (collected)

```
OS: Fedora 44 KDE Plasma 6
Disk: 326GB NVMe Btrfs — 169G used / 154G free (dual boot with Windows)
Services: nginx, mysqld (9.7), php-fpm (8.5), valkey (9.0), sshd, sddm
PHP: 8.5.9 (system) + 8.0.99 (remi via php80-*)
Node: v25.5.0 (nvm) | Bun: 1.3.14 | Go: 1.25 | Rust: 1.97
Flatpak: Zen Browser, OBS + DroidCam, LocalSend, Telegram, Discord
Nginx: 8 site configs (digasss.dep, emeterai.dep, foto-studio, handikatriarlan.outray.app, etc.)
Projects: 28 dirs in ~/Projects/
SSH: keys exist in ~/.ssh/
```

## Scope

**IN**: Migration guide doc, package manifest updates, config inventory, sensitive file management, system config backup

**OUT**: MySQL dump (user handles), dev project backup (user handles), actual CachyOS installation (user handles after prep)

---

## Execution Waves

```
Wave 1 (Parallel — all file creation):
├── T1: Migration guide — docs/migration-cachyos.md
├── T2: Package manifests — flatpak, npm, go, cargo, vscode
├── T3: .gitignore update + sensitive-files.md
├── T4: Config inventory — docs/config-inventory.md
└── T5: System config backups — nginx, php-fpm, valkey, mysql

Wave FINAL:
├── F1: Verify all files exist and are non-empty
└── F2: Commit to repo
```

---

## TODOs

- [x] 1. Create migration guide

  **What to do**: Write `docs/migration-cachyos.md` with complete migration steps.

  Content includes:
  - Pre-migration checklist (backup dotfiles, /etc/, ssh/gpg, export packages, mysql dump)
  - Installation steps (create USB, install CachyOS replacing Fedora, keep Windows)
  - Post-install config restore (clone dotfiles, cp configs, restore SSH/GPG)
  - Package install sections (core CLI, dev tools, KDE extras, media, fonts)
  - Flatpak restore with `flatpak install -y flathub <pkg>`
  - NPM global tools restore
  - VSCode extensions restore
  - Go tools reinstall
  - Service setup (nginx, mariadb, php-fpm, valkey, sshd, cronie)
  - Nginx config restore from backup
  - PHP-FPM config restore
  - MySQL import
  - CachyOS vs Fedora command equivalents table
  - Quick reference: minimal commands after fresh install

  **Must NOT do**: Include actual sensitive data (ssh keys, tokens, passwords). Reference backup files, don't embed them.

  **Files**:
  - Create: `docs/migration-cachyos.md`

  **QA**:
  ```
  Scenario: All sections present
    Tool: Bash (wc + grep)
    Steps:
      1. wc -l docs/migration-cachyos.md → should be 200+
      2. grep -c "Pre-Migration Checklist" docs/migration-cachyos.md → should be 1
      3. grep -c "Post-Install" docs/migration-cachyos.md → should be 1
      4. grep -c "Step" docs/migration-cachyos.md → should be 10+
    Evidence: .sisyphus/evidence/task-1-sections.txt
  ```

  **Commit**: YES
  - Message: `docs: add CachyOS migration guide`
  - Files: `docs/migration-cachyos.md`

- [x] 2. Update package manifests

  **What to do**: Create/update package manifest files in `packages/` based on current system state.

  **Files to create/update**:

  `packages/flatpak.txt` (new):
  ```
  app.zen_browser.zen
  com.discordapp.Discord
  com.obsproject.Studio
  org.localsend.localsend_app
  org.telegram.desktop
  ```

  `packages/npm-global.txt` (update — current versions):
  - Update to reflect: `@gitlawb/openclaude@0.11.0`, `@google/gemini-cli@0.41.2`, `@nestjs/cli@11.0.16`, `9router@0.5.45`, `agent-browser@0.26.0`, `better-sqlite3@12.6.2`, `codebase-memory-mcp@0.9.0`, `intelephense@1.16.5`, `nodemon@3.1.14`, `outray@0.1.7`, `systray2@2.1.4`, `uipro-cli@2.2.3`, `vercel@50.13.2`
  - Use `npm list -g --depth=0` format (just package@version per line after header)

  `packages/go-packages.txt` (new):
  ```
  geminicommit
  gopls
  staticcheck
  ```

  `packages/cargo.txt` (new):
  ```
  eza
  ```

  `packages/vscode-extensions.txt` (update — current extensions from `code --list-extensions`):
  ```
  adityaputrapratama.sholat-reminder
  cardinal90.multi-cursor-case-preserve
  dbaeumer.vscode-eslint
  devsense.phptools-vscode
  eamodio.gitlens
  esbenp.prettier-vscode
  formulahendry.auto-close-tag
  formulahendry.auto-rename-tag
  github.codespaces
  kisstkondoros.vscode-gutter-preview
  laravel.vscode-laravel
  pkief.material-icon-theme
  smcpeak.default-keys-windows
  steoates.autoimport
  usernamehw.errorlens
  wakatime.vscode-wakatime
  ```

  **QA**:
  ```
  Scenario: All manifest files exist with content
    Tool: Bash
    Steps:
      1. test -s packages/flatpak.txt && echo "OK"
      2. test -s packages/go-packages.txt && echo "OK"
      3. test -s packages/cargo.txt && echo "OK"
      4. test -s packages/npm-global.txt && echo "OK"
      5. test -s packages/vscode-extensions.txt && echo "OK"
    Expected: All 5 return OK
    Evidence: .sisyphus/evidence/task-2-manifests.txt
  ```

  **Commit**: NO (groups with T1)

- [x] 3. Update .gitignore + create sensitive-files.md

  **What to do**:
  - Append to `.gitignore`:
  ```
  # Sensitive files — see docs/sensitive-files.md for backup instructions
  docs/backups/
  *.pem
  *.key
  ```
  - Create `docs/sensitive-files.md` explaining what NOT to commit and how to backup:
    - SSH keys (~/.ssh/*) — backup manually, NEVER commit
    - GPG keys (~/.gnupg/*) — backup manually
    - Git credentials (~/.git-credentials)
    - Shell history (~/.zsh_history, ~/.bash_history)
    - Database exports
    - .env files, tokens
    - Command to backup: `mkdir -p ~/migration-backup/{ssh,gnupg} && cp -r ~/.ssh/* ~/migration-backup/ssh/ && cp -r ~/.gnupg/* ~/migration-backup/gnupg/`
  - Keep existing `.gitignore` content (`fonts/*.zip`)

  **QA**:
  ```
  Scenario: gitignore updated
    Tool: Bash
    Steps:
      1. grep "docs/backups/" .gitignore → should match
      2. test -s docs/sensitive-files.md → should exist
    Evidence: .sisyphus/evidence/task-3-gitignore.txt
  ```

  **Commit**: NO (groups with T1)

- [x] 4. Create config inventory

  **What to do**: Write `docs/config-inventory.md` documenting system service configs that need manual backup.

  Content:
  - Nginx: `/etc/nginx/sites-enabled/` — 8 site configs (digasss.dep, emeterai.dep, foto-studio, handikatriarlan.outray.app, pakaiapp.dep, sistem-administrasi-desa, default, php-fpm)
  - PHP-FPM: `/etc/php-fpm.d/www.conf` — PHP 8.5 pool (also check if php80-fpm exists)
  - MySQL: `/etc/my.cnf`, `/etc/my.cnf.d/`
  - Valkey: `/etc/valkey/`
  - Systemd services to enable on new system: nginx, mysqld, php-fpm, valkey, sshd, cronie
  - List all project domains found in nginx configs

  **QA**:
  ```
  Scenario: Config inventory exists
    Tool: Bash
    Steps:
      1. test -s docs/config-inventory.md
      2. grep -c "nginx\|php-fpm\|mysql\|valkey" docs/config-inventory.md → should be 4+
    Evidence: .sisyphus/evidence/task-4-inventory.txt
  ```

  **Commit**: NO (groups with T1)

- [x] 5. Backup system configs

  **What to do**: Copy system configuration files to `docs/backups/etc/`.

  ```bash
  mkdir -p docs/backups/etc
  sudo cp -r /etc/nginx/sites-enabled/ docs/backups/etc/nginx-sites/ 2>/dev/null || echo "no nginx"
  sudo cp -r /etc/nginx/conf.d/ docs/backups/etc/nginx-conf.d/ 2>/dev/null || echo "no nginx conf"
  sudo cp /etc/php-fpm.d/www.conf docs/backups/etc/ 2>/dev/null || echo "no php-fpm"
  sudo cp -r /etc/valkey/ docs/backups/etc/valkey/ 2>/dev/null || echo "no valkey"
  sudo cp -r /etc/my.cnf.d/ docs/backups/etc/my.cnf.d/ 2>/dev/null || echo "no mysql cnf"
  sudo cp /etc/my.cnf docs/backups/etc/ 2>/dev/null || echo "no my.cnf"
  sudo chown -R $USER:$USER docs/backups/
  ```

  Also run:
  ```bash
  systemctl list-units --type=service --state=running --no-pager --no-legend | awk '{print $1}' > docs/backups/running-services.txt
  cat > docs/backups/projects.txt << 'EOF'
  # Dev projects in ~/Projects/ (28 total)
  # User handles backup — reference only
  EOF
  ls ~/Projects/ >> docs/backups/projects.txt 2>/dev/null || echo "no Projects dir"
  ```

  **QA**:
  ```
  Scenario: Config backups exist
    Tool: Bash
    Steps:
      1. test -d docs/backups/etc/ && ls docs/backups/etc/ | wc -l
      2. test -s docs/backups/running-services.txt
    Expected: At least 2 files in etc/, services.txt non-empty
    Evidence: .sisyphus/evidence/task-5-backups.txt
  ```

  **Commit**: NO (groups with T1)

---

## Final Verification

- [x] F1. **Verify all deliverables**

  Check:
  - `docs/migration-cachyos.md` — exists, 200+ lines
  - `packages/flatpak.txt` — 5+ lines
  - `packages/npm-global.txt` — 10+ lines, has current versions
  - `packages/go-packages.txt` — 3 lines
  - `packages/cargo.txt` — 1+ line
  - `packages/vscode-extensions.txt` — 15+ lines
  - `.gitignore` — has `docs/backups/` pattern
  - `docs/sensitive-files.md` — exists
  - `docs/config-inventory.md` — exists
  - `docs/backups/` — has nginx configs, service list, project list

  ```
  echo "=== Migration Kit Verification ==="
  for f in docs/migration-cachyos.md packages/flatpak.txt packages/npm-global.txt packages/go-packages.txt packages/cargo.txt packages/vscode-extensions.txt docs/sensitive-files.md docs/config-inventory.md; do
    [ -s "$f" ] && echo "OK: $f ($(wc -l < $f) lines)" || echo "MISSING: $f"
  done
  grep -q "docs/backups" .gitignore && echo "OK: .gitignore has backup pattern" || echo "MISSING: gitignore pattern"
  echo "Backups: $(find docs/backups -type f 2>/dev/null | wc -l) files"
  ```

- [x] F2. **Commit everything**

  ```bash
  git add -A
  git status  # verify no secrets staged
  git commit -m "feat: CachyOS migration prep

  - Migration guide with full step-by-step checklist
  - Updated package manifests (flatpak, npm, go, cargo, vscode)
  - Sensitive file management docs + gitignore
  - Config inventory for system services
  - Backups of nginx, php-fpm, valkey, mysql configs"
  git push
  ```

## Commit

- **T1-T5 → T commit**: `feat: CachyOS migration prep` (all files in one commit)
