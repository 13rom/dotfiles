# ~/.zshrc
# --------------------------
# Prerequisites:
# - sudo apt install git zsh stow direnv
# - sudo apt install build-essential procps curl file git
# - /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# - brew install fzf zoxide eza bat
# --------------------------

### PREPARE ENVIRONMENT

# Set XDG Base Directory Specification
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

# Linuxbrew setup
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  # If you're using homebrew on linux, you'll want this enabled
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


### SETUP ZINIT

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


### SETUP ZSH PLUGINS

# Load completions
autoload -Uz compinit && compinit

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light MichaelAquilina/zsh-you-should-use
zinit light Aloxaf/fzf-tab

# Load starship theme
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
# zinit snippet OMZL::git.zsh
# zinit snippet OMZP::git

zinit cdreplay -q


### SETUP ZSH OPTIONS

# Set emacs keybindings
bindkey -e

# History options
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes
# zstyle ':fzf-tab:complete:*' fzf-preview 'eza $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


### ADDITIONAL CONFIG

# Exports
export EDITOR="vim"
export EZA_ICON_SPACING=2

# Aliases
[[ -f $HOME/.bash_aliases ]] && source $HOME/.bash_aliases
alias zreload="source $HOME/.zshrc"
alias zshrc="code $HOME/.zshrc"
alias ls="eza -F --long --group --group-directories-first --icons=always --git --color --color-scale all --smart-group"
alias cd..="cd .."

# Shell integrations
eval "$(fzf --zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Custom completions
source <(kubectl completion zsh)

# Starship prompt
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
