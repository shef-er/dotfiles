#!/usr/bin/env bash

readonly STATE_FILE="$HOME"/.local/state/dotfiles

usage() {
    echo
    echo "Usage: $0 [COMMAND]"
    echo
    echo "Commands:"
    echo "  link SOURCE DESTINATION           Create symbolic links in DESTINATION dir to dotfiles in SOURCE dir"
    echo "  unlink                            Remove symbolic links to dotfiles"
}

unlink() {
    [ -r "$STATE_FILE" ] || exit 0

    links="$(< "$STATE_FILE")"

    for link in $links; do
        if [ -e "$link" ] && [ ! -L "$link" ]; then
            echo "Cannot remove symbolic link '$link': File is not link"
            echo 'Aborting...'
            exit 1
        fi
    done

    for link in $links; do
        rm -f "$link" && echo "Unlink $link"
    done

    rm -f "$STATE_FILE"
}

link() {
    [ -r "$STATE_FILE" ] && unlink

    target_dir="$(realpath "$1")"
    destination_dir="$(realpath $2)"
    
    targets="$(find "$target_dir" -mindepth 1 -type f)"

    for target in $targets; do
        link="$destination_dir${target#"$target_dir"}"

        if [ -e "$link" ]; then
            echo "Cannot create symbolic link '$link': File already exists"
            echo 'Aborting...'
            exit 1
        fi
    done

    mkdir -p "$(dirname "$STATE_FILE")"

    for target in $targets; do
        link="$destination_dir${target#"$target_dir"}"

        mkdir -p "$(dirname "$link")" && ln -vsT "$target" "$link"

        echo "$link" >> "$STATE_FILE"
    done
}

case "$1" in
    "link")
        [ -z "$2" ] || [ ! -d "$2" ] || [ -z "$3" ] || [ ! -d "$3" ] && usage && exit 1
        link "$2" "$3"
        ;;
    "unlink")
        unlink
        ;;
    *)
        usage
        ;;
esac
 