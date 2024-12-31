#!/bin/sh
alias config="stow -t $HOME -d $HOME/.dotfiles"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Print paths from $PATH
alias paths='echo $PATH | tr ":" "\n"'

# Easier to read disk
# alias df='df -h'     # human-readable sizes
# alias free='free -m' # show sizes in MB

# Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# Get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# GPG encryption
# Verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# Receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# Systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

# Run an http server: serve 8888
alias serve="python3 -m http.server" 

# Search and use bat as a previewer
if [[ -x "$(command -v fzf)" ]] && [[ -x "$(command -v bat)" ]]; then
  alias fp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  
  supersearch() {
    if [ $# -eq 0 ]; then
      fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
    else
      if [ -d $1 ]; then
        grep -R "$(find $1/* -type f -exec cat {} \; | fzf)" $1/
      else
        cat $1 | fzf
      fi
    fi
  }

  alias sps=supersearch
fi