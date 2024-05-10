#!/usr/bin/env bash
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

# Unsets after the first prompt
export IS_FIRST_PROMPT=1

function precmd {
    if test -n "$IS_FIRST_PROMPT"; then
        PS1=$(env CURRENT_SHELL=bash prompt)
        unset IS_FIRST_PROMPT
    else
        PS1=$(env CURRENT_SHELL=bash PREPEND_WITH_NEWLINE=1 prompt)
    fi
    export PS1
}

# If this variable is set, and is an array, the value of each set element is executed as a
# command prior to issuing each primary prompt. If this is set but not an array variable, 
# its value is used as a command to execute instead.
PROMPT_COMMAND+=('precmd')
