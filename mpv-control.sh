#!/bin/bash
socket="/tmp/mpvsocket"

case "$1" in
  play)  echo '{ "command": ["set_property", "pause", false] }' | socat - "$socket" ;;
  pause) echo '{ "command": ["set_property", "pause", true] }'  | socat - "$socket" ;;
  toggle) echo '{ "command": ["cycle", "pause"] }' | socat - "$socket" ;;
  next)   echo '{ "command": ["playlist-next"] }' | socat - "$socket" ;;
  prev)   echo '{ "command": ["playlist-prev"] }' | socat - "$socket" ;;
 status)
    playlist=$(echo '{ "command": ["get_property", "playlist"] }' | socat - "$socket")
    current_title=$(echo "$playlist" | jq -r 'first(.data[] | select(.current == true)) | .title // .filename // "None"')
    next_index=$(echo "$playlist" | jq 'first(.data[] | select(.current == true)) | .index // -1 | . + 1')
    next_title=$(echo "$playlist" | jq -r ".data[$next_index].title // .data[$next_index].filename // \"None\"")
    echo "Current: $current_title"
    echo "Next: $next_title"
    ;;   
  *) echo "Usage: $0 {play|pause|toggle|next|prev|status}" >&2; exit 1 ;;
esac   

