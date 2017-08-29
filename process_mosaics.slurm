#!/bin/bash
#SBATCH -J CAT-Builder
#SBATCH -p levque
#SBATCH -o logs/out/mosaic-%j.out
#SBATCH -e logs/err/mosaic-%j.err
#SBATCH -n 80
#SBATCH --mem-per-cpu=2048 #Máxima RAM por CPU
#SBATCH -t 10:00

module load astro

IN_DIR=$1
OUT_DIR=$2

IN_DIR=${1%/}/
OUT_DIR=${2%/}/

echo $IN_DIR
echo $OUT_DIR
#FIRST STEP (SPLITTING DATA)
FILES=`ls -1 $IN_DIR | grep ooi | sort | sed -n '2p' `
for FILE in ${FILES[@]};
do
	INFILE=$IN_DIR$FILE
	srun -n 1 -c 8 --exclusive ./splitMosaic_threaded.sh -i $INFILE -o $OUT_DIR &
	#Running on one Moisaic
	break
done
wait

for FILE in ${FILES[@]};
do
        FILENAME=${FILE%.fits.fz}
	INFILE=$OUT_DIR"ccds/"$FILENAME
	CCD_FILES=`ls -1 $INFILE | grep image`
	#SECOND STEP
	#Running CRBlaster and Source Extractor for uncalibrated catalogs
	for CCD in ${CCD_FILES[@]};
	do
		srun -n 1 -c 1 --exclusive ./process_ccd.slurm $INFILE $OUT_DIR $FILENAME $CCD &
	done
	wait

	#Third Step
	#Calibrate Catalogs
	srun -n 1 -c 8 --exclusive ./run_scamp.slurm $OUT_DIR"sextractor_catalogs/"$FILENAME &	
		
	#Last Step
	#Send data to db
	break
done
wait
