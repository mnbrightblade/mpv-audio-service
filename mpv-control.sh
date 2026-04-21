#!/bin/bash
socket="/tmp/mpvsocket"

case "$1" in
  play)  echo '{ "command": ["set_property", "pause", false] }' | socat - "$socket" ;;
  pause) echo '{ "command": ["set_property", "pause", true] }'  | socat - "$socket" ;;
  toggle) echo '{ "command": ["cycle", "pause"] }' | socat - "$socket" ;;
  next)   echo '{ "command": ["playlist-next"] }' | socat - "$socket" ;;
  prev)   echo '{ "command": ["playlist-prev"] }' | socat - "$socket" ;;
  status)
      playlist=$(echo '{ "command": ["get_property", "playlist"] }' | socat - "$socket" | jq -r '.data')
      current=$(echo "$playlist" | jq -r 'map(select(.current == true)) | first | .filename // "None"')
      next_index=$(echo "$playlist" | jq 'map(select(.current == true)) | first | .index // -1 | . + 1')
      next=$(echo "$playlist" | jq -r ".[$next_index].filename // \"None\"")
      echo "Current: $current"
      echo "Next: $next"
      ;;
  *) echo "Usage: $0 {play|pause|toggle|next|prev|status}" >&2; exit 1 ;;
esac   
