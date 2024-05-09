#!/usr/bin/env zsh

function source_if_exists {
    test -r "$1" && source "$1"
}

if test -d "$XDG_CONFIG_HOME"/zshrc.d/; then
    for script in "$XDG_CONFIG_HOME"/zshrc.d/*; do
        source_if_exists "$script"
    done
    unset script
fi

unset -f source_if_exists

ttyctl -f
