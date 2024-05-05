#!/usr/bin/env zsh

function _source_if_file_exists {
    test -r "$1" && source "$1"
}

if test -d "$XDG_CONFIG_HOME"/zshrc.d/; then
    for script in "$XDG_CONFIG_HOME"/zshrc.d/*; do
        _source_if_file_exists "$script"
    done
    unset script
fi

ttyctl -f
