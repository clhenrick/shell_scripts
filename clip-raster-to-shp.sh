#!/bin/bash
SHPFILE=$1
BASE=`basename $SHPFILE .shp`
EXTENT=`ogrinfo -so $SHPFILE $BASE | grep Extent \
| sed 's/Extent: //g' | sed 's/(//g' | sed 's/)//g' \
| sed 's/ - /, /g'`
EXTENT=`echo $EXTENT | awk -F ',' '{print $1 " " $4 " " $3 " " $2}'`
echo "Clipping to $EXTENT"
RASTERFILE=$2
gdal_translate -projwin $EXTENT -of GTiff $RASTERFILE /tmp/`basename $RASTERFILE`_bbclip.tif
gdalwarp -co COMPRESS=DEFLATE -co TILED=YES -of GTiff \
-r lanczos -cutline $SHPFILE \
/tmp/`basename $RASTERFILE`_bbclip.tif /tmp/`basename $RASTERFILE`_shpclip.tif