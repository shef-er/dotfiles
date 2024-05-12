#!/usr/bin/env zsh
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

# Unsets after the first prompt
export _NO_NEWLINE=1

function prompt_ku_precmd {
    PROMPT="$(ku prompt zsh)"

    if test -n "$_NO_NEWLINE"; then
        unset _NO_NEWLINE
    fi
}

autoload -Uz add-zsh-hook && add-zsh-hook precmd prompt_ku_precmd

function precmd {
    # terminal title
    print -Pn "\e]0;%2~ %(1j,%j job%(2j|s|); ,)\a"
}
