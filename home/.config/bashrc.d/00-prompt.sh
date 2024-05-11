#!/usr/bin/env bash
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|

function precmd {
    red=''
    grn=''
    blu=''
    cyn=''
    rst=''
    if test -x '/usr/bin/tput'; then
        bld="\[$(/usr/bin/tput bold)\]"
        red="\[$bld$(/usr/bin/tput setaf 1)\]"
        grn="\[$bld$(/usr/bin/tput setaf 2)\]"
        blu="\[$bld$(/usr/bin/tput setaf 4)\]"
        cyn="\[$bld$(/usr/bin/tput setaf 6)\]"
        unset bld
        rst="\[$(/usr/bin/tput sgr0)\]"
    fi

    PS1="$rst"
    if test -n "$IS_FIRST_PROMPT"; then
        unset IS_FIRST_PROMPT
    else
        PS1+=$'\n'
    fi

    local pwd
    local prompt_pwd
    pwd="$(pwd)"
    case "$pwd" in
        "$HOME")
            prompt_pwd='~'
            ;;
        "$HOME"/*/*)
            prompt_pwd="${pwd#"${pwd%/*/*}/"}"
            ;;
        "$HOME"/*)
            prompt_pwd=~/"${pwd##*/}"
            ;;
        *)
            prompt_pwd="${pwd#"${pwd%/*/*}/"}"
            ;;
    esac
    PS1+="$blu$prompt_pwd$rst "

    git="$(prompt-git)"
    if test -n "$git"; then
        PS1+="$cyn$git$rst "
    fi

    PS1+=$'\n'

    if test "$(id -u)" -eq 0; then
        PS1+="$red#$rst "
    else
        PS1+="$grn>$rst "
    fi

    export PS1
}

# Unsets after the first prompt
export IS_FIRST_PROMPT=1

# If this variable is set, and is an array, the value of each set element is executed as a
# command prior to issuing each primary prompt. If this is set but not an array variable, 
# its value is used as a command to execute instead.
PROMPT_COMMAND+=('precmd')
