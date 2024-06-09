#!/usr/bin/env bash

# ~/.dotfiles/install.sh: Stow all packages

# -e: exit on error
# -u: exit on unset variables
set -eu

log() {
  echo -e "$@"
}

error() {
  echo "ERROR: " "$@"
  exit 1
}

###############################################################################
# Create initial directories
###############################################################################

# mkdir -p "${HOME}/.config/zsh" "${HOME}/.cache/zsh" \
#     "${HOME}/.local/bin" "${HOME}/.local/share" \
#     "${HOME}/.local/state" "${HOME}/.vim/spell"

log "Stowing files in ${PWD}..."

cd ~/.dotfiles
for file in ~/.dotfiles/*; do
  if [ -d "${file}" ]; then
    stow -R "$(basename ${file})"
    log "  ● $(basename ${file}) stowed"
  fi
done
cd - >/dev/null

log "All packages stowed or re-stowed."
