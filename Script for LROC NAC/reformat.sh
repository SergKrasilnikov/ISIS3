#!/bin/sh 
#create folder "list" in the same place as this script. Locate IMG files inside the list folder
mkdir cub_files #made folder with a cub files from different levels
mkdir results #after all results will be in this folder
key="$1"
for file in `find $key -type f`
do
  lronac2isis from= "$file" to= "${file%.???}_lev0.cub"
  spiceinit from= "${file%.???}_lev0.cub" cksmithed=yes spksmithed=yes # web=yes if you don't have kernels # darkfiletype=pair
  lronaccal from= "${file%.???}_lev0.cub" to= "${file%.???}_lev1.cub" # radiometrictype=radiance
  lronacecho from= "${file%.???}_lev1.cub" to= "${file%.???}_lev1.echo.cub"
  cam2map from= "${file%.???}_lev1.echo.cub" map=/mnt/f/Sergey/isis3/data/maptemplate/PolarNAC_S_radii.map to= "${file%.???}_lev2.cub" #location of your file with projections (maptemplate) # no difference if you use PolarNAC_S.map #after space you can add resolution of output data, like: pixres=mpp resolution=1
  isis2std from= "${file%.???}_lev2.cub" to= "${file%.???}" format=jp2 #format=tiff #jp2 format is lighter but could be not regarded by some programs
  
  
done
mv $key/*.cub cub_files
mv $key/*.tif results
mv $key/*.tfw results
mv $key/*.jp2 results
mv $key/*.j2w results
