#!/usr/bin/env zsh
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

eval "$(ku init zsh)"

function precmd {
    # terminal title
    print -Pn "\e]0;%2~ %(1j,%j job%(2j|s|); ,)\a"
}
