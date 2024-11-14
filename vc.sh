#!/bin/bash

INPUT_DIR="/vcin"
OUTPUT_DIR="/vcout"

for file in "$INPUT_DIR"/*.mp4; do
    filename=$(basename "$file" .mp4)

    mkdir -p "$OUTPUT_DIR/$filename"

    ffmpeg -i "$file" \
    -map 0:v -map 0:a -map 0:v -map 0:a -map 0:v -map 0:a -map 0:v -map 0:a -map 0:v -map 0:a \
    -s:v:0 1920x1080 -b:v:0 5000k -s:v:1 1280x720 -b:v:1 3000k -s:v:2 640x360 -b:v:2 1000k -s:v:3 480x270 -b:v:3 600k -s:v:4 320x180 -b:v:4 400k \
    -f hls -hls_time 10 -hls_playlist_type vod \
    -hls_segment_filename "$OUTPUT_DIR/$filename/v%v/fileSequence%d.ts" \
    -master_pl_name "$OUTPUT_DIR/$filename/master.m3u8" \
    -var_stream_map "v:0,a:0 v:1,a:1 v:2,a:2 v:3,a:3 v:4,a:4" \
    "$OUTPUT_DIR/$filename/v%v/prog_index.m3u8"
done
