# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	node
	zsh-completions
	zsh-autosuggestions
	zsh-history-substring-search
	zsh-interactive-cd
	zsh-syntax-highlighting
	)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias art="php artisan"
alias arts="php artisan serve"
alias 9000="php artisan serve --port=9000"
alias gas="php artisan serve --host=0.0.0.0 --port=8000"
alias artm="php artisan migrate"
alias artmfs="php artisan migrate:fresh --seed"
alias artcac="php artisan cache:clear"
alias artcon="php artisan config:clear"
alias crd="composer run dev"
alias brd="bun run dev"
alias gcl="git clone"
alias nrd="npm run dev"
alias nrs="npm run start"
alias nrsd="npm run start:dev"
alias gmcall="git add . && gmc -p"
alias gmcpush="gmc -p"
alias clean="find . -name '*:Zone.Identifier' -type f -delete"
alias c="clear"
alias dev="cd ~/nobarapad/dev"
alias lambo="cd ~/nobarapad/dev/php"
alias py="python3"
alias cekip="ip addr show eth0 | grep 'inet ' | awk '{print $2}' | cut -d'/' -f1"
alias update="sudo dnf update && sudo dnf upgrade -y"
alias sail="./vendor/bin/sail"
alias ls="eza --icons -a"
alias show="fastfetch"
alias ..="cd .."

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib:/mnt/c/Users/handi/AppData/Local/Programs/cursor/resources/app/bin:/mnt/c/Users/handi/AppData/Local/Programs/Python/Python312/Scripts/:/mnt/c/Users/handi/AppData/Local/Programs/Python/Python312/:/mnt/c/Program Files/Common Files/Oracle/Java/javapath:/mnt/c/WINDOWS/system32:/mnt/c/WINDOWS:/mnt/c/WINDOWS/System32/Wbem:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/:/mnt/c/WINDOWS/System32/OpenSSH/:/mnt/c/MinGW/bin:/mnt/c/Program Files/MySQL/MySQL Server 8.0/bin:/mnt/c/Users/handi/AppData/Local/Programs/Python/Python39/Scripts/:/mnt/c/Users/handi/AppData/Local/Programs/Python/Python39/:/mnt/c/Users/handi/AppData/Local/Microsoft/Power Automate Desktop:/mnt/c/Users/handi/AppData/Local/spicetify:/mnt/c/xampp/php:/mnt/c/Users/handi/AppData/Local/Programs/Python/Python39/Scripts:/mnt/c/Python39:/mnt/c/Python39:/mnt/c/adb:/mnt/c/ProgramData/chocolatey/bin:/mnt/c/Users/handi/AppData/Roaming/nvm:/mnt/c/Program Files/nodejs:/mnt/c/Program Files/GitHub CLI/:/mnt/c/composer:/mnt/c/ProgramData/ComposerSetup/bin:/mnt/c/Program Files/Git/cmd:/mnt/c/Program Files/PuTTY/:/mnt/c/Program Files/Docker/Docker/resou:/mnt/c/Users/handi/AppData/Local/Programs/cursor/resources/app/bin:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/Program Files/PowerShell/7/:/mnt/c/Program Files/Go/bin:/mnt/c/Users/handi/AppData/Local/pnpm:/mnt/c/laragon/bin:/mnt/c/laragon/bin/apache/httpd-2.4.54-win64-VS16/bin:/mnt/c/laragon/bin/git/bin:/mnt/c/laragon/bin/git/cmd:/mnt/c/laragon/bin/git/mingw64/bin:/mnt/c/laragon/bin/git/usr/bin:/mnt/c/laragon/bin/laragon/utils:/mnt/c/laragon/bin/mysql/mysql-8.4.2-winx64/bin:/mnt/c/laragon/bin/nginx/nginx-1.26.2:/mnt/c/laragon/bin/ngrok:/mnt/c/laragon/bin/nodejs/node-v18:/mnt/c/laragon/bin/notepad++:/mnt/c/laragon/bin/php/php-8.3.12:/mnt/c/laragon/bin/python/python-3.10:/mnt/c/laragon/bin/python/python-3.10/Scripts:/mnt/c/laragon/bin/redis/redis-x64-5.0.14.1:/mnt/c/laragon/bin/telnet:/mnt/c/laragon/usr/bin:/mnt/c/Users/handi/AppData/Local/Yarn/config/global/node_modules/.bin:/mnt/c/Users/handi/AppData/Roaming/Composer/vendor/bin:/mnt/c/Users/handi/AppData/Roaming/npm:/mnt/c/Users/handi/AppData/Local/Programs/Microsoft VS Code/bin:/mnt/c/Program Files/Git:/mnt/c/Users/handi/AppData/Local/GitHubDesktop/bin:/mnt/c/Users/handi/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/handi/AppData/Local/Programs/oh-my-posh/bin:/mnt/c/Program Files/JetBrains/PyCharm 2024.2.2/bin:/mnt/c/Program Files/JetBrains/IntelliJ IDEA 2024.2.2/bin:/mnt/c/Users/handi/AppData/Local/flutter/bin:/mnt/c/Users/handi/.bun/bin:/mnt/c/Users/handi/.deno/bin:/mnt/c/Program Files/JetBrains/PhpStorm 2024.1.4/bin:/mnt/c/Program Files/mongosh/:/mnt/c/Program Files/Oracle/VirtualBox:/mnt/c/Program Files/PostgreSQL/17/bin:/mnt/c/Users/handi/AppData/Local/Programs/Ollama:/mnt/c/Users/handi/go/bin:/mnt/c/Users/handi/AppData/Local/Android/Sdk/platform-tools:/usr/local/go/bin"
export PATH=$HOME/.config/herd-lite/bin:$PATH

# fnm
FNM_PATH="/home/handikatriarlan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/handikatriarlan/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
export PATH=/usr/local/zig:$PATH

# bun completions
[ -s "/home/handikatriarlan/.bun/_bun" ] && source "/home/handikatriarlan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/home/handikatriarlan/.config/herd-lite/bin:$PATH"
export PHP_INI_SCAN_DIR="/home/handikatriarlan/.config/herd-lite/bin:$PHP_INI_SCAN_DIR"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
export EDITOR=nano

eval "$(starship init zsh)"

precmd_functions+=(set_win_title)
function set_win_title(){
    echo -ne "\033]0; $(basename "$PWD") \007"
}
starship_precmd_user_func="set_win_title"

clear
echo -e "\e[1;35mWelcome back, Arlan! Prepare to conquer.\e[0m"
fastfetch
export PATH="$HOME/.cargo/bin:$PATH"

export TERMINAL=ghostty

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

. "$HOME/.limbo/env"

# Turso
export PATH="$PATH:/home/handikatriarlan/.turso"
export PATH="/opt/PhpStorm-251.26927.60/bin:$PATH"
