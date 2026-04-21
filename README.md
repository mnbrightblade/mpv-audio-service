# MPV Audio Service

A systemd user service that plays a playlist of audio URLs using MPV in audio-only mode. Supports dynamic playlist updates, playback control, and resumes from where it left off.

## Features

- 🎵 Endless audio playback from a URL list
- 🔁 Resumes playback position on restart
- ➕ Add URLs dynamically (duplicates are checked)
- ▶️ Control playback: play, pause, next, previous, and status (current and next entry)
- 📦 Easy setup with install script

## Requirements

- `mpv` (with `yt-dlp` support)
- `socat` (for IPC communication)
- `systemd --user` (enabled)
- `jq` (for control script status display)

## Installation

1. Clone the repo:

```bash
git clone https://github.com/mnbrightblade/mpv-audio-service.git
cd mpv-audio-service
```
   
2. Run the install script:

```bash
./install.sh
```

3. Start the service

```bash
systemctl --user start mpv-audio.service
```

## Usage

Add a URL to the playlist:

```bash
./add-to-mpv.sh "artist" "title" "https://youtube.com/watch?v=..."
```

Control playback:

```bash
./mpv-control.sh play
./mpv-control.sh pause
./mpv-control.sh toggle #play/pause
./mpv-control.sh next
./mpv-control.sh prev
./mpv-control.sh status
```

Enable auto-start on boot:

```bash
systemctl --user enable mpv-audio.service
```

## License

GPL-3.0

