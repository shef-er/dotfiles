#!/usr/bin/env zsh
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|
#
# %F{color} - fg color
# %K{color} - bg color
# %B        - bright color
# %f        - reset fg color
# %k        - reset bg color
# %b        - reset bright color
#
# Colors:
#   0:black, 1:red, 2:green, 3:yellow, 4:blue, 5:magent, 6:cyan, 7:white

# Unsets after the first prompt
export IS_FIRST_PROMPT=1

function precmd {
    # terminal title
    print -Pn "\e]0;%2~ %(1j,%j job%(2j|s|); ,)\a"

    PROMPT=""
    if test -n "$IS_FIRST_PROMPT"; then
        unset IS_FIRST_PROMPT
    else
        PROMPT+=$'\n'
    fi

    PROMPT+="%B%F{4}%2~%f%b "

    git=$(prompt-git)
    if test -n "$git"; then
        PROMPT+="%B%F{6}$git%f%b "
    fi

    PROMPT+=$'\n'

    PROMPT+="%B%(!.%F{1}#.%F{2}>)%f%b "
}
