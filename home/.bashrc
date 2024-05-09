#!/usr/bin/env bash

if test -d "$XDG_CONFIG_HOME"/bashrc.d/; then
    for script in "$XDG_CONFIG_HOME"/bashrc.d/*; do
        test -r "$script" && source "$script"
    done
    unset script
fi
