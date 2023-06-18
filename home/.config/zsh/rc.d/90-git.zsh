#        _ _
#   __ _(_) |_
#  / _` | | __|
# | (_| | | |_
#  \__, |_|\__|
#  |___/

function git-xclone {
    URI="$1"
    FRAG="${URI#*://}"
    FRAG="${FRAG#*git\@}"
    FRAG="${FRAG%.git}"

    if [[ "$URI" =~ ^[A-Za-z]+:// ]] ; then
        URI_HOST="${FRAG%%/*}"
        URI_PATH="${FRAG#*/}"
    else
        URI_HOST="${FRAG%%\:*}"
        URI_PATH="${FRAG#*\:}"
    fi

    git clone "$URI" "$URI_HOST/$URI_PATH"
}
