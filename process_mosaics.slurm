#!/bin/bash
#SBATCH -J my_jobstep_array
#SBATCH -p levque
#SBATCH -c 8
#SBATCH -o mosaic-%j.out
#SBATCH -e mosaic-%j.err
#SBATCH --reservation=reserva-astro

IN_DIR=$1
OUT_DIR=$2

FILES=`ls -1 $IN_DIR | grep ooi`
for FILE in ${FILES[@]};
do
	INFILE=$IN_DIR/$FILE
	sbatch --reservation=reserva-astro -p levque -c 8 ./splitMosaic_threaded.sh -i $INFILE -o $OUT_DIR &

done
wait

