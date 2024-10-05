#!/usr/bin/env bash
#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/

if command -v pacman &> /dev/null; then
    # i use arch, btw
    alias pacman='sudo pacman'
fi

# if command -v flatpak &> /dev/null; then
#     alias flatpak='flatpak --user'
# fi

# shell is my file manager
alias ls='ls -lahF --group-directories-first --color=auto --time-style=long-iso'
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

alias dmesg='dmesg --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gcc='gcc -fdiagnostics-color=auto'
alias dir='dir --color=auto'
