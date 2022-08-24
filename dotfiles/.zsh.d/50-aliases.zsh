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

alias h='fc -l'
alias j=jobs
alias m=less
alias g='egrep -i'
alias ls='ls --group-directories-first'
alias l='ls -aF'
alias ll='ls -lthF'
alias la='ls -lathF'
alias df='df -h'

# tar aliases
alias tarzip='unzip'
alias tarx='tar -xvf'
alias targz='tar -zxvf'
alias tarbz2='tar -jxvf'

# im paranoid
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'

# use neovim everywhere
alias vim='nvim'
alias vi='nvim'

# global aliases
alias -g N='2>/dev/null'
alias -g L='|less'
alias -g G='|grep'
alias -g W='|wc -m'

## aliases for extensions
#alias -s {avi,mpeg,mpg,mov,m2v,webm,flv,mkv,mp4}=gnome-mpv
#alias -s {odt,doc,sxw,rtf}=libreoffice
#alias -s {txt,xml,html,c,h,cpp,hpp}=$EDITOR

