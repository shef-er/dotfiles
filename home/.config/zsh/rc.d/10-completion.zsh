#                            _      _   _
#   ___ ___  _ __ ___  _ __ | | ___| |_(_) ___  _ __
#  / __/ _ \| '_ ` _ \| '_ \| |/ _ \ __| |/ _ \| '_ \
# | (_| (_) | | | | | | |_) | |  __/ |_| | (_) | | | |
#  \___\___/|_| |_| |_| .__/|_|\___|\__|_|\___/|_| |_|
#                     |_|

ZSH_AUTOSUGGESTIONS="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -f "$ZSH_AUTOSUGGESTIONS" ]]; then
  source "$ZSH_AUTOSUGGESTIONS"
fi

setopt completealiases
setopt autocd 
# setopt extendedglob

autoload -Uz compinit
_comp_options+=( globdots )

ZSH_CACHE="$HOME/.cache/zsh"
mkdir -p "$ZSH_CACHE"
compinit -d "$ZSH_CACHE/zcompdump-$ZSH_VERSION"

zstyle ':compinstall'                   filename "$HOME/.config/zsh/rc.zsh"

zstyle ':completion:*'                  rehash true
zstyle ':completion:*'                  menu select

zstyle ':completion:*:pacman:*'         force-list always
zstyle ':completion:*:*:pacman:*'       menu yes select

zstyle ':completion:*:kill:*'           force-list always
zstyle ':completion:*:*:kill:*'         menu yes select

zstyle ':completion:*:killall:*'        force-list always
zstyle ':completion:*:*:killall:*'      menu yes select

zstyle ':completion:*:processes-names'  command  "ps c -u $USER -o command | uniq"
