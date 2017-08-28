#!/bin/bash
module load astro

sbatch process_mosaics.slurm data results/

#sbatch -n 5 -J "splitmosaic" -p levque --reservation=reserva-astro ./splitMosaic_distributed.sh -i ~/tests/mosaics/c4d_150204_040459_ooi_r_v1.fits.fz -o splitted -f -c

