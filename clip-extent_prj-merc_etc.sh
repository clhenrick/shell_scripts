#!/bin/bash

#clip all shapefiles to specified lat lon bounding coordinates (x min y min x max y max)
for FILE in *.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_clip.shp/"`
 ogr2ogr \
 -clipsrc -179.9 42 -115 77\
 $FILENEW  $FILE

done

#project all clipped data to...
for FILE in *_clip.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_3338.shp/"`
 ogr2ogr \
-s_srs "EPSG:4326" -t_srs "EPSG:3338"   \
$FILENEW  $FILE\

done

#move all clipped and projected files to a temp folder
for FILE in *_3338.*
do
 echo "moving $FILE file..."
 mv $FILE /path/to/folder/
 
done

#delete all clipped files still in wgs84 that won't be needed.
for FILE in *_clip.*
do
 echo "deleting $FILE file..."
 rm $FILE
 
done





