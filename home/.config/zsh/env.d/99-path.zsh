if ! [[ "$PATH" =~ "$HOME/.local/bin" ]] ; then
  export PATH="$HOME/.local/bin:$PATH"
fi
