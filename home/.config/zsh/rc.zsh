for file in ~/.config/zsh/rc.d/*.zsh; do
  source "$file"
done

ttyctl -f
