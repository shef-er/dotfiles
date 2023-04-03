#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|
#
# Colors:
#   0:black, 1:red, 2:green, 3:yellow,
#   4:blue, 5:magent, 6:cyan, 7:white
#
# %F{color} - fg color
# %K{color} - bg color
# %S        - swap text and bg colors
# %B        - bright color variant
#
# %f        - reset fg color
# %k        - reset bg color
# %s        - reset color swapping
# %b        - reset bright color

unsetopt beep
setopt prompt_subst

autoload -Uz colors && colors

function load_git_info {
  git --version &>/dev/null || exit 0

  local _git_branch="$(git branch --show-current 2> /dev/null)"
  local _git_head="$(git rev-parse --short HEAD 2> /dev/null)"

  if [ "$_git_branch" ]; then
   export git_info_head="$_git_branch"
  else
   export git_info_head="$_git_head"
  fi
}

function precmd {
  load_git_info

  print -Pn "\e]0;%2~ %(1j,%j job%(2j|s|); ,)\a"

  PROMPT=""
  PROMPT+="%B%F{blue}%2~%f%b "

  if [ "$git_info_head" ]; then
    PROMPT+="%B%F{cyan}$git_info_head%f%b "
  else
    PROMPT+=""
  fi

  PROMPT+="%B%(!.%F{red}#.%F{green}%%)%f%b "
  export PROMPT
}

# TTY colors
if [ "$TERM" = "linux" ]; then
  echo -en "\e]P0121212" # black
  echo -en "\e]P1FF005F" # dark red
  echo -en "\e]P25FD700" # dark green
  echo -en "\e]P3FFAF00" # dark yellow
  echo -en "\e]P40087D7" # dark blue
  echo -en "\e]P58700D7" # dark magenta
  echo -en "\e]P600D7D7" # dark cyan
  echo -en "\e]P7BCBCBC" # light grey

  echo -en "\e]P8767676" # dark grey
  echo -en "\e]P9FF00AF" # red
  echo -en "\e]PA87FF00" # green
  echo -en "\e]PBFFD75F" # yellow
  echo -en "\e]PC5FAFFF" # blue
  echo -en "\e]PDAF5fff" # magenta
  echo -en "\e]PE5fffff" # cyan
  echo -en "\e]PFFFFFFF" # white

  clear #remove background artifacts
fi

man() {
  env \
  LESS_TERMCAP_mb=$'\e[1;34m' \
  LESS_TERMCAP_md=$'\e[1;34m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[47;30m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[4;96m' \
  man "$@"
}