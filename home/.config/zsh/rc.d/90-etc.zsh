#       _
#   ___| |_ ___
#  / _ \ __/ __|
# |  __/ || (__
#  \___|\__\___|

grepf () {
  if [ $2 ] ; then
    grep -rnw "$2" -e "$1"
  elif [ $1 ] ; then
    grep -rnw "./" -e "$1"
  fi
}
