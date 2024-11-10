#!/usr/bin/env sh

# Prepend "$1" to $PATH when not already in.
# This function is accessible to scripts in ~/.config/profile.d
path_prepend() {
    case ":$PATH:" in
    *"$1":*) ;;
    *) PATH="$1:$PATH" ;;
    esac
}

[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME"/.cache
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME"/.config
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME"/.local/share
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME"/.local/state
[ -z "$XDG_BIN_HOME" ] && export XDG_BIN_HOME="$HOME"/.local/bin

if [ -d "$XDG_CONFIG_HOME"/profile.d/ ]; then
    for profile in "$XDG_CONFIG_HOME"/profile.d/*; do
        # shellcheck disable=SC1090
        [ -r "$profile" ] && . "$profile"
    done
    unset profile
fi

path_prepend "$XDG_BIN_HOME"

# move to bashrc?
path_prepend "$XDG_CONFIG_HOME"/scripts

# Unload profile API functions
unset -f path_prepend
