# this script will clean up gpx data for rendering in illustrator with mapublisher.
# separate gpx data into one shapefile for lines, a shapefile for waypoints, and a shapefile for track points,
# and project data to a desired CRS
# ************************************************************************************************************
#!/bin/bash

# script variables assigned as follows:
OUTDR='/Users/chrislhenrick/Cartography/projects/rHenrick/mike_pct_map/data/shp_gps_waypoint_data'  # ouput directory here
TSRS='EPSG:4326'  # target CRS EPSG code here
PRJ=`echo $TSRS | sed s/\"//g | cut -f2 -d ':'`   # variable values for sed here:

# extract tracks and rename file
for FILE in *.gpx
do
 echo "converting $FILE file's tracks..."
 FILENEW=`echo $FILE | sed "s/.gpx/_tracks_$PRJ.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -t_srs $TSRS \
 $FILENEW $FILE \
 tracks

done

# extract waypoints and rename file
for FILE in *.gpx
do
 echo "converting $FILE file's waypoints..."
 FILENEW=`echo $FILE | sed "s/.gpx/_waypoints_$PRJ.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -t_srs $TSRS \
 $FILENEW $FILE \
 waypoints
 
done

# extract track points and rename file
for FILE in *.gpx
do
 echo "converting $FILE file's waypoints..."
 FILENEW=`echo $FILE | sed "s/.gpx/_track-points_$PRJ.shp/"`
 ogr2ogr \
 -f "ESRI Shapefile" \
 -t_srs $TSRS \
 $FILENEW $FILE \
 track_points
 
done

# move files into an output directory
for FILE in *$PRJ*
do
 echo "moving $FILE to $OUTDR..."
 mv $FILE $OUTDR

done
 
exit