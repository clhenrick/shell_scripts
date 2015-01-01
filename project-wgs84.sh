#!/bin/bash
# reprojects a directory of .shp files to WGS84

TSRS=$1 # data source's current CRS (may improve accuracy of OGR if specified)

for FILE in *.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_4326.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" -s_srs "EPSG:3785" -t_srs "EPSG:4326" \
$FILENEW  $FILE

done
