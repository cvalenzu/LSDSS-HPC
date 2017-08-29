#!/bin/bash
#SBATCH --job-name=example
#SBATCH -n 4
#SBATCH --output=example_%j.out
#SBATCH --error=example_%j.err
#SBATCH -p levque
#SBATCH --reservation=reserva-astro
module load intel impi astro

mpirun crblaster 1 2 2 results/ccds/c4d_150204_040459_ooi_r_v1/Blind15A_03_N22_57057.16860908_image.fits.fz test_mpi.fits.fz
