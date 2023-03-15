[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME"/.cache
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME"/.config
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME"/.local/share
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME"/.local/state

for env in "$XDG_CONFIG_HOME"/zsh/env.d/*.zsh; do
  [ -r "$env" ] && source "$env"
done
