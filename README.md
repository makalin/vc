# Video Processing Bash Script

## Overview

This bash script processes `.mp4` files from a specified input directory (`/vcin`) and creates a multi-bitrate HLS (HTTP Live Streaming) output in a specified output directory (`/vcout`). Each input video is converted into multiple resolutions, and an HLS playlist is generated for adaptive streaming. This is achieved using `ffmpeg`.

## Prerequisites

- [ffmpeg](https://ffmpeg.org/) must be installed and available in the system's PATH.

## Usage

1. Place the input `.mp4` files you wish to process in the `/vcin` directory.
2. Ensure the `/vcout` directory is available for storing output files.
3. Run the script using the following command:
   ```bash
   ./vc.sh
   ```

The script will automatically create subdirectories in the output folder for each processed video, containing HLS segment files and playlists.

## How It Works

- For each `.mp4` file in the input directory:
  - Extracts the filename (without the extension).
  - Creates an output subdirectory for the processed file.
  - Converts the video into five different resolutions with specified bitrates using `ffmpeg`.
  - Generates HLS segments (`.ts` files) and playlists (`.m3u8`) for adaptive streaming.
  
## Parameters

- `INPUT_DIR`: Directory containing the input `.mp4` files.
- `OUTPUT_DIR`: Directory where the output files will be saved.
- `ffmpeg` options used:
  - `-map`: Maps video and audio streams for multiple output resolutions.
  - `-s:v`: Sets the resolution for each output video stream.
  - `-b:v`: Sets the bitrate for each output video stream.
  - `-hls_time`: Specifies the segment duration for HLS (10 seconds).
  - `-hls_playlist_type`: Specifies the playlist type as `vod` (video on demand).
  - `-hls_segment_filename`: Template for segment filenames.
  - `-master_pl_name`: Sets the name for the master playlist.
  - `-var_stream_map`: Maps the video and audio streams for each variant.

## Output Structure

The script generates the following structure for each processed video:

```
/vcout/
└── video_filename/
    ├── v0/
    │   ├── fileSequence0.ts
    │   ├── fileSequence1.ts
    │   └── ...
    ├── v1/
    │   ├── fileSequence0.ts
    │   ├── fileSequence1.ts
    │   └── ...
    ├── v2/
    ├── v3/
    ├── v4/
    ├── master.m3u8
    └── prog_index.m3u8
```

## Example

Assuming you have a file `example.mp4` in the `/vcin` directory, running the script will generate a subdirectory `/vcout/example` containing:
- Multiple `.ts` segment files for different resolutions.
- An HLS master playlist (`master.m3u8`) and indexed playlists (`prog_index.m3u8`) for adaptive streaming.
