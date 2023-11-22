#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|
#
# %F{color} - fg color
# %K{color} - bg color
# %S        - swap text and bg colors
# %B        - bright color variant
# %f        - reset fg color
# %k        - reset bg color
# %s        - reset color swapping
# %b        - reset bright color
#
# Colors:
#   0:black, 1:red, 2:green, 3:yellow, 4:blue, 5:magent, 6:cyan, 7:white

setopt PROMPT_SUBST

autoload -Uz colors && colors

export _first_prompt=1

function load_git_info {
  git --version &>/dev/null || return 1

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

  if [ "$_first_prompt" -eq 1 ]; then
    export _first_prompt=0
    PROMPT=""
  else
    PROMPT=$'\n'
  fi

  PROMPT+="%B%F{blue}%2~%f%b "

  if [ "$git_info_head" ]; then
    PROMPT+="%B%F{cyan}$git_info_head%f%b "
  else
    PROMPT+=""
  fi

  PROMPT+="%B%(!.%F{red}#.%F{green}%%)%f%b "
  export PROMPT
}
