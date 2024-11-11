#!/usr/bin/env bash

readonly STATE_FILE="$HOME"/.local/state/dotfiles

## Yes, I know about GNU Stow, just want to use my own solution
_dotfiles_usage() {
    /usr/bin/echo
    /usr/bin/echo "Usage: $0 [COMMAND]"
    /usr/bin/echo
    /usr/bin/echo 'Commands:'
    /usr/bin/echo '  link SOURCE DESTINATION           Create symbolic links in DESTINATION dir to dotfiles in SOURCE dir'
    /usr/bin/echo '  unlink                            Remove symbolic links to dotfiles'
}

_dotfiles_link() {
    if [ -z "$1" ] || [ ! -d "$1" ] || [ -z "$2" ] || [ ! -d "$2" ]; then
        _dotfiles_usage
        exit 1
    fi

    [ -r "$STATE_FILE" ] && _dotfiles_unlink

    target_dir="$(/usr/bin/realpath "$1")"
    destination_dir="$(/usr/bin/realpath "$2")"

    targets="$(/usr/bin/find "$target_dir" -mindepth 1 -type f -print)"

    IFS=$'\n'
    for target in $targets; do
        link="$destination_dir${target#"$target_dir"}"

        if [ -e "$link" ]; then
            _dotfiles_exit_with_error "Cannot create link '$link': File already exists"
        fi
    done

    /usr/bin/mkdir -p "$(/usr/bin/dirname "$STATE_FILE")"

    for target in $targets; do
        link="$destination_dir${target#"$target_dir"}"

        /usr/bin/mkdir -p "$(/usr/bin/dirname "$link")" &&
            ln -sT "$target" "$link" &&
            _dotfiles_echo_link "'$link' -> '$target'"

        /usr/bin/echo "$link" >>"$STATE_FILE"
    done
    unset IFS
}

_dotfiles_unlink() {
    [ -r "$STATE_FILE" ] || exit 0

    links="$(<"$STATE_FILE")"

    IFS=$'\n'
    for link in $links; do
        if [ -e "$link" ] && [ ! -L "$link" ]; then
            _dotfiles_exit_with_error "Cannot remove link '$link': File is not a link"
        fi
    done

    for link in $links; do
        /usr/bin/rm -f "$link" && _dotfiles_echo_unlink "'$link'"
    done
    unset IFS

    /usr/bin/rm -f "$STATE_FILE"
}

_dotfiles_echo_link() {
    /usr/bin/echo -en '\e[32mLINK:\e[0m '
    /usr/bin/echo "$1"
}

_dotfiles_echo_unlink() {
    /usr/bin/echo -en '\e[33mUNLINK:\e[0m '
    /usr/bin/echo "$1"
}

_dotfiles_exit_with_error() {
    /usr/bin/echo -en '\e[31mERROR:\e[0m '
    /usr/bin/echo "${1:-}"
    /usr/bin/echo 'Aborting...'
    exit 1
}

case "$1" in
link)
    shift
    _dotfiles_link "$@"
    ;;
unlink)
    _dotfiles_unlink
    ;;
*)
    _dotfiles_usage
    ;;
esac
