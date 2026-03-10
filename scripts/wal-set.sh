#!/bin/zsh

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

pgrep -x "awww-daemon" > /dev/null || awww-daemon &

IMG_PATH=$(realpath "$1")
awww img "$IMG_PATH" --transition-type grow --transition-pos center

wal -i "$IMG_PATH" -n

pkill -USR2 waybar
