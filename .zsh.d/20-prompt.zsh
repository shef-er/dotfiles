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

setopt prompt_subst

# VCS Info
autoload -Uz vcs_info
precmd_functions+=( vcs_info )

zstyle ':vcs_info:*'                    enable git
# Format the vcs_info_msg_0_
zstyle ':vcs_info:git:*'                formats '%b'
#zstyle ':vcs_info:git:*'                formats ' ⎇ %b '
#zstyle ':vcs_info:git:*'                formats ' branch:%b '
#zstyle ':vcs_info:git:*'                formats '[%b]'


# Precommand (launches before each prompt)
function precmd {
  print -Pn "\e]0;%2~ %(1j,%j job%(2j|s|); ,)\a"
}


function custom_prompt {

  case `id -u` in
    0)
      local PROMPT=" %F{red}#%k%f%s"
      ;;
    *)
      local PROMPT=" %F{green}→%k%f%s"
      ;;
  esac

  local PROMPT_PATH=" %F{blue}%2~%k%f%s"
  #local PROMPT_VCS=" %F{blue}${vcs_info_msg_0_}%k%f%s"

  #local VCS="${vcs_info_msg_0_}"
  #vcs_info
  #[[ -n "$VCS" ]] && echo 'test'


  echo "${PROMPT_VCS}${PROMPT_PATH}${PROMPT}%k%f%s "
}

export PROMPT="$(custom_prompt)"

