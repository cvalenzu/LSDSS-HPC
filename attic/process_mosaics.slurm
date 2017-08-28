#!/bin/bash
#SBATCH -J my_jobstep_array
#SBATCH -p levque
#SBATCH -c 8
#SBATCH -N 1-5
#SBATCH --array=1-5
#SBATCH -o mosaic-%j.out
#SBATCH -e mosaic-%j.err
#SBATCH --reservation=reserva-astro

IN_DIR=$1
OUT_DIR=$2

FILE=`ls -1 $IN_DIR | grep ooi | sed -n "$SLURM_ARRAY_TASK_ID"p`
INFILE=$IN_DIR/$FILE
echo $INFILE
srun -N 1 -c 8 ./splitMosaic_threaded.sh -i $INFILE -o $OUT_DIR 
