# Sensitive Files — Backup Guide

**Purpose**: Document which files must NEVER be committed to git and how to back them up before OS migration.

## Files to Backup Manually

### SSH Keys (~/.ssh/)
```
mkdir -p ~/migration-backup/ssh
cp -r ~/.ssh/* ~/migration-backup/ssh/
chmod 600 ~/migration-backup/ssh/*
```

> **Never commit SSH private keys.** They grant access to servers.

### GPG Keys (~/.gnupg/)
```
mkdir -p ~/migration-backup/gnupg
gpg --export-secret-keys --armor > ~/migration-backup/gnupg/private-keys.asc
gpg --export --armor > ~/migration-backup/gnupg/public-keys.asc
gpg --export-ownertrust > ~/migration-backup/gnupg/ownertrust.txt
cp -r ~/.gnupg/* ~/migration-backup/gnupg/
```

### Git Credentials
```
cp ~/.git-credentials ~/migration-backup/ 2>/dev/null || echo "No .git-credentials"
```

### Shell History
```
cp ~/.zsh_history ~/migration-backup/ 2>/dev/null
cp ~/.bash_history ~/migration-backup/ 2>/dev/null
```

### Database Exports
```
mysqldump -u root --all-databases > ~/migration-backup/all-dbs.sql
```

### .env Files and Tokens
```
find ~/Projects/ -name ".env" -o -name "*.token" -o -name "credentials*" 2>/dev/null
```
Copy any found to: `~/migration-backup/env-files/`

## Restore on New System

```bash
# SSH
cp -r ~/migration-backup/ssh/* ~/.ssh/
chmod 600 ~/.ssh/*

# GPG
gpg --import ~/migration-backup/gnupg/private-keys.asc
gpg --import ~/migration-backup/gnupg/public-keys.asc
gpg --import-ownertrust ~/migration-backup/gnupg/ownertrust.txt

# Git credentials
cp ~/migration-backup/.git-credentials ~/ 2>/dev/null

# MySQL
sudo mysql < ~/migration-backup/all-dbs.sql
```

## Files Already in Dotfiles Repo (safe to commit)

- SSH public keys? NO — even .pub files reveal usernames
- GPG public keys? OK — designed to be shared
- Any `.env` file? NO — always gitignored
