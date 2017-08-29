#!/bin/bash
echo "Running at `hostname -s`"

IN_DIR=$1
OUT_DIR=$2
FOLDER_NAME=$3
FILE=$4

#Creating new paths
NEW_OUTPUT="$OUT_DIR"sextractor_catalogs/$FOLDER_NAME
CLEANED_DIR=$OUT_DIR"cleanead_ccd/"$FOLDER_NAME

mkdir -p $NEW_OUTPUT
mkdir -p $CLEANED_DIR
CAT_NAME="$NEW_OUTPUT/${FILE%.fits.fz}.cat"

########################
# Loading astro module #
########################
module load astro

########################
#  Running CRBlaster   #
########################
cp $IN_DIR/$FILE $CLEANED_DIR/$FILE 
#mpirun crblaster 1 2 2 $IN_DIR/$FILE $CLEANED_DIR/$FILE 
rm $IN_DIR/$FILE

########################
# Running Sextractor   #
########################
echo "Starting time : `date '+%c'`"
sex "$CLEANED_DIR/$FILE" -c etc/default.sex -CATALOG_NAME $CAT_NAME  -WEIGHT_IMAGE "$IN_DIR/${FILE//image/wtmap}"
echo "End time : `date '+%c'`"
