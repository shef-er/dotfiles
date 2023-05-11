#   __ _  ___
#  / _` |/ _ \
# | (_| | (_) |
#  \__, |\___/
#  |___/

GODIR="$XDG_DATA_HOME"/go
if [ "$GOPATH" != "$GODIR" ] ; then
  export GOPATH="$GODIR"
fi

GOBINDIR="$GOPATH"/bin
if ! [[ "$PATH" =~ "$GOBINDIR" ]] ; then
  export PATH="$PATH:$GOBINDIR"
fi
