#!/bin/bash

# *************************************************************
# OGR2OGR -clipscr project 
# this script clips all data in a directory to a bounding box coordinates, projects clipped data to a desired SRS, \
# moves processed data to a new location, and removes unprojected clipped data.
# I find this useful for cartography when working with Natural Earth Data, see http://www.naturalearthdata.com/
# *************************************************************

# To do: make variables for the lat lon coordinates and for -s_srs and -t_srs
# this way the user can change the parameters in one place rather than throughout the script.
# *************************************************************

# clip all shapefiles to specified lat lon bounding coordinates (x min y min x max y max)
# note: data must be in WGS84, if in a different projection use that SRS' coordinate values 
# *************************************************************

for FILE in *.shp
do
 echo "clipping $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_clip.shp/"`
 ogr2ogr \
 -wrapdateline \
 -clipsrc -27.4 8 66.3 49.2 \
 $FILENEW  $FILE

done

# project all clipped data to a desired SRS such as EPSG:900913
# *************************************************************
# frequently used EPSG codes for projecting spatial data:
# 3395 wgs84 world mercator
# 900913 google web-mercator
# 3857 pseudo mercator (depreciated)

#project all clipped data to a desired SRS such as EPSG:3395 WGS84 World Mercator
for FILE in *_clip.shp
do
 echo "projecting $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_3395.shp/"`
 ogr2ogr \
-s_srs "EPSG:4326" -t_srs "EPSG:3395"\
 $FILENEW  $FILE\

done

# move all clipped and projected files to the project folder.
# *************************************************************

for FILE in *_3395.*
do
 echo "moving $FILE file..."
 mv $FILE /Volumes/Avalon/Mercator/Cartography/Perseus_Misc/AmericasGreatGame/00_DATA/shp_ne50m/

done

#delete all clipped, unprojected files in WGS84 (original coordinate system) that won't be needed.
#*************************************************************

for FILE in *_clip.*
do
 echo "deleting $FILE file..."
 rm $FILE
 
done





