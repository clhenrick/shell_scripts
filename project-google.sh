#!/bin/bash
for FILE in *.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_900913.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" -s_srs "EPSG:4326" -t_srs "EPSG:900913" \
$FILENEW  $FILE

done

#note: change the -s_srs parameters to the projection of the data you're working with.
#ex: 4326 = WGS84 and 900913 = Google Web Mercator