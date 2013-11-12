# this script will export all .shp files in a directory to .geojson files in a specified subdirectory 
# ************************************************************************************************************
#!/bin/bash

NEWDIR=${2:-"$1/geojson"}
for FILE in ${1:-}*.shp # cycles through all files in directory (case-sensitive!)
do
	echo "converting file: $FILE..."
	FILENEW=`echo | basename $FILE | sed "s/.shp/_new.geojson/"` # replaces old filename
	ogr2ogr \
	-f "GeoJSON" \
	$NEWDIR$FILENEW $FILE
done
exit
