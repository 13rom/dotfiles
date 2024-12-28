#!/bin/bash

# Run Zap
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Source files
plug "${ZDOTDIR}/exports.zsh"
plug "${ZDOTDIR}/aliases.zsh"
plug "${ZDOTDIR}/supercharge.zsh"

# Load plugins
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "wintermi/zsh-lsd"
plug "13rom/zsh-bat"
plug "agkozak/zsh-z"
plug "MichaelAquilina/zsh-you-should-use"
plug "zap-zsh/completions"

# plug "zap-zsh/supercharge"
# plug "zap-zsh/vim"
# plug "zap-zsh/exa"
# plug "fdellwing/zsh-bat"
# plug "Freed-Wu/fzf-tab-source"

# Load prompt
plug "${ZDOTDIR}/plugins/zsh-simple-prompt"
# plug "zap-zsh/atmachine-prompt"
# plug "zap-zsh/zap-prompt"
# plug "spaceship-prompt/spaceship-prompt"
# plug "MAHcodes/distro-prompt"
# plug "zettlrobert/simple-prompt"
# plug "mafredri/zsh-async"
# plug "sindresorhus/pure"

# Load and initialize completion system
# autoload -Uz compinit
# compinit
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# if
#   command -v batcat &>/dev/null
# then
#   alias cat="batcat -pp --theme \"Visual Studio Dark+\""
#   alias catt="batcat --theme \"Visual Studio Dark+\""
# fi

# if
#   command -v lsd &>/dev/null
# then
#   alias ls='lsd --group-dirs=first'
# fi

# Prettify ls and cat (lsd and batcat must be installed)
# command -v lsd >/dev/null && alias ls='lsd --group-dirs first'
#command -v lsd > /dev/null && alias tree='lsd --tree'
# command -v batcat >/dev/null && alias cat='batcat -pp --theme="Visual Studio Dark+"'
# command -v batcat >/dev/null && alias less='batcat -p --theme="Visual Studio Dark+"'

# optionally define some options
# PURE_CMD_MAX_EXEC_TIME=10

# # change the path color
# zstyle :prompt:pure:path color yellow

# # change the color for both `prompt:success` and `prompt:error`
# zstyle ':prompt:pure:prompt:success' color white
# zstyle ':prompt:pure:prompt:error' color red

# turn on git stash status
# zstyle :prompt:pure:git:stash show yes
