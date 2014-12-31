#!/bin/bash
# Merges a directory of shapefiles into one.
# caveats: shapefiles do not support multiple geometry types, 
#   so all shapefiles must be of the same geometry.

FILE='nl_merged.shp' # name of file to be merged to
LAYER='nl_merged' # must be same as above but without `.shp` extension
SSRS='EPSG:2227' # source CRS
TSRS='EPSG:2227' # target CRS

for i in $(ls *.shp)
do

    if [ -f "$FILE" ]
    then
            echo "transforming and merging $i..."
            ogr2ogr \
            -f 'ESRI Shapefile' \
            -s_srs $SSRS \
            -t_srs $TSRS \
            -update -append $FILE $i \
            -nln $LAYER
    else
            echo "creating $FILE..."
            ogr2ogr \
            -f 'ESRI Shapefile' \
            -s_srs $SSRS \
            -t_srs $TSRS \
            $FILE $i
fi
done
