#!/usr/bin/env bash
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

export _NO_NEWLINE=1

function _prompt_pwd {
    local count src dir acc
    count="$1"
    src="${PWD/#"$HOME"/'~'}"
    for ((i = 1; i <= count; i++)); do
        dir="${src##*/}"
        acc="$dir/$acc"
        src="${src%/"$dir"}"

        [ "$dir" = "$src" ] && break
        [ -z "$src" ] && acc="/$acc" && break
    done
    echo -n "${acc%/}"
}

function _prompt_precmd {
    local bold reset
    bold="\[$(tput bold)\]"
    reset="\[$(tput sgr0)\]"

    # prompt
    PS1=""
    if [ -z "$_NO_NEWLINE" ]; then
        PS1+=$'\n'
    else
        unset _NO_NEWLINE
    fi
    PS1+="$bold $(_prompt_pwd 2) > $reset"

    # title
    /usr/bin/echo -en "\033]0; $(pwd)\007"
}

PROMPT_COMMAND+=('_prompt_precmd')
