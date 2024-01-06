#!/usr/bin/env bash
######################################################################
#
#
#           ██████╗ ██████╗  ██████╗ ███╗   ███╗██████╗ ████████╗
#           ██╔══██╗██╔══██╗██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝
#           ██████╔╝██████╔╝██║   ██║██╔████╔██║██████╔╝   ██║
#           ██╔═══╝ ██╔══██╗██║   ██║██║╚██╔╝██║██╔═══╝    ██║
#           ██║     ██║  ██║╚██████╔╝██║ ╚═╝ ██║██║        ██║
#           ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝        ╚═╝
#
#
######################################################################

######################################################################
# SET FANCY PROMPT
# advanced command promt with git status
######################################################################

# shorten directory path to 3 dirs
PROMPT_DIRTRIM=3

# enable color
force_color_prompt=true

function __generate_fancy_prompt() {
    local LAST_COMMAND=$? # Must come first!

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
    xterm-color | *-256color) color_prompt=yes ;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    if [ "$color_prompt" = yes ]; then
        # define colors
        local FMT_BOLD="\[\e[1m\]"
        local FMT_DIM="\[\e[2m\]"
        local FMT_RESET="\[\e[0m\]"
        local FMT_UNBOLD="\[\e[22m\]"
        local FMT_UNDIM="\[\e[22m\]"
        local FG_BLACK="\[\e[30m\]"
        local FG_BLUE="\[\e[34m\]"
        local FG_CYAN="\[\e[36m\]"
        local FG_GREEN="\[\e[32m\]"
        local FG_YELLOW="\[\e[33m\]"
        local FG_GREY="\[\e[37m\]"
        local FG_MAGENTA="\[\e[35m\]"
        local FG_RED="\[\e[31m\]"
        local FG_WHITE="\[\e[97m\]"
        local BG_BLACK="\[\e[40m\]"
        local BG_BLUE="\[\e[44m\]"
        local BG_CYAN="\[\e[46m\]"
        local BG_GREEN="\[\e[42m\]"
        local BG_YELLOW="\[\e[43m\]"
        local BG_MAGENTA="\[\e[45m\]"
        local BG_RED="\[\e[41m\]"
        local BG_WHITE="\[\e[107m\]"
    fi

    # ----------------------------------------------
    # Prepare the prompt prerequisites
    # ----------------------------------------------

    local is_root
    local is_ssh
    local git_branch
    local git_status
    local is_failed

    # Root or regular user?
    [[ $EUID -ne 0 ]] && is_root=false || is_root=true

    # Local or ssh connection?
    [ "$SSH_CONNECTION" -a "$SSH_TTY" == "$(tty)" ] && is_ssh=true || is_ssh=false

    # Git branch and status
    git_branch=$(git branch --show-current 2>/dev/null)
    git_status=$(git status --porcelain 2>/dev/null)

    # Last command exit code
    [[ $LAST_COMMAND -ne 0 ]] && is_failed=true || is_failed=false

    # ----------------------------------------------
    # Prepare the prompt blocks format
    # ----------------------------------------------

    local FMT_USER
    local FMT_DIR="${FG_CYAN}"
    local FMT_GIT="${FG_YELLOW}"

    local P_GIT
    local P_PROMPT

    # is_root=true
    # is_ssh=true

    # Is it an ssh connection?
    if [ "$is_ssh" = true ]; then
        FMT_BLOCK="${FMT_RESET}${BG_WHITE}${FG_BLACK}"
        FMT_DIR="${FG_YELLOW}"
    else
        FMT_BLOCK="${FMT_RESET}${BG_YELLOW}${FG_BLACK}"
    fi

    # Is the user root?
    if [ "$is_root" = true ]; then
        FMT_USER="${FG_RED}"
    else
        FMT_USER=""
    fi

    # Is the CWD a git repo?
    if [ "$git_branch" != "" ]; then
        local FMT_GIT_STATUS
        if [ "$git_status" != "" ]; then
            FMT_GIT_STATUS="${FG_RED}"
        else
            FMT_GIT_STATUS="${FG_GREEN}"
        fi
        P_GIT="${FMT_GIT} ···  ${git_branch} ${FMT_GIT_STATUS}● "
    fi

    # Did the last command fail?
    if [ "$is_failed" = true ]; then
        P_PROMPT="${FG_RED}❱❱❱"
    else
        P_PROMPT="${FG_RED}❱"
        P_PROMPT+="${FG_YELLOW}❱"
        P_PROMPT+="${FG_GREEN}❱"
    fi

    # ----------------------------------------------
    # Final prompt compilation
    # ----------------------------------------------

    PS1='${debian_chroot:+($debian_chroot)}\n'

    PS1+="${FMT_BLOCK} ${FMT_USER}\u@\h ${FMT_RESET} ${FMT_DIR}\w ${P_GIT} \n${P_PROMPT}${FMT_RESET} "
    # PS1+="${FMT_BLOCK} \t ${FMT_RESET} ${FMT_DIR}\w ${P_GIT} \n${P_PROMPT}${FMT_RESET} "

    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm* | rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *) ;;
    esac
}

