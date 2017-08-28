#!/bin/bash
#SBATCH -J my_jobstep_array
#SBATCH -p levque
#SBATCH -o logs/mosaic-%j.out
#SBATCH -e logs/mosaic-%j.err
#SBATCH --reservation=reserva-astro
IN_DIR=$1
OUT_DIR=$2

FILES=`ls -1 $IN_DIR | grep ooi`
for FILE in ${FILES[@]};
do
	INFILE=$IN_DIR/$FILE
	sbatch --reservation=reserva-astro -p levque  ./splitMosaic_threaded.sh -i $INFILE -o $OUT_DIR &

done
wait

