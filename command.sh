#!/bin/bash
module load astro

#sbatch process_mosaics.slurm data results/

sbatch -c 8 -J "splitmosaic" -p levque --reservation=reserva-astro ./splitMosaic_threaded.sh -i ~/tests/data/c4d_150204_040459_ooi_r_v1.fits.fz -o results/ 
