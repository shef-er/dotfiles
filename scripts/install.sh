#!/usr/bin/env bash

usage() {
    echo "Usage: $0 <source_dir> <destination_dir>"
    exit 1
}

[ -z "$1" ] || [ -z "$2" ] && usage

for path in $(find "$1" -mindepth 1 -type f); do
    src_path="$(realpath "$path")"
    dst_path="$(realpath $2)/${path#"$1/"}"

    mkdir -p "$(dirname "$dst_path")"
    ln -vsfT "$src_path" "$dst_path"
done

