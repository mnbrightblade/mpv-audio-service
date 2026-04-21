#!/bin/bash
url="$1"
playlist_file="$HOME/mpv-audio-service/playlist.txt"
socket="/tmp/mpvsocket"

# Check if URL is already in MPV's current playlist
if echo '{ "command": ["get_property", "playlist"] }' | socat - "$socket" 2>/dev/null | grep -q "$url"; then
    echo "Already playing: $url"
    exit 0
fi

# Check if URL is in the file playlist
if grep -q "^$url$" "$playlist_file" 2>/dev/null; then
    echo "Already in playlist file: $url"
    exit 0
fi

# Add to file and MPV playlist
echo "$url" >> "$playlist_file"
echo '{ "command": ["loadfile", "'"$url"'", "append"] }' | socat - "$socket"
echo "Added: $url"   
