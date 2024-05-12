#!/usr/bin/env bash
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

function __bash_precmd {
    if test -n "$IS_FIRST_PROMPT"; then
        PS1="$(prompt bash)"
        unset IS_FIRST_PROMPT
    else
        PS1="$(env PREPEND_WITH_NEWLINE=1 prompt bash)"
    fi

    export PS1
}

# Unsets after the first prompt
export IS_FIRST_PROMPT=1

PROMPT_COMMAND+=('__bash_precmd')
