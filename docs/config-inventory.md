# System Configuration Inventory

**Purpose**: Document all system service config files that need manual backup before migrating from Fedora 44 to CachyOS.

## Nginx

- **Config dir**: `/etc/nginx/`
- **Site configs**: `/etc/nginx/sites-enabled/` (8 sites)
  - `digasss.dep`
  - `emeterai.dep`
  - `foto-studio`
  - `handikatriarlan.outray.app`
  - `pakaiapp.dep`
  - `sistem-administrasi-desa`
  - `default`
  - `php-fpm`
- **Conf.d**: `/etc/nginx/conf.d/`
- **Backup command**:
  ```bash
  sudo cp -r /etc/nginx/sites-enabled/ ~/migration-backup/nginx-sites/
  sudo cp -r /etc/nginx/conf.d/ ~/migration-backup/nginx-conf.d/
  sudo cp /etc/nginx/nginx.conf ~/migration-backup/
  ```

## PHP-FPM

- **Version**: PHP 8.5.9 (system) + PHP 8.0.99 (remi)
- **Config dir**: `/etc/php-fpm.d/`
- **Pool config**: `/etc/php-fpm.d/www.conf`
- **php.ini**: `/etc/php.ini`
- **Backup command**:
  ```bash
  sudo cp /etc/php-fpm.d/www.conf ~/migration-backup/
  sudo cp /etc/php.ini ~/migration-backup/
  ```

## MySQL / MariaDB

- **Version**: MySQL 9.7
- **Config**: `/etc/my.cnf`, `/etc/my.cnf.d/`
- **Data dir**: `/var/lib/mysql/`
- **Backup command**:
  ```bash
  sudo cp /etc/my.cnf ~/migration-backup/
  sudo cp -r /etc/my.cnf.d/ ~/migration-backup/
  ```

## Valkey (Redis-compatible)

- **Version**: Valkey 9.0
- **Config**: `/etc/valkey/`
- **Dump file**: `/var/lib/valkey/dump.rdb`
- **Backup command**:
  ```bash
  sudo cp -r /etc/valkey/ ~/migration-backup/
  ```

## Systemd Services to Enable

After fresh CachyOS install, enable these services:

```bash
sudo systemctl enable --now nginx
sudo systemctl enable --now mariadb
sudo systemctl enable --now php-fpm
sudo systemctl enable --now valkey
sudo systemctl enable --now sshd
sudo systemctl enable --now cronie
```

## Project Domains

These domains are served by the nginx configs above:
- digasss.dep
- emeterai.dep
- foto-studio (local domain)
- handikatriarlan.outray.app
- pakaiapp.dep
- sistem-administrasi-desa (local domain)

## Backup Summary

```bash
# Create backup dir
mkdir -p ~/migration-backup

# Copy all configs at once
sudo cp -r /etc/nginx/ ~/migration-backup/nginx/
sudo cp -r /etc/php-fpm.d/ ~/migration-backup/php-fpm/
sudo cp /etc/php.ini ~/migration-backup/
sudo cp -r /etc/my.cnf.d/ ~/migration-backup/mysql/
sudo cp /etc/my.cnf ~/migration-backup/
sudo cp -r /etc/valkey/ ~/migration-backup/valkey/

# Fix ownership
sudo chown -R $USER:$USER ~/migration-backup/
```
