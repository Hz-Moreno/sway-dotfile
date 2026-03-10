#!/bin/bash

WALL_DIR=~/Pictures/wallpapers

if [ ! -d "$WALL_DIR" ]; then
  echo "Error: dir $WALL_DIR not found!" >/tmp/wall-log.txt
  exit 1
fi

SELECTION=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) 2>/dev/null | fzf --prompt="󰸉 Escolha o Wallpaper: " --height=40% --reverse)

if [ -n "$SELECTION" ]; then
  echo "Imagem selecionada: $SELECTION" >/tmp/wall-log.txt

  bash "$HOME/.local/bin/wal-set.sh" "$SELECTION" >>/tmp/wall-log.txt 2>&1
fi
