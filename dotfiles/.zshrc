# vim: set syntax=zsh
#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

for file in ~/.zsh.d/*.zsh; do
  source "$file"
done

ttyctl -f

