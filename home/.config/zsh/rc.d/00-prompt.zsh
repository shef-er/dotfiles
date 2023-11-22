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

export _ZSH_IS_FIRST_PROMPT=1

function precmd {
  # retrieve git info
  if command -v git &>/dev/null; then
    local _git_branch="$(git branch --show-current 2> /dev/null)"
    local _git_head="$(git rev-parse --short HEAD 2> /dev/null)"

    if [ "$_git_branch" ]; then
      local _git_info="$_git_branch"
    else
      local _git_info="$_git_head"
    fi
  fi

  # terminal title
  print -Pn "\e]0;%2~ %(1j,%j job%(2j|s|); ,)\a"

  # prompt initalization
  if [ "$_ZSH_IS_FIRST_PROMPT" -eq 1 ]; then
    PROMPT=""
  else
    PROMPT=$'\n'
  fi

  # show current working directory
  PROMPT+="%B%F{blue}%2~%f%b "

  # show git info
  if [ "$_git_info" ]; then
    PROMPT+="%B%F{cyan}$_git_info%f%b "
  else
    PROMPT+=""
  fi

  # show prompt sign
  PROMPT+="%B%(!.%F{red}#.%F{green}%%)%f%b "

  export PROMPT
  export _ZSH_IS_FIRST_PROMPT=0
}
