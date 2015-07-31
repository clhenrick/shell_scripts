USER='clhenrick'
HOST='localhost'
DB='grand_circle'
PORT='5432'
PW=''

for FILE in *.shp
do
  echo "importing $FILE to $DB..."
  BASE=`basename $FILE .shp`
  ogr2ogr -f 'PostgreSQL' \
          -skipfailures \
          PG:"host=$HOST  \
              user=$USER \
              port=$PORT \
              dbname=$DB \
              password=$PW" \
              $FILE -nln $BASE

done
