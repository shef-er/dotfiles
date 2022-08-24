# vim: set syntax=zsh
#            _
#    _______| |__   ___ _ ____   __
#   |_  / __| '_ \ / _ \ '_ \ \ / /
#  _ / /\__ \ | | |  __/ | | \ V /
# (_)___|___/_| |_|\___|_| |_|\_/

if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Added by Toolbox App
export PATH="$PATH:/home/erik/.local/share/JetBrains/Toolbox/scripts"

export EDITOR=nano

# for qt5 apps
export QT_STYLE_OVERRIDE=GTK+

# for java apps
#export JAVA_FONTS=/usr/share/fonts/TTF
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

