# vim: set syntax=zsh
#            _
#    _______| |__   ___ _ ____   __
#   |_  / __| '_ \ / _ \ '_ \ \ / /
#  _ / /\__ \ | | |  __/ | | \ V /
# (_)___|___/_| |_|\___|_| |_|\_/

if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR=nano

# for qt5 apps
export QT_STYLE_OVERRIDE=GTK+

