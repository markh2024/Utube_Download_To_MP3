#!/bin/bash

# ===========================================
# YouTube MP3 Downloader
# ===========================================

install_dependencies()
{
    local missing=()

    command -v yt-dlp >/dev/null 2>&1 || missing+=("yt-dlp")
    command -v ffmpeg >/dev/null 2>&1 || missing+=("ffmpeg")

    [ ${#missing[@]} -eq 0 ] && return

    echo
    echo "Missing dependencies:"
    printf "  %s\n" "${missing[@]}"
    echo

    if [ -f /etc/os-release ]; then
        . /etc/os-release
    else
        echo "Unable to determine Linux distribution."
        exit 1
    fi

    case "$ID" in

        opensuse*|sled|sles)

            echo "Detected OpenSUSE"

            sudo zypper refresh

            sudo zypper install -y "${missing[@]}"
            ;;

        ubuntu|debian|linuxmint|pop)

            echo "Detected Debian/Ubuntu"

            sudo apt update

            sudo apt install -y "${missing[@]}"
            ;;

        fedora)

            echo "Detected Fedora"

            sudo dnf install -y "${missing[@]}"
            ;;

        arch|manjaro)

            echo "Detected Arch Linux"

            sudo pacman -Sy --noconfirm "${missing[@]}"
            ;;

        *)

            echo
            echo "Unsupported Linux distribution:"
            echo "$PRETTY_NAME"
            echo
            echo "Please install manually:"
            printf "  %s\n" "${missing[@]}"
            exit 1
            ;;
    esac

    echo

    for prog in yt-dlp ffmpeg
    do
        if ! command -v "$prog" >/dev/null 2>&1
        then
            echo "Installation failed for $prog"
            exit 1
        fi
    done
}

install_dependencies

echo
echo "========================================="
echo "      YouTube MP3 Downloader"
echo "========================================="
echo

DEFAULT_DIR="$HOME/Music"

read -p "Output folder [$DEFAULT_DIR]: " OUTDIR

[ -z "$OUTDIR" ] && OUTDIR="$DEFAULT_DIR"

mkdir -p "$OUTDIR"

echo
echo "Paste one or more YouTube URLs."
echo "Press ENTER on a blank line when finished."
echo

while true
do
    read -p "URL: " URL

    [ -z "$URL" ] && break

    echo
    echo "Downloading..."
    echo

    yt-dlp \
        --no-playlist \
        -x \
        --audio-format mp3 \
        --audio-quality 0 \
        --embed-thumbnail \
        --add-metadata \
        -o "$OUTDIR/%(title)s.%(ext)s" \
        "$URL"

    echo
    echo "Finished."
    echo
done

echo
echo "All downloads complete."
