# Learnings

- 2026-07-30: Backup scripts reference `~/Projects/` (28 projects) but dir doesn't exist in this sandbox environment. Site's actual home may have it on real hardware.
- 2026-07-30: System services exist (nginx, mysqld, php-fpm, valkey) in running-services.txt output — configs at `/etc/` may need `sudo` on real machine.
- 2026-07-30: `docs/backups/` is gitignored — safe to write backup artifacts here.
