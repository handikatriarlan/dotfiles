#!/usr/bin/env bash
#
# Dotfiles Installation & Restoration Script for CachyOS
# Author: Handika Triarlan
#

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; }

restore_configs() {
    info "Restoring configuration files..."

    # 1. Config directory
    mkdir -p "$HOME/.config"
    cp -r "$DOTFILES_DIR/config/"* "$HOME/.config/"
    success "Copied app configurations to ~/.config/"

    # 2. Home root dotfiles
    if [ -f "$DOTFILES_DIR/home/.zshrc" ]; then
        cp "$DOTFILES_DIR/home/.zshrc" "$HOME/.zshrc"
        success "Restored ~/.zshrc"
    fi

    if [ -f "$DOTFILES_DIR/home/.gitconfig" ]; then
        cp "$DOTFILES_DIR/home/.gitconfig" "$HOME/.gitconfig"
        success "Restored ~/.gitconfig"
    fi

    # 3. KDE Wallpapers
    if [ -d "$DOTFILES_DIR/kde/wallpapers" ]; then
        mkdir -p "$HOME/.local/share/wallpapers"
        cp -r "$DOTFILES_DIR/kde/wallpapers/"* "$HOME/.local/share/wallpapers/"
        success "Restored wallpapers to ~/.local/share/wallpapers/"
    fi

    # 4. KDE Color schemes
    if [ -d "$DOTFILES_DIR/kde/color-schemes" ]; then
        mkdir -p "$HOME/.local/share/color-schemes"
        cp -r "$DOTFILES_DIR/kde/color-schemes/"* "$HOME/.local/share/color-schemes/"
        success "Restored color schemes to ~/.local/share/color-schemes/"
    fi

    # 5. KDE Plasma configs
    for kdefile in kdeglobals kglobalshortcutsrc kwinrc plasma-org.kde.plasma.desktop-appletsrc plasmarc; do
        if [ -f "$DOTFILES_DIR/kde/$kdefile" ]; then
            cp "$DOTFILES_DIR/kde/$kdefile" "$HOME/.config/$kdefile"
            success "Restored KDE config: ~/.config/$kdefile"
        fi
    done

    # 6. SDDM config reminder
    if [ -f "$DOTFILES_DIR/sddm/sddm.conf" ]; then
        info "To restore SDDM login theme config, run: sudo cp $DOTFILES_DIR/sddm/sddm.conf /etc/sddm.conf"
    fi

    success "Configuration restore completed!"
}

install_pacman() {
    if [ ! -f "$DOTFILES_DIR/packages/pacman.txt" ]; then
        error "Package manifest $DOTFILES_DIR/packages/pacman.txt not found."
        return 1
    fi

    info "Installing native pacman packages..."
    sudo pacman -S --needed --noconfirm - < "$DOTFILES_DIR/packages/pacman.txt"
    success "Pacman packages installed successfully!"
}

install_aur() {
    if [ ! -f "$DOTFILES_DIR/packages/aur.txt" ]; then
        error "AUR package manifest $DOTFILES_DIR/packages/aur.txt not found."
        return 1
    fi

    local helper=""
    if command -v paru >/dev/null 2>&1; then
        helper="paru"
    elif command -v yay >/dev/null 2>&1; then
        helper="yay"
    else
        error "Neither paru nor yay found. Please install an AUR helper first."
        return 1
    fi

    info "Installing AUR packages using $helper..."
    "$helper" -S --needed --noconfirm - < "$DOTFILES_DIR/packages/aur.txt"
    success "AUR packages installed successfully!"
}

install_npm() {
    if [ ! -f "$DOTFILES_DIR/packages/npm-global.txt" ]; then
        error "npm packages manifest $DOTFILES_DIR/packages/npm-global.txt not found."
        return 1
    fi

    if ! command -v npm >/dev/null 2>&1; then
        error "npm is not installed."
        return 1
    fi

    info "Installing global npm packages..."
    xargs npm install -g < "$DOTFILES_DIR/packages/npm-global.txt"
    success "Global npm packages installed successfully!"
}

install_vscode() {
    if [ ! -f "$DOTFILES_DIR/packages/vscode-extensions.txt" ]; then
        error "VSCode extensions manifest $DOTFILES_DIR/packages/vscode-extensions.txt not found."
        return 1
    fi

    local editor_cmd=""
    if command -v code >/dev/null 2>&1; then
        editor_cmd="code"
    elif command -v cursor >/dev/null 2>&1; then
        editor_cmd="cursor"
    else
        error "Neither 'code' nor 'cursor' CLI found in PATH."
        return 1
    fi

    info "Installing extensions using $editor_cmd..."
    while IFS= read -r ext || [ -n "$ext" ]; do
        [ -z "$ext" ] && continue
        "$editor_cmd" --install-extension "$ext" --force || warn "Failed to install $ext"
    done < "$DOTFILES_DIR/packages/vscode-extensions.txt"
    success "VSCode/Cursor extensions installed!"
}

show_help() {
    echo -e "${CYAN}CachyOS Dotfiles Installer${NC}"
    echo "Usage: $0 [command]"
    echo ""
    echo "Commands:"
    echo "  configs   - Restore all configs to ~/.config, ~/, and ~/.local/share/"
    echo "  pacman    - Install all native pacman packages"
    echo "  aur       - Install all AUR packages (via paru or yay)"
    echo "  npm       - Install all global npm packages"
    echo "  code      - Install all VSCode / Cursor extensions"
    echo "  all       - Run all restoration and installation tasks"
    echo "  help      - Show this help message"
    echo ""
    echo "Running without arguments will launch an interactive menu."
}

interactive_menu() {
    echo -e "${CYAN}==============================================${NC}"
    echo -e "${CYAN}       CachyOS Dotfiles Setup Assistant       ${NC}"
    echo -e "${CYAN}==============================================${NC}"
    echo "1) Restore Configs (~/.config, ~/.zshrc, KDE, wallpapers)"
    echo "2) Install Pacman Packages"
    echo "3) Install AUR Packages (paru/yay)"
    echo "4) Install Global NPM Packages"
    echo "5) Install VSCode / Cursor Extensions"
    echo "6) Run All Tasks"
    echo "q) Exit"
    echo ""
    read -rp "Select an option [1-6, q]: " choice

    case "$choice" in
        1) restore_configs ;;
        2) install_pacman ;;
        3) install_aur ;;
        4) install_npm ;;
        5) install_vscode ;;
        6)
            restore_configs
            install_pacman
            install_aur
            install_npm
            install_vscode
            ;;
        q|Q) info "Exiting."; exit 0 ;;
        *) error "Invalid choice."; exit 1 ;;
    esac
}

main() {
    case "${1:-}" in
        configs) restore_configs ;;
        pacman) install_pacman ;;
        aur) install_aur ;;
        npm) install_npm ;;
        code) install_vscode ;;
        all)
            restore_configs
            install_pacman
            install_aur
            install_npm
            install_vscode
            ;;
        help|--help|-h) show_help ;;
        "") interactive_menu ;;
        *) error "Unknown command: $1"; show_help; exit 1 ;;
    esac
}

main "$@"
