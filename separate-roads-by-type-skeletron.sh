# separate a roads GeoJSON layer into multiple shapefile layers using ogr2ogr's sql and geojson driver
# takes a geojson file extracted using https://github.com/migurski/Skeletron
# processes spatial data into multiple road shapefiles based on the skeletron.py output 'highway' field values
# *****************************************************************************

#!/bin/bash

# assign variable values for OGR parameters here:
ROADS='central_az_z15_w12.json' # the name of your OSM roads layer file, must have a type field name
Z='z15' # zoom level skeletron was set to
TSRS='EPSG:2223'  # the EPSG code you want your data projected to
PRJ=`echo $TSRS | sed s/\"//g | cut -f2 -d ':'` # takes the numbers of your EPSG code and appends to the output.shp name

# set path for output.shp files here
DIR_OUT='/Users/chrishenrick/Desktop/DATA/Arizona/OSM/central_az_extracts/roads_generalized/'

# queries out motorways
for FILE in $ROADS
do
 echo "processing $FILE file into motorways..."
 FILENEW=`echo $FILE | sed "s/$ROADS/motorways_$PRJ_gen_$Z.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -sql "select * from OGRGeoJSON where highway in ('motorway', 'trunk')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out main roads (primary, secondary, tertiary)
for FILE in $ROADS
do
 echo "processing $FILE file into main roads..."
 FILENEW=`echo $FILE | sed "s/$ROADS/main-rd_$PRJ_gen_$Z.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -sql "select * from OGRGeoJSON where highway in ('primary','secondary','tertiary')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out residential and other smaller roads
for FILE in $ROADS
do
 echo "processing $FILE file in other roads..."
 FILENEW=`echo $FILE | sed "s/$ROADS/other-rd_$PRJ_gen_$Z.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -sql "select * from OGRGeoJSON where highway in ('residential', 'minor', 'abandoned', 'rest_area', 'service', 'living_street', 'unclassified')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out dirt roads
for FILE in $ROADS
do
 echo "processing $FILE file into dirt roads..."
 FILENEW=`echo $FILE | sed "s/$ROADS/dirt-rd_$PRJ_gen_$Z.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -sql "select * from OGRGeoJSON where highway = 'track'" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out paths, trails, cycling paths, etc.
for FILE in $ROADS
do
 echo "processing $FILE file into trails..."
 FILENEW=`echo $FILE | sed "s/$ROADS/trails_$PRJ_gen_$Z.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -sql "select * from OGRGeoJSON where highway in ('bridleway', 'cycleway', 'footway', 'path', 'platform', 'pedestrian', 'steps')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# move output files to a desired location (separate from original data)
for FILE in *_$PRJ_gen_$Z.*
do
 echo "moving $FILE file..."
 mv $FILE $DIR_OUT

done

exit