#  _              _ _
# | |_ ___   ___ | | |__   _____  __
# | __/ _ \ / _ \| | '_ \ / _ \ \/ /
# | || (_) | (_) | | |_) | (_) >  <
#  \__\___/ \___/|_|_.__/ \___/_/\_\

TOOLBOX_PATH="$XDG_DATA_HOME"/JetBrains/Toolbox/scripts
if ! [[ "$PATH" =~ "$TOOLBOX_PATH" ]] ; then
  export PATH="$PATH:$TOOLBOX_PATH"
fi
