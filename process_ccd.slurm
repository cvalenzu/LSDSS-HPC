#!/bin/bash
#SBATCH -J sub_job
#SBATCH -n 1
#SBATCH -p levque
#SBATCH -o logs/ccd-%j.out
#SBATCH -e logs/ccd-%j.err
#SBATCH --reservation=reserva-astro

echo "Running at `hostname -s`"

IN_DIR=$1
OUT_DIR=$2
FOLDER_NAME=$3
FILE=$4

NEW_OUTPUT="$OUT_DIR"sextractor_catalogs/$FOLDER_NAME
mkdir -p $NEW_OUTPUT
CAT_NAME="$NEW_OUTPUT/${FILE%.fits.fz}.cat"
XML_NAME="$NEW_OUTPUT/${FILE%.fits.fz}.xml"

########################
# Loading astro module #
########################
module load astro

########################
#  Running CRBlaster   #
########################

########################
# Running Sextractor   #
########################
echo "Starting time : `date '+%c'`"
sex "$IN_DIR/$FILE" -c etc/default.sex -CATALOG_NAME $CAT_NAME  -WEIGHT_IMAGE "$IN_DIR/${FILE//image/wtmap}"
echo "End time : `date '+%c'`"

########################
# Running SCAMP        #
########################

########################
# Writing data to DB   #
########################

