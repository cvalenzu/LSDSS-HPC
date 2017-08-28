#!/bin/bash
#
# split mosaic image in individual CCDs using
# pimcopy (threaded version of imcopy)
#
# imcopy - http://stsdas.stsci.edu/cgi-bin/gethelp.cgi?imcopy
# 
# (c) 2017 - Juan Carlos Maureira / Center for Mathematical Modeling

exist_file() {
    [ -f $1 ]
}

exist_dir() {
    [ -d $1 ]
}

get_header() {
    $BIN_GETHEAD -x $2 $1 $3
}

get_binary() {
    BIN=`whereis $1 | cut -f 2 -d":" | xargs`
    if ! exist_file $BIN; then 
        echo "$1 not found"
        exit 1 
    fi
    echo "$BIN"
}

usage() { 
    echo "Usage: $0 -i mosaic.fits.fz -o output_dir"
    exit 1
}

while getopts ":i:o:" o; do
    case "${o}" in
        i)
            MOSAIC_IMAGE="${OPTARG}"
            ;;
        o)
            OUTPUT_DIR="${OPTARG}"
            ;;
        h | *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "$MOSAIC_IMAGE" ] || [ -z "$OUTPUT_DIR" ];then
    usage
fi

# check inputs and outputs
if ! exist_file $MOSAIC_IMAGE; then
    echo "Mosaic image $MOSAIC_IMAGE not found"
    exit 1
fi

if ! exist_dir $OUTPUT_DIR; then
    echo "Output directory does not exist. creating it"
    mkdir -p $OUTPUT_DIR
fi

BIN_PIMCOPY=`get_binary pimcopy`

FILENAME=$(basename $MOSAIC_IMAGE)
WEIGHTNAME=${MOSAIC_IMAGE//ooi/oow}
FOLDER_NAME=${FILENAME%.fits.fz}

NEW_OUTPUT=$OUTPUT_DIR"ccds/"$FOLDER_NAME

#Creating results folder
mkdir -p $NEW_OUTPUT

#Split weight and image mosaics
$BIN_PIMCOPY -i $MOSAIC_IMAGE -o $NEW_OUTPUT
$BIN_PIMCOPY -i $WEIGHTNAME -o $NEW_OUTPUT

#For each ccd create a job to process using 
#sextractor
FILES=`ls -1 $NEW_OUTPUT | grep image`
echo $NEW_OUTPUT
for FILE in ${FILES[@]};
do
        srun ./process_ccd.slurm $NEW_OUTPUT $OUTPUT_DIR $FOLDER_NAME $FILE &
done
wait

#Run scamp to all the fits files


#For each calibrated catalog create a job to send the data
#to the database



EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
    echo "pimcopy exit with error code $EXIT_CODE"
    exit $EXIT_CODE
fi

echo "done"
