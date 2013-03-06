#*************************************************************
# OGR2OGR -clipscr project 
# this script clips all data in a directory to a bounding box coordinates, projects clipped data to a desired SRC, \
# moves processed data to a new location, and removes unprojected clipped data.
# I find this useful for cartography when working with Natural Earth Data, see http://www.naturalearthdata.com/
#*************************************************************


!/bin/bash

# clip all shapefiles to specified lat lon bounding coordinates (x min y min x max y max)
# note: data must be in WGS84, if in a different projection use that SRS' coordinate values 
#*************************************************************

<<<<<<< HEAD
=======
# this script clips all data in a directory to a bounding box coordinates, projects clipped data to a desired SRC, \
# moves processed data to a new location, and removes unprojected clipped data.
# I find this useful for cartography when working with Natural Earth Data, see http://www.naturalearthdata.com/
# *note: I realize that the clipsrc and -s_srs -t_srs can be stated in one command, but find it easier to clip by a bounding box using WGS84 coordinates

# clip all shapefiles to specified lat lon bounding coordinates (x min y min x max y max)
# note: data must be in WGS84, if in a different projection use that SRS' coordinate values 
>>>>>>> 84ce7010a254d49f7fe6a4dd86128256fc00a4af
for FILE in *.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_clip.shp/"`
 ogr2ogr \
<<<<<<< HEAD
 -wrapdateline \
 -clipsrc --27.4 8 66.3 49.2 \
=======
 -clipsrc -27.4 -44.1 65.6 45.4\
>>>>>>> 84ce7010a254d49f7fe6a4dd86128256fc00a4af
 $FILENEW  $FILE

done

<<<<<<< HEAD
# project all clipped data to a desired SRS such as EPSG:26904
#*************************************************************
# frequently used projections:
# 3395 wgs84 world mercator
# 900913 google web-mercator
# 3857 pseudo mercator (depreciated)

=======
#project all clipped data to a desired SRS such as EPSG:3395 WGS84 World Mercator
>>>>>>> 84ce7010a254d49f7fe6a4dd86128256fc00a4af
for FILE in *_clip.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_3395.shp/"`
 ogr2ogr \
<<<<<<< HEAD
-s_srs "EPSG:4326" -t_srs "EPSG: "\
=======
-s_srs "EPSG:4326" -t_srs "EPSG:3395"\
>>>>>>> 84ce7010a254d49f7fe6a4dd86128256fc00a4af
 $FILENEW  $FILE\

done

#move all clipped and projected files to the project folder.
<<<<<<< HEAD
#*************************************************************

for FILE in *_3338.*
do
 echo "moving $FILE file..."
 mv $FILE /Volumes/Avalon/Mercator/Cartography/Handbooks/Anchorage_Denali_01/data/shp/natural-earth_50m_processed/ 
=======
for FILE in *_3395.*
do
 echo "moving $FILE file..."
 mv $FILE /Volumes/Avalon/Mercator/Cartography/Perseus_Misc/Westview\ Press/African_Voices/00_DATA/shp_ne_50m
>>>>>>> 84ce7010a254d49f7fe6a4dd86128256fc00a4af
 
done

#delete all clipped, unprojected files still in WGS84 (original coordinate system) that won't be needed.
<<<<<<< HEAD
#*************************************************************

=======
>>>>>>> 84ce7010a254d49f7fe6a4dd86128256fc00a4af
for FILE in *_clip.*
do
 echo "deleting $FILE file..."
 rm $FILE
 
done





