#!/bin/bash
artist="$1"
title="$2"
url="$3"
playlist_file="$HOME/mpv-audio-service/playlist.m3u8"
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

# Add metadata and URL to playlist file
echo "#EXTINF:0,$artist - $title" >> "$playlist_file"
echo "$url" >> "$playlist_file"

# Add to running MPV stream
echo '{ "command": ["loadfile", "'"$url"'", "append"] }' | socat - "$socket"
echo "Added: $url"   
