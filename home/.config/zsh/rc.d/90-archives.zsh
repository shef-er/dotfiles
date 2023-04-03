#                 _     _
#   __ _ _ __ ___| |__ (_)_   _____  ___
#  / _` | '__/ __| '_ \| \ \ / / _ \/ __|
# | (_| | | | (__| | | | |\ V /  __/\__ \
#  \__,_|_|  \___|_| |_|_| \_/ \___||___/

unpack () {
  [ -z "$1" ] && echo "Usage: $0 FILENAME" && return 1

  [ ! -f "$1" ] && echo "Invalid file: '$1'" && return 1

  case "$1" in
    *.tar)
      tar -v -xf "$1" ;;
    *.tar.gz|*.tgz)
      tar -v -xzf "$1" ;;
    *.tar.bz2|.tar.bzip2|*.tbz2|.tb2|*.tar.bz|*.tbz)
      tar -v -xjf "$1"  ;;
    *.tar.xz)
      tar -v -xJf "$1" ;;
    *.gz)
      gunzip "$1" ;;
    *.bz2|*.bz)
      bunzip2 "$1" ;;
    *.zip|*.cbz)
      unzip "$1" ;;
    *.rar|*.cbr)
      unrar x "$1" ;;
    *.7z)
      7z x "$1" ;;
    *)
      echo "Unknown file type: '$1'" && return 1 ;;
  esac
}

pack () {
  [ -z "$1" ] && echo "Usage: $0 ARCHIVE_TYPE FILENAME" && return 1

  [ -e "$2" ] || $(echo "Invalid file: '$2'" && return 1)

  case "$1" in
    tar)
      tar -vp -cf "$2.tar" "$2" ;;
    tgz)
      tar -v -czf "$2.tar.gz" "$2" ;;
    tbz)
      tar -v -cjf "$2.tar.bz2" "$2" ;;
    gz)
      gzip -c -9 -n "$2" > "$2.gz" ;;
    bz2)
      bzip "$2" ;;
    zip)
      zip -r "$2.zip" "$2" ;;
    7z)
      7z a "$2.7z" "$2" ;;
    rar)
      rar a "$2.rar" "$2" ;;
    *)
      echo "Unknown archive type: '$1'" && return 1 ;;
  esac
}
