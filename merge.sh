#!/bin/bash
for FILE in *.shp
do
 echo "Transforming $FILE file..."
 ogr2ogr \
 -update -append merge.shp $FILE -f "ESRI Shapefile" -nln merge

done

#note: change the -s_srs parameters to the projection of the data you're working with.
#ex: 4326 = WGS84 and 900913 = Google Web Mercator