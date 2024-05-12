#!/usr/bin/env zsh
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

# Unsets after the first prompt
export IS_FIRST_PROMPT=1

function precmd {
    # terminal title
    print -Pn "\e]0;%2~ %(1j,%j job%(2j|s|); ,)\a"

    if test -n "$IS_FIRST_PROMPT"; then
        PROMPT="$(prompt zsh)"
        unset IS_FIRST_PROMPT
    else
        PROMPT="$(env PREPEND_WITH_NEWLINE=1 prompt zsh)"
    fi

    export PROMPT
}
