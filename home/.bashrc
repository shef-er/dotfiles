#!/usr/bin/env bash

# Should be near top
# shellcheck disable=SC1090
# shellcheck disable=SC1091
# [ -f "/usr/share/blesh/ble.sh" ] &&
#     source "/usr/share/blesh/ble.sh" --noattach

# Just plain bash config
if [ -d "$XDG_CONFIG_HOME"/bashrc.d/ ]; then
    for script in "$XDG_CONFIG_HOME"/bashrc.d/*; do
        # shellcheck disable=SC1090
        [ -r "$script" ] && source "$script"
    done
    unset script
fi

# Should be the last line
# [[ ! ${BLE_VERSION-} ]] || ble-attach
