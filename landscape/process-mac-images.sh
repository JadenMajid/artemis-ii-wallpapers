#!/bin/bash
MODELS="macbook-air-13:2560x1664 macbook-air-15:2880x1864 macbook-pro-14:3024x1964 macbook-pro-16:3456x2234 imac-24:4480x2520 studio-display:5120x2880 pro-display-xdr:6016x3384"

ORIGINALS_DIR="originals"
QUALITY=95
FILTER="Lanczos"

for entry in $MODELS; do
    model=${entry%%:*}
    res=${entry#*:}
    res_path="mac/$model"
    echo "Processing for $res_path ($res)..."
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
