#!/usr/bin/env bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d "$XDG_CONFIG_HOME"/bashrc.d/ ]; then
    for script in "$XDG_CONFIG_HOME"/bashrc.d/*; do
        # shellcheck disable=SC1090
        [ -r "$script" ] && source "$script"
    done
    unset script
fi
