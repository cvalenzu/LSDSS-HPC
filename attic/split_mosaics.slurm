#!/bin/bash
#SBATCH -J my_jobstep_array
#SBATCH -n 10
#SBATCH -p levque
#SBATCH --array=1-30
#SBATCH -o splitting-%j.out
#SBATCH -e splitting-%j.err
#SBATCH --reservation=reserva-astro

IN_DIR=$1
OUT_DIR=$2

FILE=`ls -1 $IN_DIR | sed -n "$SLURM_ARRAY_TASK_ID"p`
echo "Processing $FILE"
#################################################################
#		Decompress and split each mosaic 		#
#################################################################


#################################################################
#		Create a task for each CCD 			#
##################################################################
#srun process_ccd.slurm $IN_DIR $OUT_DIR $FILE &
