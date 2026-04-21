#!/bin/bash
socket="/tmp/mpvsocket"

case "$1" in
  play)  echo '{ "command": ["set_property", "pause", false] }' | socat - "$socket" ;;
  pause) echo '{ "command": ["set_property", "pause", true] }'  | socat - "$socket" ;;
  toggle) echo '{ "command": ["cycle", "pause"] }' | socat - "$socket" ;;
  next)   echo '{ "command": ["playlist-next"] }' | socat - "$socket" ;;
  prev)   echo '{ "command": ["playlist-prev"] }' | socat - "$socket" ;;
  *) echo "Usage: $0 {play|pause|toggle|next|prev}" >&2; exit 1 ;;
esac   
