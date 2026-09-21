# ============ OMZ (oh-my-zsh) + plugins ============
export ZSH="/usr/share/oh-my-zsh"
plugins=(git fzf extract sudo colored-man-pages archlinux command-not-found)
source $ZSH/oh-my-zsh.sh

# zsh plugin sources (system packages)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh

# ============ Starship prompt ============
eval "$(starship init zsh)"
starship_precmd_user_func="set_win_title"

# ============ Shell behavior ============
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

export HISTCONTROL=ignoreboth
export HISTORY_IGNORE="(\&|[bf]g|c|clear|history|exit|q|pwd|* --help)"
export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"

# ============ History ============
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ============ Editor ============
export EDITOR=nano

# ============ PATH ============
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.bun/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ============ Aliases ============
alias c="clear"
alias ..="cd .."
alias ls="eza --icons -a"
alias show="fastfetch"
alias py="python3"
alias dev="cd ~/CachyPad/Dev"
alias cekip="ip addr show eth0 | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

# bat (cat with syntax highlighting)
command -v bat >/dev/null && alias cat="bat"

# Pacman / system (from cachyos-zsh-config)
alias update="sudo pacman -Syu"
alias make="make -j`nproc`"
alias ninja="ninja -j`nproc`"
alias n="ninja"
alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
alias jctl="journalctl -p 3 -xb"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias please="sudo"
alias tb="nc termbin.com 9999"

# Laravel
alias art="php artisan"
alias arts="php artisan serve"
alias 9000="php artisan serve --port=9000"
alias gas="php artisan serve --host=0.0.0.0 --port=8000"
alias artm="php artisan migrate"
alias artmfs="php artisan migrate:fresh --seed"
alias artcac="php artisan cache:clear"
alias artcon="php artisan config:clear"
alias crd="composer run dev"
alias pred="php artisan dev"
alias brd="bun run dev"
alias nrd="npm run dev"
alias nrs="npm run start"
alias nrsd="npm run start:dev"
alias otp='php artisan tinker --execute="echo optional(App\Models\User::find(183))->two_factor_secret;"'

# Git / misc
alias gcl="git clone"
alias clean="find . -name '*:Zone.Identifier' -type f -delete"
alias hapusin='sudo rm -rf /var/www/digasss-web/.agent /var/www/digasss-web/.github /var/www/digasss-web/NEW_SCHEME.md /var/www/digasss-web/AGENTS.md /var/www/digasss-web/.ignore && sudo sed -i "/^\.agent$/d;/^\.ignore$/d;/^\.github$/d;/^\NEW_SCHEME.md$/d" /var/www/digasss-web/.gitignore'
alias pindahin="cp -r /home/handikatriarlan/Downloads/digasss/backup/{.agent,.github,.gitignore,AGENTS.md,NEW_SCHEME.md,.ignore} /var/www/digasss-web/"

# ============ Terminal title ============
function set_win_title() {
    echo -ne "\033]0; $(basename "$PWD") \007"
}

# ============ Welcome ============
clear
echo -e "\e[1;35mWelcome back, Arlan! Prepare to conquer.\e[0m"
fastfetch --pipe false
