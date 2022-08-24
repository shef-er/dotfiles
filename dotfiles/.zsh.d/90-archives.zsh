#                 _     _
#   __ _ _ __ ___| |__ (_)_   _____  ___
#  / _` | '__/ __| '_ \| \ \ / / _ \/ __|
# | (_| | | | (__| | | | |\ V /  __/\__ \
#  \__,_|_|  \___|_| |_|_| \_/ \___||___/

# usage: extract <filename>
extract () {
  if [ -f "${1}" ] ; then
    case "${1}" in
      *.tar.bz2)    tar -xjf $1 ;;
      *.tar.gz)     tar -xzf $1 ;;
      *.tar.xz)     tar -xvfJ $1 ;;
      *.bz2)        bunzip2 $1 ;;
      *.rar|*.cbr)  unrar x $1 ;;
      *.gz)         gunzip $1 ;;
      *.tar)        tar -xf $1 ;;
      *.tbz2)       tar -xjf $1 ;;
      *.tbz)        tar -xjvf $1 ;;
      *.tgz)        tar -xzf $1 ;;
      *.zip|*.cbz)  unzip $1 ;;
      *.Z)          uncompress $1 ;;
      *.7z)         7z x $1 ;;
      *)            echo "I don't know how to extract ${1}..." ;;
    esac
  else
    echo "${1} is not a valid file"
  fi
}


# usage: pack tar <filename>
pack () {
  if [ $1 ] ; then
    case $1 in
      tbz)    tar cjvf $2.tar.bz2 $2 ;;
      tgz)    tar czvf $2.tar.gz  $2 ;;
      tar)    tar cpvf $2.tar  $2    ;;
      bz2)    bzip $2 ;;
      gz)     gzip -c -9 -n $2 > $2.gz ;;
      zip)    zip -r $2.zip $2 ;;
      cbz)    zip -r $2.cbz $2 ;;
      7z)     7z a $2.7z $2 ;;
      rar)    rar a $2.rar $2 ;;
      *)      echo "${1} cannot be packed via pack()" ;;
    esac
  else
    echo "${1} is not a valid file"
  fi
}


# usage: pack tar <filename>
pack-dirs () {
  for D in *; do
    if [ -d "$D" ] ; then
      pack $1 $D
    fi
  done
}

