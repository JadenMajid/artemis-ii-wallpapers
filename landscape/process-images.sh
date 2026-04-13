#!/bin/bash
RESOLUTIONS=(
    "16_9/1920x1080" "16_9/2560x1440" "16_9/3840x2160"
    "16_10/1920x1200" "16_10/2560x1600" "16_10/2880x1800"
    "21_9/2560x1080" "21_9/3440x1440" "21_9/5120x2160"
    "32_9/3840x1080" "32_9/5120x1440"
)

ORIGINALS_DIR="originals"
QUALITY=95
FILTER="Lanczos"

for res_path in "${RESOLUTIONS[@]}"; do
    res=$(basename "$res_path")
    echo "Processing for $res_path..."
    mkdir -p "$res_path"
    for img in "$ORIGINALS_DIR"/*; do
        if [ -f "$img" ]; then
            filename=$(basename "$img")
            if command -v magick >/dev/null 2>&1; then
                magick "$img" -filter "$FILTER" -resize "${res}^" -gravity Center -extent "$res" -quality "$QUALITY" "$res_path/$filename"
            else
                convert "$img" -filter "$FILTER" -resize "${res}^" -gravity Center -extent "$res" -quality "$QUALITY" "$res_path/$filename"
            fi
        fi
    done
done
