#!/usr/bin/env bash
######################################################################
#
#
#           ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
#           ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
#           ██████╔╝███████║███████╗███████║██████╔╝██║
#           ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
#           ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
#           ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝
#
#
######################################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

######################################################################
# BASHRC DIRECTORY
# Use .bashrc.d directory instead of bloated .bashrc file
# From: https://waxzce.medium.com/use-bashrc-d-directory-instead-of-bloated-bashrc-50204d5389ff
######################################################################

BASHRC_DIR="${XDG_CONFIG_HOME}/bash"
# Optionally create directory if not exists
if [ ! -d "${BASHRC_DIR}" ]; then
    mkdir -p "${BASHRC_DIR}"
    chmod 700 "${BASHRC_DIR}"
fi
# Load any *.bashrc files in ~/.config/bash
if [ -d "${BASHRC_DIR}" ]; then
    for file in ${BASHRC_DIR}/*.bashrc; do
        source "${file}"
    done
fi
