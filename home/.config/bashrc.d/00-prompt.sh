#!/usr/bin/env bash
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

# Unsets after the first prompt
export _NO_NEWLINE=1

function __precmd {
    PS1="$(prompt bash)"

    if test -n "$_NO_NEWLINE"; then
        unset _NO_NEWLINE
    fi
}

PROMPT_COMMAND+=('__precmd')
