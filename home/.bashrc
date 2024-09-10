#!/usr/bin/env bash

# Should be near top
[[ $- == *i* ]] && source "$HOME/.local/share/blesh/ble.sh"

# Just usual bash config
if test -d "$XDG_CONFIG_HOME"/bashrc.d/; then
    for script in "$XDG_CONFIG_HOME"/bashrc.d/*; do
        test -r "$script" && source "$script"
    done
    unset script
fi

# Should be the last line
[[ ! ${BLE_VERSION-} ]] || ble-attach
