#!/bin/bash
socket="/tmp/mpvsocket"

log_file="mpv-terminal.$(date +%Y%m%d).log"
touch "$log_file"

while true; do
  # Get current track
  current=$(echo '{ "command": ["get_property", "media-title"] }' | socat - "$socket" | jq -r '.data // "Unknown"')
  clear
  printf '%*s\n' "$(tput cols)" "" | tr ' ' '-'
  printf '%s\n' "Now playing:"
  printf '\n%s\n' "$current"
  printf '%*s\n' "$(tput cols)" "" | tr ' ' '-'
  printf '\n%s' "t:play/pause p:next n:prev r:restart e:exit > "
  
  # Read one character
  IFS= read -r -n1 key
  
  case "$key" in
    t) echo '{ "command": ["cycle", "pause"] }' | socat - "$socket" >> "./$log_file" 2>&1 ;;
    p) echo '{ "command": ["playlist-next"] }' | socat - "$socket" >> "./$log_file" 2>&1 ;;
    n) echo '{ "command": ["playlist-prev"] }' | socat - "$socket" >> "./$log_file" 2>&1 ;;
    r) systemctl --user restart mpv-audio.service; clear; break ;;
    e) clear; echo "Exiting..."; break ;;
  esac
done   
