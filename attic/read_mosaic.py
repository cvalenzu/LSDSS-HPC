#! /usr/bin/env python

from astropy.io import fits
import glob as g

################################################################################

"""
    DESCRIPTION:
    This routine reads in compressed DECam mosiac images (*.fits.fz) and writes
    out individual CCD frames (*.fits).
    
    CALLING SQUENCE:
    read_mosaic.py
        
    INPUT: .fits mosaic image
    OUTPUT: _
    
"""


################################################################################


def read_mosiac(file):

    hdulist = fits.open(file)


    for extension, frame in enumerate(hdulist):

        if type(hdulist[extension]) is fits.hdu.image.ImageHDU:

            data = hdulist[extension].data
            header = hdulist[extension].header
            
            new_file = file +  '_' + str(extension).zfill(2)
            header.tofile(new_file + '.ahead')
            fits.writeto(nfile + '.fits', data, header)

    hdulist.close()

################################################################################

def main():
    
    file_list = g.glob('*_ooi_*.fits.fz')
    
    for file in file_list:
        read_mosiac(file[:-8])


################################################################################

if __name__ == "__main__":
    main()
