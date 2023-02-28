BINDIR="$HOME/.local/bin"
if ! [[ "$PATH" =~ "$BINDIR" ]] ; then
  export PATH="$BINDIR:$PATH"
fi
