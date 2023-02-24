#              _                   
#   __ _  ___ | | __ _ _ __   __ _ 
#  / _` |/ _ \| |/ _` | '_ \ / _` |
# | (_| | (_) | | (_| | | | | (_| |
#  \__, |\___/|_|\__,_|_| |_|\__, |
#  |___/                     |___/ 
#
#          ,_---~~~~~----._         
#   _,,_,*^____      _____``*g*\"*, 
#  / __/ /'     ^.  /      \ ^@q   f 
# [  @f | @))    |  | @))   l  0 _/  
#  \`/   \~____ / __ \_____/    \   
#   |           _l__l_           I   
#   }          [______]           I  
#   ]            | | |            |  
#   ]             ~ ~             |  
#   |                            |   
#    |                           |   

if ! [[ "$GOPATH" =~ "$HOME/.local/go" ]] ; then
  export GOPATH="$HOME/.local/go"
fi

if ! [[ "$PATH" =~ "$HOME/.local/go/bin" ]] ; then
  export PATH="$HOME/.local/go/bin:$PATH"
fi

GOTELEMETRY=off
