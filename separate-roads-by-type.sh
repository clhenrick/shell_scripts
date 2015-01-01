# separate a roads shapefile layer into multiple layers using ogr2ogr -sql
# takes a roads.shp file extracted using: http://extract.bbbike.org/#
# processes into multiple road shapefiles based on the OSM 'type' attributes
# *****************************************************************************

#!/bin/bash

# assign variable values for OGR parameters here:
ROADS='roads.shp' # the name of your OSM roads layer file, must have a type field name and be named roads.shp
TSRS='EPSG:2227'  # the EPSG code you want your data projected to
PRJ=`echo $TSRS | sed s/\"//g | cut -f2 -d ':'` # takes the numbers of your EPSG code and appends to the output file name

# set path for output files here
DIR_OUT='/Users/chrislhenrick/Cartography/projects/eHeinze/henry-cowell-sp/data/roads/processed/'

# queries out motorways
for FILE in $ROADS
do
 echo "processing $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_motorways_$PRJ.shp/"`
 ogr2ogr \
 -sql "select * from roads where type in ('motorway', 'trunk')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out motorway links (off ramps and connectors)
for FILE in $ROADS
do
 echo "processing $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_motorway-links_$PRJ.shp/"`
 ogr2ogr \
 -sql "select * from roads where type in ('motorway_link', 'trunk_link')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out main roads (primary, secondary, tertiary)
for FILE in $ROADS
do
 echo "processing $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_main-rd_$PRJ.shp/"`
 ogr2ogr \
 -sql "select * from roads where type in ('primary','secondary','tertiary')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out primary links (usually not many of these)
for FILE in $ROADS
do
 echo "processing $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_main-rd-links_$PRJ.shp/"`
 ogr2ogr \
 -sql "select * from roads where type in ('primary_link','secondary_link','tertiary_link')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out residential and other smaller roads
for FILE in $ROADS
do
 echo "processing $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_other-rd_$PRJ.shp/"`
 ogr2ogr \
 -sql "select * from roads where type in ('residential', 'service', 'living_street', 'unclassified')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out dirt roads
for FILE in $ROADS
do
 echo "processing $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_dirt-rd_$PRJ.shp/"`
 ogr2ogr \
 -sql "select * from roads where type = 'track'" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# queries out paths, trails, cycling paths, etc.
for FILE in $ROADS
do
 echo "processing $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_trails_$PRJ.shp/"`
 ogr2ogr \
 -sql "select * from roads where type in ('bridleway', 'cycleway', 'footway', 'path', 'pedestrian', 'steps')" \
 -t_srs $TSRS \
 $FILENEW  $FILE\

done

# move output files to a desired location (separate from original data)
for FILE in *_$PRJ.*
do
 echo "moving $FILE file..."
 mv $FILE $DIR_OUT

done

exit