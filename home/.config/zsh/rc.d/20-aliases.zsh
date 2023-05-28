#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/

# A trailing space causes the next word to be checked for alias substitution 
# when the alias is expanded
alias sudo='sudo '

# i use arch, btw
alias pacman='sudo pacman'

# shell is my file manager
alias ls='ls -lAhF --group-directories-first --color=auto --time-style=long-iso'
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

alias tarx='tar -v -xf'
alias targzx='tar -v -xzf'
alias tarbz2x='tar -v -xjf'

alias dmesg='dmesg --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gcc='gcc -fdiagnostics-color=auto'
alias dir='dir --color=auto'
