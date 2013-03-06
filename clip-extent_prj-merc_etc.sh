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

for FILE in *.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_clip.shp/"`
 ogr2ogr \
 -wrapdateline \
 -clipsrc --27.4 8 66.3 49.2 \
 $FILENEW  $FILE

done

# project all clipped data to a desired SRS such as EPSG:26904
#*************************************************************
# frequently used projections:
# 3395 wgs84 world mercator
# 900913 google web-mercator
# 3857 pseudo mercator (depreciated)

for FILE in *_clip.shp
do
 echo "Transforming $FILE file..."
 FILENEW=`echo $FILE | sed "s/.shp/_3338.shp/"`
 ogr2ogr \
-s_srs "EPSG:4326" -t_srs "EPSG: "\
 $FILENEW  $FILE\

done

#move all clipped and projected files to the project folder.
#*************************************************************

for FILE in *_3338.*
do
 echo "moving $FILE file..."
 mv $FILE /Volumes/Avalon/Mercator/Cartography/Handbooks/Anchorage_Denali_01/data/shp/natural-earth_50m_processed/ 
 
done

#delete all clipped, unprojected files still in WGS84 (original coordinate system) that won't be needed.
#*************************************************************

for FILE in *_clip.*
do
 echo "deleting $FILE file..."
 rm $FILE
 
done





