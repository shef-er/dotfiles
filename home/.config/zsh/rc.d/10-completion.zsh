#                            _      _   _
#   ___ ___  _ __ ___  _ __ | | ___| |_(_) ___  _ __
#  / __/ _ \| '_ ` _ \| '_ \| |/ _ \ __| |/ _ \| '_ \
# | (_| (_) | | | | | | |_) | |  __/ |_| | (_) | | | |
#  \___\___/|_| |_| |_| .__/|_|\___|\__|_|\___/|_| |_|
#                     |_|

HISTFILE="$XDG_STATE_HOME"/zsh_history
HISTSIZE=50000
SAVEHIST=50000

unsetopt BEEP
setopt AUTO_CD
setopt COMPLETE_ALIASES
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

_comp_options+=(globdots)

autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zcompdump

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
