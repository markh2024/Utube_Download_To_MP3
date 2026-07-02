# Utube_Download_To_MP3
Downloads Utube Music  extracts the sound track and coverts to MP3 
# YouTube MP3 Downloader (Bash Edition)

## Overview

This project is a simple Bash script that downloads the audio from YouTube videos and converts it to high-quality MP3 files using **yt-dlp** and **FFmpeg**.

The script automatically checks that the required software is installed before allowing any downloads. If either dependency is missing, it detects the Linux distribution and attempts to install the missing packages using the system's package manager.

The downloaded MP3 files are saved to a user-selected folder.

---

# Features

* Automatic dependency checking
* Automatic installation of missing software
* Detects the Linux distribution automatically
* Supports multiple Linux package managers
* Downloads one or more YouTube URLs
* Converts audio directly to MP3
* Embeds the video's thumbnail into the MP3
* Embeds metadata (artist, title, etc.)
* Saves files into a user-selected output directory

---

# Required Software

The script requires the following external programs:

* **yt-dlp**
* **FFmpeg**

If either program is missing, the script will attempt to install it automatically.

---

# Supported Linux Distributions

The script currently supports automatic installation on:

| Distribution | Package Manager |
| ------------ | --------------- |
| openSUSE     | zypper          |
| Ubuntu       | apt             |
| Debian       | apt             |
| Linux Mint   | apt             |
| Pop!_OS      | apt             |
| Fedora       | dnf             |
| Arch Linux   | pacman          |
| Manjaro      | pacman          |

---

# Program Flow

```
Start
  │
  ▼
Check for yt-dlp
  │
Check for ffmpeg
  │
Missing?
  │
 ├── No ────────────────► Continue
 │
 └── Yes
      │
Detect Linux Distribution
      │
Install Missing Packages
      │
Verify Installation
      │
Continue
      │
Ask for Output Folder
      │
Enter YouTube URL(s)
      │
Download Audio
      │
Convert to MP3
      │
Embed Metadata
      │
Save File
      │
Finished
```

---

# Code Walkthrough

## Dependency Checking

The script begins by checking whether the required programs are available on the system.

Example:

```bash
command -v yt-dlp
command -v ffmpeg
```

The `command -v` command searches the user's PATH for an executable.

If either command cannot be found, the script stores the missing package name for installation.

---

## Detecting the Linux Distribution

The script reads:

```text
/etc/os-release
```

This file contains information about the current Linux distribution.

Example:

```
ID=opensuse-tumbleweed
NAME="openSUSE Tumbleweed"
```

The script uses the `ID` variable to determine which package manager should be used.

---

## Installing Dependencies

Depending on the detected distribution, the appropriate installation command is executed.

Examples:

### openSUSE

```bash
sudo zypper install yt-dlp ffmpeg
```

### Ubuntu / Debian

```bash
sudo apt install yt-dlp ffmpeg
```

### Fedora

```bash
sudo dnf install yt-dlp ffmpeg
```

### Arch Linux

```bash
sudo pacman -S yt-dlp ffmpeg
```

After installation, the script verifies that both programs are now available.

---

## Selecting the Output Folder

The user is prompted for an output directory.

If no folder is entered, the script defaults to:

```
~/Music
```

The directory is created automatically if it does not already exist.

---

## Download Loop

The script allows the user to enter one or more YouTube URLs.

Each URL is processed independently.

The loop ends when the user presses **Enter** on a blank line.

---

## Download Command

The download is performed using **yt-dlp**.

Typical command:

```bash
yt-dlp \
    --no-playlist \
    -x \
    --audio-format mp3 \
    --audio-quality 0 \
    --embed-thumbnail \
    --add-metadata \
    -o "$OUTDIR/%(title)s.%(ext)s" \
    "$URL"
```

### Command Options

| Option               | Description                                          |
| -------------------- | ---------------------------------------------------- |
| `--no-playlist`      | Download only a single video.                        |
| `-x`                 | Extract audio only.                                  |
| `--audio-format mp3` | Convert the audio to MP3.                            |
| `--audio-quality 0`  | Use the highest MP3 quality.                         |
| `--embed-thumbnail`  | Embed the video's thumbnail into the MP3 file.       |
| `--add-metadata`     | Write title, artist and other metadata into the MP3. |
| `-o`                 | Specifies the output filename and location.          |

---

# Output

The resulting file is saved as:

```
Song Title.mp3
```

inside the chosen output directory.

---

# Future Improvements

Possible future enhancements include:

* Playlist download mode
* Graphical user interface (Qt)
* Download progress indicator
* Audio format selection
* Download queue
* Settings file
* Automatic updates
* Cross-platform support (Windows and macOS)

---

# Author

Developed as part of a learning project to explore:

* Bash scripting
* Linux package management
* yt-dlp
* FFmpeg
* Automation
* Qt/C++ application development

This Bash application forms the foundation for the full Qt desktop version currently under development.
