#!/bin/bash

# this script clips all data in a directory to a bounding box coordinates, projects clipped data to a desired SRC, \
# moves processed data to a new location, and removes unprojected clipped data.
# I find this useful for cartography when working with Natural Earth Data, see http://www.naturalearthdata.com/
# *note: I realize that the clipsrc and -s_srs -t_srs can be stated in one command, but find it easier to clip by a bounding box using WGS84 coordinates

# clip all shapefiles to specified lat lon bounding coordinates (x min y min x max y max)
# note: data must be in WGS84, if in a different projection use that SRS' coordinate values 
for FILE in *.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_clip.shp/"`
 ogr2ogr \
 -clipsrc -27.4 -44.1 65.6 45.4\
 $FILENEW  $FILE

done

#project all clipped data to a desired SRS such as EPSG:3395 WGS84 World Mercator
for FILE in *_clip.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_3395.shp/"`
 ogr2ogr \
-s_srs "EPSG:4326" -t_srs "EPSG:3395"\
 $FILENEW  $FILE\

done

#move all clipped and projected files to the project folder.
for FILE in *_3395.*
do
 echo "moving $FILE file..."
 mv $FILE /Volumes/Avalon/Mercator/Cartography/Perseus_Misc/Westview\ Press/African_Voices/00_DATA/shp_ne_50m
 
done

#delete all clipped, unprojected files still in WGS84 (original coordinate system) that won't be needed.
for FILE in *_clip.*
do
 echo "deleting $FILE file..."
 rm $FILE
 
done





