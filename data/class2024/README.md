# Scan 000 reduced point clouds

This directory contains seven reduced point clouds generated from Riegl scan
number 0, together with screenshots captured using `bin/show`.

## Results

- `scan000_octree_5cm_center`: 5 cm voxels, voxel-center selection
- `scan000_octree_5cm_random`: 5 cm voxels, one random point per voxel
- `scan000_octree_10cm_center`: 10 cm voxels, voxel-center selection
- `scan000_octree_10cm_random`: 10 cm voxels, one random point per voxel
- `scan000_octree_20cm_center`: 20 cm voxels, voxel-center selection
- `scan000_octree_20cm_random`: 20 cm voxels, one random point per voxel
- `scan000_projection_equirectangular`: equirectangular projection reduction at
  `4500x1250`

Each result directory contains `scan000.3d` and `scan000.pose`. The matching
PNG screenshot is stored next to the directory.

## Reproduce the results

Use a 3DTK checkout containing the built executables `bin/scan_red` and
`bin/show`. Place the RXP source scan at:

```text
data/class2024/scan000.rxp
```

The script also works when `scan000.rxp` is a symbolic link to the original
RXP file. From the 3DTK repository root, run:

```bash
./data/class2024/generate_reduced_pointclouds.sh
```

The script reads scan 0, writes the reduced point clouds to
`data/class2024/reduced_pointclouds/`, opens each result in `bin/show` in
screenshot mode, and saves a `960x540` PNG image for each result.

The script assumes the RXP data is in the units used by 3DTK's RXP reader.
For this scan, voxel values `5`, `10`, and `20` represent 5 cm, 10 cm, and
20 cm respectively.
