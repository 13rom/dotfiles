#!/usr/bin/env bash
######################################################################
#
#
#            █████╗ ██╗     ██╗ █████╗ ███████╗███████╗███████╗
#           ██╔══██╗██║     ██║██╔══██╗██╔════╝██╔════╝██╔════╝
#           ███████║██║     ██║███████║███████╗█████╗  ███████╗
#           ██╔══██║██║     ██║██╔══██║╚════██║██╔══╝  ╚════██║
#           ██║  ██║███████╗██║██║  ██║███████║███████╗███████║
#           ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝
#
#
######################################################################

######################################################################
# COLOR SUPPORT
######################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

######################################################################
# GENERAL ALIASES
# commands tuning
######################################################################

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Prettify ls and cat (lsd and batcat must be installed)
command -v lsd >/dev/null && alias ls='lsd --group-dirs first'
#command -v lsd > /dev/null && alias tree='lsd --tree'
command -v batcat >/dev/null && alias cat='batcat -pp --theme=ansi'
command -v batcat >/dev/null && alias less='batcat -p --theme=ansi'

# correct typos in shell
alias cd..="cd .."

# make mount command output pretty
alias mount='mount | column -t'

######################################################################
# SPECIAL ALIASES
# commands creation
######################################################################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# automatically do an ls after each cd
function cdl {
    builtin cd $1 && ls
}

function cdla {
    builtin cd $1 && ls -la
}

# alias to show the time and date
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

######################################################################
# MACHINE-SPECIFIC ALIASES
######################################################################
#  |¯¯'\/'¯¯||¯¯||¯¯|\¯¯\' /¯¯/\¯¯\'|¯¯'\/'¯¯|
#  | '|\/| '|| '|| '|/  / |  |  | '|| '|\/| '|
#  |__|  |__||__||__|'\__\ \__\/__/'|__|  |__|
