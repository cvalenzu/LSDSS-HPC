from astropy.io import fits

filename = "c4d_150204_040459_ooi_r_v1"
hdulist = fits.open(filename+ ".fits.fz")

for i,hdu in enumerate(hdulist):
	data = hdu.data
	header = hdu.header
	
	decompressed_hdu = fits.PrimaryHDU(data=data,header=header)
	
	new_hdulist = fits.HDUList([decompressed_hdu])
	
	new_hdulist.writeto(filename+"_"+str(i)+".fits")

