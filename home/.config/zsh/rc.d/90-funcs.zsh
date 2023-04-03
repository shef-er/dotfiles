#       _
#   ___| |_ ___
#  / _ \ __/ __|
# |  __/ || (__
#  \___|\__\___|

function grep-pattern-in-dir {
  [ -z "$2" ] && [ -z "$1" ] && echo "Usage: $0 PATTERN DIR" && return 1
  [ "$2" ] && grep -rne "$1" "$2" && return
  grep -rne "$1" "./"
}
