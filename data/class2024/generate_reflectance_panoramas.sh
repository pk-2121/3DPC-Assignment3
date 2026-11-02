#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPO_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
SCANNER="$REPO_ROOT/bin/scan_to_panorama"
OUTPUT_DIR="$SCRIPT_DIR/panorama_reflectance_jpeg"
WIDTH=9000
HEIGHT=2500

mkdir -p "$OUTPUT_DIR"

for projection in AZIMUTHAL CONIC CYLINDRICAL EQUALAREACYLINDRICAL \
  EQUIRECTANGULAR MERCATOR MILLER RECTILINEAR STEREOGRAPHIC ZAXIS
do
  "$SCANNER" "$SCRIPT_DIR" \
    -s 0 -e 0 \
    -f RXP -t RIEGL \
    -R -F JPEG -S 95 \
    -W "$WIDTH" -H "$HEIGHT" \
    -m 0 -w 360 -n -40 -x 60 \
    -O "$OUTPUT_DIR" \
    -p "$projection"

  mv "$OUTPUT_DIR/scan000_${projection}_${WIDTH}x${HEIGHT}_Reflectance.jpg" \
    "$OUTPUT_DIR/scan000_${projection}_Reflectance.jpg"
done

"$SCANNER" "$SCRIPT_DIR" \
  -s 0 -e 0 \
  -f RXP -t RIEGL \
  -R -F JPEG -S 95 \
  -W "$WIDTH" -H "$HEIGHT" \
  -m 0 -w 360 -n -40 -x 60 \
  -O "$OUTPUT_DIR" \
  -p PANNINI -P 1

mv "$OUTPUT_DIR/scan000_PANNINI_${WIDTH}x${HEIGHT}_Reflectance.jpg" \
  "$OUTPUT_DIR/scan000_PANNINI_Reflectance.jpg"
