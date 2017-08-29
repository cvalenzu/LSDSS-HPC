#!/bin/bash
FOLDER=$1
PATH_NAME=${FOLDER%/}
NEW_FOLDER=$( basename $PATH_NAME )
FILES=`find $PATH_NAME -type f`

NEW_PATH=${PATH_NAME//sextractor_catalogs/scamp_catalogs}
FILENAME=$PATH_NAME".cat"
#mkdir -p ` dirname $NEW_PATH `

scamp ${FILES[@]} -mergedoutcat_name $FILENAME -mergedoutcat_type ascii
rm *.png 
