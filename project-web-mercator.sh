#!/bin/bash
# reprojects a directory of .shp files to web-mercator EPSG:3857

TSRS=$1 # data source's current CRS (may improve accuracy of OGR if specified)

for FILE in *.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_3857.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -s_srs $TSRS \
 -t_srs "EPSG:3857" \
$FILENEW  $FILE

done
