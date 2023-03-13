export VISUAL=nano
export EDITOR=nano

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

WINEPREFIXES_DIR="$XDG_DATA_HOME/wineprefixes"
[ ! -d "$WINEPREFIXES_DIR" ] && mkdir -p "$WINEPREFIXES_DIR"
export WINEPREFIX="$WINEPREFIXES_DIR/default"

export QT_QPA_PLATFORM=wayland
