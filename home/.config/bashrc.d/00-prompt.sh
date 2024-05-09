#!/usr/bin/env bash
#                                  _
#  _ __  _ __ ___  _ __ ___  _ __ | |_
# | '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
# | |_) | | | (_) | | | | | | |_) | |_
# | .__/|_|  \___/|_| |_| |_| .__/ \__|
# |_|                       |_|
#

function git_info() {
    local info=""

    if ! command -v git &>/dev/null; then
        echo $info
        return 1
    fi

    local git_head="$(command git rev-parse --short HEAD 2> /dev/null)"
    local git_branch="$(command git branch --show-current 2> /dev/null)"

    if test -n "$git_branch"; then
        info+="$git_branch"
    else
        info+="$git_head"
    fi

    local git_index="$(command git status --porcelain -b 2> /dev/null)"

    # has work tree changes
    if
        echo "$git_index" | command grep -E '^\?\? ' &> /dev/null || \
        echo "$git_index" | command grep '^ [AMDRC] ' &> /dev/null || \
        echo "$git_index" | command grep '^[ MTARC][MTD] ' &> /dev/null
    then
        info+="*"
    fi
 
    # has indexed changes
    if
        echo "$git_index" | command grep '^[MTARC][ MTD] ' &> /dev/null || \
        echo "$git_index" | command grep '^D  ' &> /dev/null
    then
        info+="+"
    fi

    local git_revs_ahead=$(command git rev-list --count ${git_branch}@{upstream}..HEAD 2>/dev/null)
    local git_revs_behind=$(command git rev-list --count HEAD..${git_branch}@{upstream} 2>/dev/null)

    if (( $git_revs_ahead )) && (( $git_revs_behind )); then
        info+=" ><"
    elif (( $git_revs_ahead )); then
        info+=" ->"
    elif (( $git_revs_behind )); then
        info+=" <-"
    fi

    echo $info
}

function prompt_workdir {
    case "$PWD" in
        $HOME)
            echo "~"
            ;;
        $HOME/*/*)
            echo "${PWD#"${PWD%/*/*}/"}"
            ;;
        $HOME/*)
            echo "~/${PWD##*/}"
            ;;
        *)
            echo "${PWD#"${PWD%/*/*}/"}"
            ;;
    esac
}

function precmd {
    local blk="\[$(tput setaf 0)\]"
    local red="\[$(tput setaf 1)\]"
    local grn="\[$(tput setaf 2)\]"
    local ylw="\[$(tput setaf 3)\]"
    local blu="\[$(tput setaf 4)\]"
    local mgt="\[$(tput setaf 5)\]"
    local cyn="\[$(tput setaf 6)\]"
    local wht="\[$(tput setaf 7)\]"
    local bld="\[$(tput bold)\]"
    local rst="\[$(tput sgr0)\]"

    # prompt initialization
    PS1="$rst"
    if test -n "$IS_FIRST_PROMPT"; then
        unset IS_FIRST_PROMPT
    else
        PS1+=$'\n'
    fi

    # show working directory
    PS1+="$bld$blu$(prompt_workdir)$rst "

    # show git info
    GIT_STATUS="$(git_info)"
    if test -n "$GIT_STATUS"; then
        PS1+="$bld$cyn$GIT_STATUS$rst "
    fi

    # new line
    PS1+=$'\n'

    if test $(id -u) -eq 0; then
        PS1+="$bld$red#$rst "
    else
        PS1+="$bld$grn%$rst "
    fi

    export PS1
}

# Exists until the first prompt
export IS_FIRST_PROMPT=1

# If this variable is set, and is an array, the value of each set element is executed as a
# command prior to issuing each primary prompt. If this is set but not an array variable, 
# its value is used as a command to execute instead.
PROMPT_COMMAND+=('precmd')
