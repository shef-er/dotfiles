#!/usr/bin/env bash

readonly STATE_FILE="$HOME"/.local/state/dotfiles

function dotfiles::main {
    case "$1" in
        "link")
            [ -z "$2" ] || [ ! -d "$2" ] || [ -z "$3" ] || [ ! -d "$3" ] && dotfiles::usage && exit 1
            dotfiles::link "$2" "$3"
            ;;
        "unlink")
            dotfiles::unlink
            ;;
        *)
            dotfiles::usage
            ;;
    esac
}

## Yes, I know about GNU Stow, just want to use my own solution
dotfiles::usage() {
    echo
    echo "Usage: $0 [COMMAND]"
    echo
    echo "Commands:"
    echo "  link SOURCE DESTINATION           Create symbolic links in DESTINATION dir to dotfiles in SOURCE dir"
    echo "  unlink                            Remove symbolic links to dotfiles"
}

dotfiles::link() {
    [ -r "$STATE_FILE" ] && dotfiles::unlink

    target_dir="$(realpath "$1")"
    destination_dir="$(realpath $2)"

    targets="$(find "$target_dir" -mindepth 1 -type f -print)"

    IFS=$'\n'
    for target in $targets; do
        link="$destination_dir${target#"$target_dir"}"

        if [ -e "$link" ]; then
            dotfiles::exit_with_error "Cannot create link '$link': File already exists"
        fi
    done

    mkdir -p "$(dirname "$STATE_FILE")"

    for target in $targets; do
        link="$destination_dir${target#"$target_dir"}"

        mkdir -p "$(dirname "$link")" \
            && ln -sT "$target" "$link" \
            && dotfiles::echo_link "'$link' -> '$target'"

        echo "$link" >> "$STATE_FILE"
    done
    unset IFS
}

dotfiles::unlink() {
    [ -r "$STATE_FILE" ] || exit 0

    links="$(< "$STATE_FILE")"

    IFS=$'\n'
    for link in $links; do
        if [ -e "$link" ] && [ ! -L "$link" ]; then
            dotfiles::exit_with_error "Cannot remove link '$link': File is not a link"
        fi
    done

    for link in $links; do
        rm -f "$link" && dotfiles::echo_unlink "'$link'"
    done
    unset IFS

    rm -f "$STATE_FILE"
}

dotfiles::echo_link() {
    echo -en '\e[32mLINK:\e[0m '
    echo "$1"
}

dotfiles::echo_unlink() {
    echo -en '\e[33mUNLINK:\e[0m '
    echo "$1"
}

dotfiles::exit_with_error() {
    echo -en '\e[31mERROR:\e[0m '
    echo "${1:-}"
    echo 'Aborting...'
    exit 1
}

dotfiles::main "$@"
 