#                            _      _   _
#   ___ ___  _ __ ___  _ __ | | ___| |_(_) ___  _ __
#  / __/ _ \| '_ ` _ \| '_ \| |/ _ \ __| |/ _ \| '_ \
# | (_| (_) | | | | | | |_) | |  __/ |_| | (_) | | | |
#  \___\___/|_| |_| |_| .__/|_|\___|\__|_|\___/|_| |_|
#                     |_|

export HISTFILE="$XDG_STATE_HOME"/zsh_history
export HISTSIZE=1000
export SAVEHIST=10000

AUTOSUGGESTIONS="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -r "$AUTOSUGGESTIONS" ] && source "$AUTOSUGGESTIONS"
unset AUTOSUGGESTIONS

setopt autocd completealiases
setopt appendhistory histignoredups histignorespace

autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zcompdump
_comp_options+=( globdots )

zstyle ':compinstall'                   filename "$XDG_CONFIG_HOME"/zsh/rc

zstyle ':completion:*'                  rehash true
zstyle ':completion:*'                  menu select

zstyle ':completion:*:pacman:*'         force-list always
zstyle ':completion:*:*:pacman:*'       menu yes select

zstyle ':completion:*:kill:*'           force-list always
zstyle ':completion:*:*:kill:*'         menu yes select

zstyle ':completion:*:killall:*'        force-list always
zstyle ':completion:*:*:killall:*'      menu yes select

zstyle ':completion:*:processes-names'  command  "ps c -u $USER -o command | uniq"
