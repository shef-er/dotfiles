#!/usr/bin/env bash
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

function _prompt_pwd {
    local count src dir acc
    count="${1:-99}"
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

    PS1="$bold $(_prompt_pwd 2) $ $reset"
}
PROMPT_COMMAND+=('_prompt_precmd')


# If no command running: shows current $PWD in terminal title, 
# else: shows current $BASH_COMMAND in terminal title
function _title_precmd {
    /usr/bin/echo -en "\033]0; $PWD\007"
}
PROMPT_COMMAND+=('_title_precmd')
trap 'echo -ne "\e]0;$BASH_COMMAND\007"' DEBUG
