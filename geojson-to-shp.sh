# this script will export all .geojson files in a directory to .shp files in a specified subdirectory 
# ************************************************************************************************************
#!/bin/bash

NEWDIR="shp/"
mkdir $NEWDIR # creates new subdirectory
for FILE in *.geojson # cycles through all files in directory (case-sensitive!)
do
	echo "converting file: $FILE..."
	FILENEW=`echo $FILE | sed "s/.geojson/.shp/"` # replaces old filename
	ogr2ogr \
	-f "ESRI Shapefile" \
	$NEWDIR$FILENEW $FILE
done
exit
