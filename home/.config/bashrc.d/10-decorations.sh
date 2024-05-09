#!/usr/bin/env bash
#      _                          _   _
#   __| | ___  ___ ___  _ __ __ _| |_(_) ___  _ __  ___
#  / _` |/ _ \/ __/ _ \| '__/ _` | __| |/ _ \| '_ \/ __|
# | (_| |  __/ (_| (_) | | | (_| | |_| | (_) | | | \__ \
#  \__,_|\___|\___\___/|_|  \__,_|\__|_|\___/|_| |_|___/

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

  clear # remove background artifacts
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
