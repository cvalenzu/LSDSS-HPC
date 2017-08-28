#!/bin/bash
#SBATCH --job-name=example
#SBATCH -n 8 # Debe de ser un número múltiplo de 20
#SBATCH --ntasks-per-node=8 # Con esto se fuerza a que se lancen 20 tareas MPI en cada uno de los nodos, ocupando de este modo nodos completos. En este caso 6 nodos completos
#SBATCH --output=example_%j.out
#SBATCH --error=example_%j.err
#SBATCH -p levque
#SBATCH  --reservation=reserva-astro
module load intel impi astro

mpirun -np 8 crblaster 1 2 4 data/c4d_150204_040459_ooi_r_v1.fits.fz test_mpi.fits.fz

