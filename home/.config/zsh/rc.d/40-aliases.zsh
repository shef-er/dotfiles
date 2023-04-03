#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/

alias sudo='sudo '

alias pacman='sudo pacman'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias dmesg='dmesg --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gcc='gcc -fdiagnostics-color=auto'
alias dir='dir --color=auto'

alias ls='ls --group-directories-first --color'
alias l='ls -aF'
alias ll='ls -lthF'
alias la='ls -lathF'
alias df='df -h'

# tar aliases
alias tarx='tar -xvf'
alias targz='tar -zxvf'
alias tarbz2='tar -jxvf'

# im paranoid
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'
