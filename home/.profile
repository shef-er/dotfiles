#!/usr/bin/env sh

# Prepend "$1" to $PATH when not already in.
# This function API is accessible to scripts in ~/.config/profile.d
prepend_path () {
    case ":$PATH:" in
        *"$1":*)
            ;;
        *)
            PATH="$1:$PATH"
    esac
}

test -z "$XDG_CACHE_HOME" && export XDG_CACHE_HOME="$HOME"/.cache
test -z "$XDG_CONFIG_HOME" && export XDG_CONFIG_HOME="$HOME"/.config
test -z "$XDG_DATA_HOME" && export XDG_DATA_HOME="$HOME"/.local/share
test -z "$XDG_STATE_HOME" && export XDG_STATE_HOME="$HOME"/.local/state
test -z "$XDG_BIN_HOME" && export XDG_BIN_HOME="$HOME"/.local/bin

if test -d "$XDG_CONFIG_HOME"/profile.d/; then
    for profile in "$XDG_CONFIG_HOME"/profile.d/*; do
        # shellcheck disable=SC1090
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

prepend_path "$XDG_BIN_HOME"

# move to bashrc?
prepend_path "$XDG_CONFIG_HOME"/scripts

# Unload our profile API functions
unset -f prepend_path

export VISUAL=nano
export EDITOR="$VISUAL"
