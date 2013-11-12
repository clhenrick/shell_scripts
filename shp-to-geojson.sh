# this script will export all .shp files in a directory to .geojson files in a specified subdirectory 
# ************************************************************************************************************
#!/bin/bash

NEWDIR=${2:-"$1/geojson"}
for FILE in ${1:-}*.shp # cycles through all files in directory (case-sensitive!)
do
	if [stat -c %s $FILE > 30000000]
	then
		echo "Skipping $FILE because it's pretty big and GitHub might complain!"
		continue
	fi
	echo "converting file: $FILE...into $NEWDIR$FILENEW..."
	FILENEW=`echo | basename $FILE | sed "s/.shp/_new.geojson/"` # replaces old filename
	ogr2ogr \
	-f "GeoJSON" \
	$NEWDIR$FILENEW $FILE
done
exit
