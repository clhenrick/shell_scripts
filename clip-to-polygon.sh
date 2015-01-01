# clip all data in a directory to a specified polygon
# note: important! the clipping polygon and data being clipped must be in the same projection.

#!/bin/bash

# assign variable values for OGR parameters here:
CLIP='../shp_base_vector/00_clip_bounds.shp' # the shapefile name of your clipping polygon

# set path for output.shp files here
DIR_OUT='/Users/chrislhenrick/Cartography/projects/rHenrick/mike_pct_map/data/shp_base_vector/'

for FILE in *.shp
do
 echo "Clipping $FILE file to $CLIP..."
 FILENEW=`echo $FILE | sed "s/.shp/_clip.shp/"`
 ogr2ogr \
 -clipsrc $CLIP \
$FILENEW  $FILE

done

# move output files to a desired location (separate from original data)
for FILE in *_clip.*
do
 echo "moving $FILE file..."
 mv $FILE $DIR_OUT

done

exit

