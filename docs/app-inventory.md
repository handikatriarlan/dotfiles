# App & Package Inventory

> Generated: 2026-07-30 from live Fedora 44 system.

## Desktop Apps (RPM)

| App | Package | Notes |
|-----|---------|-------|
| VS Code | `code` | |
| Cursor | `cursor` | AI editor |
| Brave Browser | `brave-browser` | |
| Google Chrome | `google-chrome-stable` | |
| Zen Browser | Flatpak | See flatpak |
| Kitty | `kitty` | Terminal |
| Fastfetch | `fastfetch` | System info |
| Dolphin | `dolphin` | File manager |
| Konsole | `konsole` | KDE terminal |
| Spectacle | `spectacle` | Screenshot |
| Gwenview | `gwenview` | Image viewer |
| Okular | `okular` | PDF/docs |
| KWrite | `kwrite` | Text editor |
| KolourPaint | `kolourpaint` | Paint |
| KCalc | `kcalc` | Calculator |
| Filelight | `filelight` | Disk usage |
| KDE Connect | `kde-connect` | Phone integration |
| KFind | `kfind` | File search |
| KRDC | `krdc` | Remote desktop client |
| KRFB | `krfb` | Remote desktop server |
| VLC | `vlc` + plugins | Video player |
| OBS Studio | `obs-studio` / flatpak | Screen recording |
| Zoom | `zoom` | Video conf |
| RustDesk | `rustdesk` | Remote desktop |
| Bruno | `bruno` | API client |
| Beekeeper Studio | `beekeeper-studio` | DB GUI |
| FileZilla | `filezilla` | FTP/SFTP client |
| 7-Zip | `7zip` | Archive manager |
| qrca | `qrca` | QR code scanner |

## Dev Tools (RPM)

| Tool | Package | Notes |
|------|---------|-------|
| Git | `git` | |
| Rust | `rust` + `rust-std-static` | 1.97.1 |
| GCC | `gcc` | |
| PHP 8.3 | `php` | Default (remi) |
| PHP 8.0 | `php80-*` | SCL |
| PHP 8.1 | `php81-*` | SCL |
| PHP 8.2 | `php82-*` | SCL |
| PHP 8.4 | `php84-*` | SCL |
| PHP 8.5 | `php85-*` | SCL |
| PHP 8.6 | `php86-*` | SCL |
| PHP 7.4 | `php74-*` | SCL |
| PHPMyAdmin | `phpMyAdmin` | |
| Nginx | `nginx` | Web server |
| MariaDB/MySQL | `mysql-community-server` | 9.7 |
| Valkey | `valkey-compat-redis` | Redis replacement |
| PostgreSQL | `postgresql-server` + contrib | |
| Tailscale | `tailscale` | VPN |
| Docker | `docker-ce` + compose/buildx | |
| UFW | `ufw` | Firewall |
| btop | `btop` | Resource monitor |
| ncdu | `ncdu` | Disk usage CLI |
| ripgrep | `ripgrep` | Search |
| fzf | `fzf` | Fuzzy find |
| tree | `tree` | Dir tree |
| rclone | `rclone` | Cloud sync |
| jdk-21 | `jdk-21` | Java 21 |
| mkcert | `mkcert` | Local HTTPS |
| putty | `putty` | SSH client |
| dos2unix | `dos2unix` | Line endings |

## Media Codecs

- `gstreamer1-plugin-libav`, `gstreamer1-plugins-bad-freeworld`, `gstreamer1-plugins-ugly`
- `vlc-plugin-gstreamer`, `vlc-plugins-freeworld`
- `ffmpeg`, `ffmpegthumbs`
- `libheif-freeworld`
- `libva-intel-driver`, `libva-intel-media-driver`
- `intel-media-driver`

## Flatpak

| App | ID | Origin |
|-----|----|--------|
| Zen Browser | `app.zen_browser.zen` | flathub |
| Discord | `com.discordapp.Discord` | flathub |
| OBS Studio | `com.obsproject.Studio` | flathub |
| LocalSend | `org.localsend.localsend_app` | flathub |
| Telegram | `org.telegram.desktop` | flathub |

## npm Global Packages

```
9router          @ 0.5.45        # LLM CLI
@gitlawb/openclaude  @ 0.11.0    # Claude CLI
@google/gemini-cli @ 0.41.2     # Gemini CLI
@nestjs/cli      @ 11.0.16      # NestJS CLI
agent-browser    @ 0.26.0       # Playwright-based agent browser
better-sqlite3   @ 12.6.2
codebase-memory-mcp @ 0.9.0     # Codebase memory MCP
intelephense     @ 1.16.5       # PHP intellisense
nodemon          @ 3.1.14
outray           @ 0.1.7
sql.js           @ 1.14.1
systray2         @ 2.1.4
uipro-cli        @ 2.2.3
vercel           @ 50.13.2      # Vercel CLI
shadcn           @ 4.16.0       # via bun
ecc-universal    @ 2.1.0        # via bun
```

## Go Tools (`~/go/bin/`)

- `geminicommit` — AI commit messages
- `gopls` — Go LSP server
- `staticcheck` — Go static analysis

## Cargo Tools

- `eza` — modern `ls` replacement

## VSCode Extensions

| ID | Purpose |
|----|---------|
| `dbaeumer.vscode-eslint` | JS linting |
| `esbenp.prettier-vscode` | Formatter |
| `eamodio.gitlens` | Git supercharged |
| `laravel.vscode-laravel` | Laravel support |
| `devsense.phptools-vscode` | PHP dev tools |
| `formulahendry.auto-close-tag` | Auto-close HTML |
| `formulahendry.auto-rename-tag` | Auto-rename HTML |
| `pkief.material-icon-theme` | File icons |
| `kisstkondoros.vscode-gutter-preview` | Image preview |
| `usernamehw.errorlens` | Inline errors |
| `wakatime.vscode-wakatime` | Coding stats |
| `cardinal90.multi-cursor-case-preserve` | Multi-cursor |
| `smcpeak.default-keys-windows` | Windows keymap |
| `adityaputrapratama.sholat-reminder` | Prayer reminder |
| `github.codespaces` | GitHub Codespaces |

## System Services

See `docs/config-inventory.md` for full service config backup guide.

- `nginx` — Web server
- `mysqld` — MySQL 9.7
- `php-fpm` — PHP 8.3 FastCGI
- `valkey` — Redis-compatible cache
- `docker` — Container engine
- `tailscale` — VPN mesh
- `sshd` — SSH server
- `firewalld` — Firewall
- `ufw` — Alternative firewall
- `chronyd` — NTP
- `systemd-resolved` — DNS resolver
- `cups` — Print service
- `sddm` — Display manager

## Package Manifests

Detailed lists in `packages/`:

| File | Contains |
|------|----------|
| `packages/dnf.txt` | All DNF packages |
| `packages/flatpak.txt` | Flatpak apps |
| `packages/npm-global.txt` | npm global packages |
| `packages/go-packages.txt` | Go tools |
| `packages/cargo.txt` | Cargo tools |
| `packages/vscode-extensions.txt` | VS Code extensions |

## Notes

- **PHP versions**: 7.4, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5, 8.6 from REMI SCL repos
- **Node.js**: v25.5.0 via nvm (not system package)
- **Bun**: 1.3.14 (separate from npm)
- **PHP 8.3** is the default CLI/FPM version
- Full RPM list in `packages/all-rpm.txt` (too long for inline)
