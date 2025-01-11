#!/bin/bash

speed=${1:-1.0}

speedDir="$HOME/Descargas/audio-speed"
mkdir -p $speedDir

i=0

for f in *.mp3 *.mp4; do
  # ffmpeg -i "$f" -filter:a "atempo=${speed}" -c:a libopus "$speedDir/$(date +%s).ogg" &
  ffmpeg -i "$f" -map_metadata -1 -metadata title="$2-$i" -filter:a atempo=$speed -c:a mp3 "$speedDir/$2-$i.mp3" # & 1> /dev/null
  i=$((i+1))
done

wait