function __set_fancy_prompt() {
    local LAST_COMMAND=$? # Must come first!

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
    xterm-color | *-256color) color_prompt=yes ;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    #force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    color_prompt=yes

    if [ "$color_prompt" = yes ]; then
        # define colors
        local FMT_BOLD="\[\e[1m\]"
        # local FMT_DIM="\[\e[2m\]"
        local FMT_RESET="\[\e[0m\]"
        local FMT_UNBOLD="\[\e[22m\]"
        # local FMT_UNDIM="\[\e[22m\]"
        local FG_BLACK="\[\e[30m\]"
        # local FG_BLUE="\[\e[34m\]"
        local FG_CYAN="\[\e[36m\]"
        local FG_GREEN="\[\e[32m\]"
        local FG_YELLOW="\[\e[33m\]"
        # local FG_GREY="\[\e[37m\]"
        # local FG_MAGENTA="\[\e[35m\]"
        local FG_RED="\[\e[31m\]"
        # local FG_WHITE="\[\e[97m\]"
        # local BG_BLACK="\[\e[40m\]"
        # local BG_BLUE="\[\e[44m\]"
        # local BG_CYAN="\[\e[46m\]"
        # local BG_GREEN="\[\e[42m\]"
        local BG_YELLOW="\[\e[43m\]"
        # local BG_MAGENTA="\[\e[45m\]"
        # local BG_RED="\[\e[41m\]"
        # local BG_WHITE="\[\e[107m\]"
    fi

    # Set the prompt

    PS1='${debian_chroot:+($debian_chroot)}\n'

    # timestamp
    PS1+="${BG_YELLOW}${FG_BLACK} \t "
    PS1+="${FMT_RESET}"

    # user
    local usercolor
    if [[ $EUID -ne 0 ]]; then
        usercolor="" # Normal user
    else
        usercolor="${FG_RED}" # Root user
    fi

    # ssh hostname
    local SSH_IP=$(echo "$SSH_CLIENT" | awk '{ print $1 }')
    local SSH2_IP=$(echo "$SSH2_CLIENT" | awk '{ print $1 }')
    if [ "$SSH2_IP" ] || [ "$SSH_IP" ]; then
        PS1+="${usercolor}\u${FMT_RESET}@${FG_YELLOW}\h "
    else
        if [ "$usercolor" ]; then
            PS1+="${usercolor}\u "
        fi
    fi

    # current directory
    PS1+="${FG_CYAN}${FMT_BOLD}"
    PS1+="\w "
    PS1+="${FMT_RESET}"

    # git branch and status
    local git_branch=$(git branch --show-current 2>/dev/null)
    if [ "$git_branch" != "" ]; then
        local git_color="${FG_GREEN}"
        local git_status=$(git status --porcelain 2>/dev/null)
        if [ "$git_status" != "" ]; then
            git_color="${FG_RED}"
        fi
        PS1+="${FG_YELLOW}${FMT_UNBOLD} ···  ${git_branch}"
        PS1+=" ${git_color}●"
    fi

    # newline
    PS1+="${FMT_RESET}"
    PS1+="\n"

    # prompt symbol
    PS1+="${FG_RED}"
    if [ $LAST_COMMAND != 0 ]; then
        PS1+="❱❱❱ "
    else
        PS1+="❱"
        PS1+="${FG_YELLOW}❱"
        PS1+="${FG_GREEN}❱"
        # PS1+=" ❱❱❱ "
    fi
    PS1+="${FMT_RESET} "
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm* | rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *) ;;
    esac
}

# PROMPT_COMMAND='__set_fancy_prompt'
PROMPT_COMMAND='__generate_fancy_prompt'
