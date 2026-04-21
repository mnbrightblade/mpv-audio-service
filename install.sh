#!/bin/bash
SERVICE_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="mpv-audio.service"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create systemd user directory
mkdir -p "$SERVICE_DIR"

# Create symlink
ln -sf "$REPO_DIR/$SERVICE_FILE" "$SERVICE_DIR/$SERVICE_FILE"

# Reload systemd
systemctl --user daemon-reload

echo "Service symlink created and reloaded."   
