#           _
# __      _(_)_ __   ___
# \ \ /\ / / | '_ \ / _ \
#  \ V  V /| | | | |  __/
#   \_/\_/ |_|_| |_|\___|

WINEPREFIXES_DIR="$XDG_DATA_HOME"/wineprefixes
[ ! -d "$WINEPREFIXES_DIR" ] && mkdir -p "$WINEPREFIXES_DIR"

export WINEPREFIX="$WINEPREFIXES_DIR"/default
unset WINEPREFIXES_DIR
