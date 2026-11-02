#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPO_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
SCAN_RED="$REPO_ROOT/bin/scan_red"
SHOW="$REPO_ROOT/bin/show"
RESULTS_DIR="$SCRIPT_DIR/reduced_pointclouds"
WORK_DIR="$SCRIPT_DIR/reduced"

mkdir -p "$RESULTS_DIR"
trap 'rm -rf "$WORK_DIR"' EXIT

copy_result() {
  name=$1
  target="$RESULTS_DIR/$name"
  rm -rf "$target"
  mkdir -p "$target"
  cp "$WORK_DIR/scan000.3d" "$target/"
  cp "$WORK_DIR/scan000.pose" "$target/"
}

capture_result() {
  name=$1
  "$SHOW" --no-config -s 0 -e 0 \
    --screenshot \
    --screenshot-filename "$RESULTS_DIR/${name}.png" \
    "$RESULTS_DIR/$name"
}

for voxel in 5 10 20
do
  for selector in center random
  do
    if [ "$selector" = center ]; then
      octree=0
    else
      octree=1
    fi

    name="scan000_octree_${voxel}cm_${selector}"
    rm -rf "$WORK_DIR"
    "$SCAN_RED" "$SCRIPT_DIR" \
      -s 0 -e 0 -f RXP -t RIEGL \
      -r OCTREE -v "$voxel" -O "$octree"
    copy_result "$name"
    capture_result "$name"
  done
done

name=scan000_projection_equirectangular
rm -rf "$WORK_DIR"
"$SCAN_RED" "$SCRIPT_DIR" \
  -s 0 -e 0 -f RXP -t RIEGL \
  -r RANGE -P EQUIRECTANGULAR \
  -w 4500 --height 1250 -a -40 -A 60
copy_result "$name"
capture_result "$name"
