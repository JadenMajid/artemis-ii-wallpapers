#!/bin/bash
# Script to package wallpapers into ZIP files for releases

RELEASE_DIR="../releases"
mkdir -p "$RELEASE_DIR"

echo "Creating release packages for landscape wallpapers..."

# Standard resolutions
for ratio in 16_9 16_10 21_9 32_9; do
    if [ -d "$ratio" ]; then
        for res_dir in "$ratio"/*; do
            if [ -d "$res_dir" ]; then
                res=$(basename "$res_dir")
                zip_name="artemis-ii-landscape-$res.zip"
                echo "Packaging $res..."
                # Use subshell to avoid changing directory in the main script
                (cd "$res_dir" && zip -q -r -X "../../$RELEASE_DIR/$zip_name" . -x "*.DS_Store")
            fi
        done
    fi
done

# Mac resolutions
if [ -d "mac" ]; then
    for mac_dir in mac/*; do
        if [ -d "$mac_dir" ]; then
            model=$(basename "$mac_dir")
            zip_name="artemis-ii-landscape-mac-$model.zip"
            echo "Packaging Mac model $model..."
            (cd "$mac_dir" && zip -q -r -X "../../$RELEASE_DIR/$zip_name" . -x "*.DS_Store")
        fi
    done
fi

echo "Release packages created in $RELEASE_DIR"
ls -lh "$RELEASE_DIR"
