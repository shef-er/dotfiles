for file in "$XDG_CONFIG_HOME"/zsh/rc.d/*.zsh; do
  [ -r "$file" ] && source "$file"
done

ttyctl -f
