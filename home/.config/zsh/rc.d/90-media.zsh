#                     _ _
#  _ __ ___   ___  __| (_) __ _
# | '_ ` _ \ / _ \/ _` | |/ _` |
# | | | | | |  __/ (_| | | (_| |
# |_| |_| |_|\___|\__,_|_|\__,_|

function m4a-to-mp3 {
  if [ hash ffmpeg 2>/dev/null ] ; then
    for a in ./*.m4a; do
      ffmpeg -i "$a" -acodec libmp3lame -b:a 320k -qscale:a 0 "${a[@]/%m4a/mp3}"
    done
  else
    echo "ffmpeg: Command not found..."
  fi
}


function flac-to-mp3 {
  if [ hash ffmpeg 2>/dev/null ]; then
    for a in ./*.flac; do
      ffmpeg -i "$a" -b:a 320k -qscale:a 0 "${a[@]/%flac/mp3}"
    done
  else
    echo "ffmpeg: Command not found..."
  fi
}


function flac-img-to-tracks {
  if [ hash cuebreakpoints 2>/dev/null ] \
     && [ hash shnsplit 2>/dev/null ] \
     && [ hash cuetag 2>/dev/null ]
  then
    cuebreakpoints *.cue | shnsplit -o flac *.flac
    cuetag *.cue split-track*.flac
  else
    echo "Make sure you have installed: cuebreakpoints, shnsplit, cuetag."
  fi
}

function webp2png {
  dwebp "$1" -o "${1%'.webp'}".png
}
