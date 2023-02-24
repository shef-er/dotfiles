# vim: set syntax=zsh
#            _
#    _______| |__   ___ _ ____   __
#   |_  / __| '_ \ / _ \ '_ \ \ / /
#  _ / /\__ \ | | |  __/ | | \ V /
# (_)___|___/_| |_|\___|_| |_|\_/


if ! [[ "$GOPATH" =~ "$HOME/.local/go" ]] ; then
  export GOPATH="$HOME/.local/go"
fi

if ! [[ "$PATH" =~ "$HOME/.local/go/bin" ]] ; then
  export PATH="$HOME/.local/go/bin:$PATH"
fi

GOTELEMETRY=off

if ! [[ "$PATH" =~ "$HOME/.local/bin" ]] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

export VISUAL=nano
export EDITOR=nano

export QT_STYLE_OVERRIDE=GTK+
