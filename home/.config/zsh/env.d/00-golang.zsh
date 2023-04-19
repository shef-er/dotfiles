#              _
#   __ _  ___ | | __ _ _ __   __ _
#  / _` |/ _ \| |/ _` | '_ \ / _` |
# | (_| | (_) | | (_| | | | | (_| |
#  \__, |\___/|_|\__,_|_| |_|\__, |
#  |___/                     |___/ 
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

GODIR="$XDG_DATA_HOME"/go
if [[ "$GOPATH" != "$GODIR" ]] ; then
  export GOPATH="$GODIR"
fi

GOBINDIR="$GOPATH"/bin
if ! [[ "$PATH" =~ "$GOBINDIR" ]] ; then
  export PATH="$PATH:$GOBINDIR"
fi
