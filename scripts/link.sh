#!/usr/bin/env bash

usage() {
    echo "Usage: $0 <source_dir> <destination_dir>"
    exit 1
}

[ -z "$1" ] || [ -z "$2" ] && usage

STATE_FILE="$HOME"/.local/state/dotfiles

mkdir -p "$(dirname "$STATE_FILE")"

for path in $(find "$1" -mindepth 1 -type f); do
    src_path="$(realpath "$path")"
    dst_path="$(realpath $2)/${path#"$1/"}"

    mkdir -p "$(dirname "$dst_path")"
    ln -vsfT "$src_path" "$dst_path"

    echo "$dst_path" >> "$STATE_FILE"
done
