#!/bin/bash

WALL_DIR="$HOME/Pictures/wallpapers"

if [ ! -d "$WALL_DIR" ]; then
  echo "Error: Directory $WALL_DIR not found!"
  exit 1
fi

SELECTION=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

if [ -n "$SELECTION" ]; then
  bash "$HOME/.local/bin/wal-set.sh" "$SELECTION"
else
  echo "No images found in $WALL_DIR"
  exit 1
fi
