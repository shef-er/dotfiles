#        _ _
#   __ _(_) |_
#  / _` | | __|
# | (_| | | |_
#  \__, |_|\__|
#  |___/

function git-clone-hierarchical {
    URI="$1"
    URI_LOC="${URI#*git\@}"
    URI_HOST="${URI_LOC%\:*}"
    URI_PATH="${${URI_LOC#*\:}%.git}"

    git clone "$URI" "$URI_HOST/$URI_PATH"
}
