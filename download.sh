#!/bin/sh

# ~/.dotfiles/download.sh: Download dotfiles from github and run installer script

# -e: exit on error
# -u: exit on unset variables
set -eu

# Set DOTFILES variables
DOTFILES_REPO_HOST=${DOTFILES_REPO_HOST:-"https://github.com"}
DOTFILES_USER=${DOTFILES_USER:-"13rom"}
DOTFILES_REPO="${DOTFILES_REPO_HOST}/${DOTFILES_USER}/dotfiles"
DOTFILES_BRANCH=${DOTFILES_BRANCH:-"master"}
DOTFILES_DIR="${HOME}/.dotfiles"

log() {
  echo "$@"
}

error() {
  echo "ERROR: " "$@"
  exit 1
}

git_clean() {
  path=$(realpath "$1")
  remote="$2"
  branch="$3"

  log "Cleaning '${path}' with '${remote}' at branch '${branch}'"
  git="git -C ${path}"
  # Ensure that the remote is set to the correct URL
  if ${git} remote | grep -q "^origin$"; then
    ${git} remote set-url origin "${remote}"
  else
    ${git} remote add origin "${remote}"
  fi
  ${git} checkout -B "${branch}"
  ${git} fetch origin "${branch}"
  ${git} reset --hard FETCH_HEAD
  ${git} clean -fdx
  unset path remote branch git
}

# MAIN PROGRAM STARTS HERE

if ! command -v git >/dev/null 2>&1; then
  error "Git is not installed."
fi

if [ -d "${DOTFILES_DIR}" ]; then
  git_clean "${DOTFILES_DIR}" "${DOTFILES_REPO}" "${DOTFILES_BRANCH}"
else
  log "Cloning '${DOTFILES_REPO}' at branch '${DOTFILES_BRANCH}' to '${DOTFILES_DIR}'"
  git clone --branch "${DOTFILES_BRANCH}" "${DOTFILES_REPO}" "${DOTFILES_DIR}"
fi

if [ -f "${DOTFILES_DIR}/install.sh" ]; then
  INSTALL_SCRIPT="${DOTFILES_DIR}/install.sh"
elif [ -f "${DOTFILES_DIR}/install" ]; then
  INSTALL_SCRIPT="${DOTFILES_DIR}/install"
else
  error "No install script found in the dotfiles."
fi

log "Running '${INSTALL_SCRIPT}'"
exec "${INSTALL_SCRIPT}" "$@"
