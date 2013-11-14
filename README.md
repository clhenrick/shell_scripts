shell_scripts
=============

Bash shell scripts primarily for batch geoprocessing spatial data using the OGR2OGR utility, a part of the Geospatial Data Abstract Library: [GDAL](http://www.gdal.org/ogr2ogr.html)

There are a few other scripts in here for doing other useful things. 

## Requirements
####Mac OS X:
Install GDAL Complete framework package via [King Chaos](http://www.kyngchaos.com/software/qgis)
Be sure to follow the instructions for adding the path to your bash_profile or bashrc.

####Linux:

Install FWTools (I used the Linux 64-bit version which is [here](http://fwtools.maptools.org/linux-experimental.html).

####Test:

Make sure ogr2ogr is working in command line with basic command: `ogrinfo --version`

You should get back something like:

    GDAL 1.10.0, released 2013/04/24

You can either add the shell_scripts directory to your `PATH` or run the commands with the full file path.

## Reference Material
These resources have helped me a lot in building the `ogr2ogr` batch commands:

* [Directory of Spatial Reference Systems (SRS)](http://spatialreference.org/ref/)

* FYI, GitHub currently likes (i.e., requires) `urn:ogc:def:crs:OGC:1.3:CRS84` for displaying geoJSON.
* [List of OGR-supported Vector Formats](http://www.gdal.org/ogr/ogr_formats.html)...*so many options!*
* 
* This [Unix shell scripting tutorial](https://supportweb.cs.bham.ac.uk/documentation/tutorials/docsystem/build/tutorials/unixscripting/unixscripting.html)

##FAQ
The scripts I authored in this repository were written while working with Cartographic Design software that primarily uses the ESRI Shapefile format. Thus most of these scripts assume that is your data format unless otherwise specified. Use the `shp-to-geojson` and `geojson-to-shp` scripts to convert data between these two common data formats as needed.

Many of these scripts contain variables that must be edited to in order to change their paramaters. I plan on updating this in the future as I originally wrote these when first learning bash scripting and did not fully understand how to implement $ARGV when running a script. For now open the scripts with a text editor and change variables for things like output projection (eg: `$T_SRS`).

You will have to set the executible permission for these scripts before you can run them. `cd` to the folder in which they live and `chmod +ux *` to make them executible.

## Scripts
* [clip-extent-project.sh](#clip-extent-projectsh)
* [clip-raster-to-shp.sh](#clip-raster-to-shpsh)
* [clip-to-polygon.sh](#clip-to-polygonsh)
* [geojson-to-shp.sh](#geojson-to-shpsh)
* [get-extent.sh](#get-extentsh)
* [gpx-to-shp.sh](#gpx-to-shpsh)
* [grep-find-replace.sh](#grep-find-replacesh)
* [merge.sh](#mergesh)
* [project-google.sh](#project-googlesh)
* [project-mercator.sh](#project-mercatorsh)
* [project-wgs84.sh](#project-wgs84sh)
* [rename-files-gis-friendly.sh](#rename-files-gis-friendlysh)
* [separate-roads-by-type.sh](#separate-roads-by-typesh)
* [separate-roads-by-type-skeletron.sh](#separate-roads-by-type-skeletronsh)


### clip-extent-project.sh
#### Description
Clips data given bounding box coordinates and projects to an output CRS. Change variable assignments within the script for these parameters.
#### Supported Types
ESRI Shapefile
#### Usage
`cd` to the directory of your `.shp` data
`./clip-extent-project.sh`
#### Sample Output
`test`
### clip-raster-to-shp.sh
#### Description
Clips a raster dataset to a shapefile polygon. Both datasets must be in the same projection.
#### Supported Types
`.shp` and GDAL supported raster formats.
#### Usage
`./clip-raster-to-shp.sh polygon-to-clip-to.shp raster-data.tiff`
#### Sample Output
`test`
### clip-to-polygon.sh
#### Description
clips all data to a shapefile polygon
#### Supported Types
`.shp`
#### Usage
Edit the `CLIP` variable in the script to specify the clipping polygon.
`cd` to directory containing `.shp` data
`./clip-to-polygon.sh`
#### Sample Output
`test`
### geojson-to-shp.sh
#### Description
This script will export all .geojson files in a directory to .shp files in a specified subdirectory
#### Supported Types
`.geojson`
#### Usage
`cd` to the directory of `.geojson` files you want to convert
`./$SCRIPTHOME/geojson-to-shp.sh`
#### Sample Output
Writes new files to a `data` subdirectory.
### get-extent.sh
#### Description
returns bounding box coordinates for a dataset 
#### Supported Types
`.shp`
#### Usage
`./get-extent.sh $DIR/$FILE`
#### Sample Output
`-84.391994 33.758135 -84.376599 33.754353`
### gpx-to-shp.sh
#### Description
converts `.gpx` files to `.shp` format
#### Supported Types
`.gpx`
#### Usage
`./xxx_yyy.sh $ARGS`
#### Sample Output
`test`
### grep-find-replace.sh
#### Description
search through files in a directory and perform a find and replace.
#### Supported Types
`.txt, .html, .css, etc.`
#### Usage
`./grep-find-replace.sh`
#### Sample Output
`test`
### merge.sh
#### Description
merges a directory of shapefiles.
#### Supported Types
`.shp`
#### Usage
`cd` to the folder containing files to merge
copy a shapefile to merge other shapefiles to by doing
`ogr2ogr merge.shp shapefile-to-merge-everything-to.shp`
then do
`./merge.sh`
#### Sample Output
`test`
### project-google.sh
#### Description
projects data to google web-mercator projection `EPSG:900913`
#### Supported Types
`.shp`
#### Usage
`./project-google.sh`
#### Sample Output
`test`
### project-mercator.sh
#### Description
projects data to WGS 94 / World Mercator `EPSG:3395`
#### Supported Types
`.shp`
#### Usage
change the `-s_srs` input to your data's source CRS
then `cd` to the folder containing your data and do
`./project-mercator.sh`
#### Sample Output
`test`
### project-wgs84.sh
#### Description
Projects data to WGS 84 `EPSG:4326`
#### Supported Types
`.shp`
#### Usage
`./project-wgs84.sh`
#### Sample Output
`test`
### rename-files-gis-friendly.sh
#### Description
changes filenames in directory to be GIS friendly:
removes all white spaces and makes name lowercase
#### Supported Types
`.abc`
#### Usage
`./xxx_yyy.sh $ARGS`
#### Sample Output
`test`
### separate-roads-by-type.sh
#### Description
Takes an OpenStreetMap `roads.shp` file extracted from [bbbike.org](http://extract.bbbike.org) and parses into multiple shapefiles based on the `type` field.
#### Supported Types
`.shp`
#### Usage
`./separate-roads-by-type.sh`
#### Sample Output
`test`
### separate-roads-by-type-skeletron.sh
#### Description
Same as above but uses input generated from Michael Migurski's [Skeletron.py]() script
#### Supported Types
`.abc`
#### Usage
`./xxx_yyy.sh $ARGS`
#### Sample Output
`test`
### shp-to-geojson.sh
#### Description
This converts all shapefiles in a directory `$DIR1` into geoJSON files in `$DIR2`.  If `$DIR1` is not specified, the script looks in the present working directory.  If `$DIR2` is not specificied, the script will place the new geoJSON files in a new subdirectory called `geojson`.
#### Supported Types
`.shp`
#### Usage
`./shp-to-geojson.sh $DIR1 $DIR2`
#### Sample Output
`converting file: /data/bike_lanes.shp...`
