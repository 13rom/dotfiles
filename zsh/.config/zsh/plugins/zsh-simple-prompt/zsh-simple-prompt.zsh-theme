#!/bin/zsh
# Load Version Control Information, even if it already loaded, z specified Z shell script
autoload -Uz vcs_info

# Load colors function, provided by zsh -- remove
autoload -U colors && colors

# Enable style options for git via the vcs_info plugin 
zstyle ':vcs_info:*' enable git 

# Z shell function to display information about the current vcs info
# Whenever the function is run it will automatically run the vcs_info and display the information
precmd_vcs_info() { vcs_info }

# The precmd_functions variable is typically used to display information or perform other tasks just before the command prompt is displayed.
# separate  multiple functions with commas
precmd_functions+=( precmd_vcs_info )

# The prompt_subst option enables prompt substitution,
# which allows you to include the output of commands in the prompt string.
# When prompt substitution is enabled, you can use the $(...) syntax to include the output of a command in the PROMPT variable.
setopt prompt_subst

# Enable displaying uncommited files with git-uncommited hook
zstyle ':vcs_info:git*+set-message:*' hooks git-uncommited

# +vi-git-uncommited is a hook that is used in the Z shell (zsh) to display the status of uncommited files in a Git repository
# Display an asterisk if there are uncommited files in a git repo
+vi-git-uncommited(){
if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git status --porcelain | wc -l) != 0 ]] ; then
  hook_com[unstaged]='󰛄' # signify uncommited files
fi
}

# Use hook to check for changes in git
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
# zstyle ':vcs_info:*' unstagedstr '*'
# zstyle ':vcs_info:*' stagedstr '*'

# Apply color to vsc_info in prompt
# %m - name of current branch
# %u - status of current branch
# %c - number of commits ahead/behind the upstream branch
# zstyle ':vcs_info:git:*' formats "%F{15}on%{$reset_color%} %F{3}%b%F{4}%F{4}%F{6} %m%u%c%F{3}%{$reset_color%}"
# zstyle ':vcs_info:git:*' formats "%F{yellow} %{$reset_color%} %F{3}%b %F{4}%F{4}%F{6}%m%u%c%F{3}%{$reset_color%}"
zstyle ':vcs_info:git:*' formats "%F{yellow} %{$reset_color%} %F{3}%b %F{magenta}%u %m%F{3}%{$reset_color%}"

# To access colors by number in the Z shell (zsh) prompt, 
# you can use the %F{number} and %K{number} escape sequences to set the foreground (text) and background colors, respectively.

# time="%F{4}%*%{$reset_color%}"
# machine="%F{4}%m%{$reset_color%}"
# at="%F{15}at%{$reset_color%}"
# at="%F{yellow}󰋜%{$reset_color%}"     # home icon
at="%F{yellow}%{$reset_color%}" # circle arrow
# relativeHome="%F{4}%~%{$reset_color%}"
# relativeHome="%F{4}%(4~|.../%3~|%~)%{$reset_color%}"
# relativeHome="%F{4}%(5~|%-1~/.../%3~|%4~)%{$reset_color%}" # show first and last three directories: /usr/.../share/zsh/site-functions
relativeHome="%F{4}%50<...<%~%<<%{$reset_color%}"           # trim directory path to 50 characters
carriageReturn=""$'\n'""
emptyLineBottom="%r"
chevronRight=""
cmdPrompt="%(?:%F{2}${chevronRight} :%F{1}${chevronRight} )"
git_info="\$vcs_info_msg_0_"

function separator() {
  # tput setaf to set to terminal color 0
  # printf command is used to format and print text to the terminal
  # The %*s format specifier is used to print a string, where the * indicates that the width of the string should be specified as an argument
  # The ${COLUMNS:-$(tput cols)} expression is used to determine the width of the terminal window.
  # The COLUMNS variable is set by the shell to the number of columns in the terminal window, and the tput cols command retrieves the number of columns in the terminal window. The :- operator is used to set a default value for the COLUMNS variable if it is not set. In this case, the default value is the output of the tput cols command, which retrieves the number of columns in the terminal window.
  # the tr command is used to replace all spaces in the input string with -
  separation_line=$(tput setaf 240; printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
  echo "${separation_line}"
}

function precmd() {
  separator
}

# PROMPT="${machine} ${at} ${relativeHome} ${git_info} ${carriageReturn}${cmdPrompt}"
PROMPT="${at}  ${relativeHome} ${git_info} ${carriageReturn}${cmdPrompt}"
# PROMPT="${relativeHome} ${git_info} ${carriageReturn}${cmdPrompt}"
