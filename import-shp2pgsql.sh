# import ESRI shapefiles into PostgreSQL using shp2pgsql

# change these variables to your liking
# database name
DB='grand_circle'
#character encoding
ENCODING='LATIN1'
#target projection
TSRS='4326'

for FILE in *.shp
do
  echo "importing $FILE to $DB..."
  BASE=`basename $FILE .shp`  
  shp2pgsql -W $ENCODING \
            -I -s $TSRS \
            $FILE $BASE $DB \
            | psql -d $DB

done