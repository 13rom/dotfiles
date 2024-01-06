#!/usr/bin/env bash
######################################################################
#
#
#           ███████╗██╗   ██╗███╗   ██╗ ██████╗
#           ██╔════╝██║   ██║████╗  ██║██╔════╝
#           █████╗  ██║   ██║██╔██╗ ██║██║
#           ██╔══╝  ██║   ██║██║╚██╗██║██║
#           ██║     ╚██████╔╝██║ ╚████║╚██████╗
#           ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝
#
#
######################################################################

######################################################################
# ROOT PROMPT INSTALL
# copy prompt.bashrc file to /root/.bashrc.d/promt.bashrc
######################################################################

function root_prompt_install() {
    sudo cp $HOME/.bashrc.d/prompt.bashrc /root/.bashrc.d
}

######################################################################
# EXIT
# run upon exit of shell
######################################################################

_exit() {
    echo -e "Hasta la vista, baby"
}
trap _exit EXIT

######################################################################
# COLOR INDEX
# show bash colors table (FROM: http://redd.it/jkaqz)
######################################################################

color_index() {
    # Show an index of all available bash colors
    echo -e "\n              Usage: \\\033[*;**(;**)m"
    echo -e "            Default: \\\033[0m\n"
    # Top border
    echo -e "     \033[0;30;40m                                         \033[0m"
    for STYLE in 2 0 1 4 9; do
        echo -en "     \033[0;30;40m "
        # Display black fg on white bg
        echo -en "\033[${STYLE};30;47m${STYLE};30\033[0;30;40m "
        for FG in $(seq 31 37); do
            CTRL="\033[${STYLE};${FG};40m"
            echo -en "${CTRL}"
            echo -en "${STYLE};${FG}\033[0;30;40m "
        done
        echo -e "\033[0m\n     \033[0;30;40m                                         \033[0m"
    done
    echo -en "     \033[0;30;40m "
    # Background colors
    echo -en "\033[0;37;40m*;40\033[0;30;40m \033[0m" # Display white fg on black bg
    for BG in $(seq 41 47); do
        CTRL="\033[0;30;${BG}m"
        echo -en "${CTRL}"
        echo -en "*;${BG}\033[0;30;40m "
    done
    echo -e "\033[0m"
    # Bottom border
    echo -e "     \033[0;30;40m                                         \033[0m\n"
}

######################################################################
# GIT BRANCH
# show current git branch
######################################################################

git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

######################################################################
# EXTRACT
# extract archive files
######################################################################

extract() {
    if [ -f "$1" ]; then
        case "$1" in
        *.tar.bz2) tar xvjf "$1" ;;
        *.tar.gz) tar xvzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xvf "$1" ;;
        *.tbz2) tar xvjf "$1" ;;
        *.tgz) tar xvzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *) echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}
