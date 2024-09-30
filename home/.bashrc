#!/usr/bin/env bash

# Should be near top
BLESH_INSTALL_PATH="$HOME/.local/share/blesh/ble.sh"
# shellcheck disable=SC1090
[[ $- == *i* ]] && [ -f "$BLESH_INSTALL_PATH" ] && source "$BLESH_INSTALL_PATH"

# Just plain bash config
if test -d "$XDG_CONFIG_HOME"/bashrc.d/; then
    for script in "$XDG_CONFIG_HOME"/bashrc.d/*; do
        # shellcheck disable=SC1090
        [ -r "$script" ] && source "$script"
    done
    unset script
fi

# Should be the last line
[[ ! ${BLE_VERSION-} ]] || ble-attach
