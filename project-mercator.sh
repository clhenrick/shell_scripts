#!/bin/bash
for FILE in *.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_3395.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" -s_srs "EPSG:3310" -t_srs "EPSG:3395"\
$FILENEW  $FILE

done

