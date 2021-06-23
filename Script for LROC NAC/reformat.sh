#!/bin/sh 
#create folder "list" in the same place as this script.
mkdir cub_files #made folder with a cub files from different levels
mkdir results #after all results will be in this folder
key="$1"
for file in `find $key -type f`
do
  lronac2isis from= "$file" to= "${file%.???}_lev0.cub"
  spiceinit from= "${file%.???}_lev0.cub" web=yes
  lronaccal from= "${file%.???}_lev0.cub" to= "${file%.???}_lev1.cub"
  lronacecho from= "${file%.???}_lev1.cub" to= "${file%.???}_lev1.echo.cub"
  cam2map from= "${file%.???}_lev1.echo.cub" map=/home/.../maptemplate/PolarNAC_S.map to= "${file%.???}_lev2.cub" #location of your file with projections #after space you can add resolution of output data like: pixres=mpp resolution=1
  isis2std from= "${file%.???}_lev2.cub" to= "${file%.???}" format=tiff
  
  
done
mv $key/*.cub cub_files
mv $key/*.tif results
mv $key/*.tfw results
