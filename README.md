shell_scripts
=============

Bash [shell scripts](http://en.wikipedia.org/wiki/Shell_script) primarily for batch geoprocessing spatial data using the OGR2OGR utility, a part of the Geospatial Data Abstract Library: [GDAL](http://www.gdal.org/ogr2ogr.html)

There are also a few scripts in here for doing other useful things such as a batch find and replace. 

## The Scripts
* [clip-extent-project.sh](#clip-extent-projectsh)
* [clip-raster-to-shp.sh](#clip-raster-to-shpsh)
* [clip-to-polygon.sh](#clip-to-polygonsh)
* [geojson-to-shp.sh](#geojson-to-shpsh)
* [get-extent.sh](#get-extentsh)
* [gpx-to-shp.sh](#gpx-to-shpsh)
* [grep-find-replace.sh](#grep-find-replacesh)
* [make-hillshades.sh](#make-hillshadesh)
* [merge.sh](#mergesh)
* [project-google.sh](#project-googlesh)
* [project-mercator.sh](#project-mercatorsh)
* [project-wgs84.sh](#project-wgs84sh)
* [rename-files-gis-friendly.sh](#rename-files-gis-friendlysh)
* [separate-roads-by-type.sh](#separate-roads-by-typesh)
* [shp-to-geojson.sh](#shp-to-geojsonsh)

## Requirements
###Mac OS X:
Install [**GDAL**](http://gdal.org/) via either [**King Chaos**](http://www.kyngchaos.com/software/qgis) or [**Homebrew**](http://brew.sh/).  

If installing through **King Chaos** be sure to follow the instructions for appending the **GDAL** utilities' absolute path to the `PATH` variable in your `.bash_profile` or `.bashrc` file in your home directory.  

###Linux:

Install FWTools (the Linux 64-bit version is [here](http://fwtools.maptools.org/linux-experimental.html)).

###Test:

Make sure `ogr2ogr` is working in Bash with basic command: `ogrinfo --version`

You should get back something like:

    GDAL 1.11.0, released 2014/04/16

You can either add the shell_scripts directory to your `PATH` or run the commands with the full file path.

##FAQ
The scripts I authored in this repository were written while working with Cartographic Design software that primarily uses the ESRI Shapefile format. Thus most of these scripts assume that is your desired output (and sometimes input) data format unless otherwise specified. Use the `shp-to-geojson` and `geojson-to-shp` scripts to convert data between the ESRI Shapefile and GeoJSON data formats as needed.

Many of these scripts contain variables that must be edited to in order to change their paramaters. I plan on updating this in the future as I originally wrote these when first learning bash scripting and did not fully understand how to implement $ARGV when running a script. For now open the scripts with a text editor and change variables for things like output projection (eg: `$T_SRS`).

You will have to set the executible permission for these scripts before you can run them. First `cd` to the folder in which they live and do `chmod +ux *` to make them executible.

## Reference Material
These resources have helped me out in learning to build the `ogr2ogr` shell scrips:

* [Directory of Spatial Reference Systems (SRS)](http://spatialreference.org/ref/)

* FYI, GitHub currently likes (i.e., requires) data in the [CRS](http://en.wikipedia.org/wiki/Spatial_reference_system) `urn:ogc:def:crs:OGC:1.3:CRS84` / `EPSG:4326` for displaying geoJSON.

* [List of OGR-supported Vector Formats](http://www.gdal.org/ogr/ogr_formats.html)...*so many options!*

* This [Unix shell scripting tutorial](https://supportweb.cs.bham.ac.uk/documentation/tutorials/docsystem/build/tutorials/unixscripting/unixscripting.html)

## Scripts

### clip-extent-project.sh
Clips data given bounding box coordinates and projects to an output CRS. Change variable assignments within the script for these parameters.  
####Supported Types  
ESRI Shapefile  
####Usage  
`cd` to the directory of your `.shp` data and do 
`./clip-extent-project.sh`  
####Sample Output  
`test`

### clip-raster-to-shp.sh
Clips a raster dataset to a shapefile polygon. Both datasets must be in the same projection / CRS.  
####Supported Types  
`.shp` and GDAL supported raster formats.  
####Usage  
`./clip-raster-to-shp.sh polygon-to-clip-to.shp raster-data.tiff`
####Sample Output  
`test`

### clip-to-polygon.sh
Clips all data to a shapefile polygon.  
####Supported Types  
`.shp`  
####Usage  
Edit the `CLIP` variable in the script to specify the clipping polygon.  
`cd` to directory containing `.shp` data and do
`./clip-to-polygon.sh`  
####Sample Output  
`test`

### geojson-to-shp.sh
This script will export all .geojson files in a directory to .shp files in a specified subdirectory.  
####Supported Types  
`.geojson`  
####Usage  
`cd` to the directory of `.geojson` files you want to convert
`./$SCRIPTHOME/geojson-to-shp.sh`  
####Sample Output  
Writes new files to a `data` subdirectory.  

### get-extent.sh
Returns bounding box coordinates for a dataset.  
####Supported Types  
`.shp`  
####Usage  
`./get-extent.sh $DIR/$FILE`  
####Sample Output  
`-84.391994 33.758135 -84.376599 33.754353`

### gpx-to-shp.sh
Converts all `.gpx` files in a directory into separate `.shp` files  
for the following `.gpx` data layers: `tracks`, `way points` and `track points`  
assuming the `.gpx` file contains these layers.  
####Supported Types  
`.gpx`  
####Usage  
`./gpx-to-shp.sh`  
####Sample Output  

```
some_gpx_file_tracks_2223.shp  
some_gpx_file_points_2223.shp
some_gpx_file_waypoints_2223.shp
```

### grep-find-replace.sh
search through files in a directory and perform a find and replace.  
####Supported Types  
`.txt, .html, .css, etc.`  
####Usage  
`./grep-find-replace.sh`  
####Sample Output  
`test`

### make-hillshades.sh
Takes a Digital Elevation Model (DEM) raster and generates hillshades from 4 different light angles and a slope shade.These 5 files may then be composited in QGIS, TileMill, Photoshop, etc.  

**Note:** Requires a `color-slope.txt` file containing the following: 

```
0 255 255 255
90 0 0 0 
```
**Suggestion:** Process DEM prior to running this script (mosaic, clip, resample, reproject, etc).  
####Supported Types  
GDAL supported Raster files.  
####Usage  
`cd` to the folder containing the DEM  
then do: `./make-hillshades.sh some-input-dem.flt`  
####Sample Output  

```
hillshade_az45.tif  
hillshade_az135.tif  
hillshade_az225.tif  
hillshade_az315.tif  
slope.tif  
slopeshade.tif
```

### merge.sh
merges a directory of shapefiles.  
####Supported Types  
`.shp`
####Usage  
`cd` to the folder containing files to merge
copy a shapefile to merge other shapefiles to by doing
`ogr2ogr merge.shp shapefile-to-merge-everything-to.shp`
then do
`./merge.sh`
####Sample Output  
`test`

### project-google.sh
projects data to google web-mercator projection `EPSG:900913`
####Supported Types  
`.shp`
####Usage  
`./project-google.sh`
####Sample Output  
`test`

### project-mercator.sh
projects data to WGS 94 / World Mercator `EPSG:3395`
####Supported Types  
`.shp`
####Usage  
change the `-s_srs` input to your data's source CRS
then `cd` to the folder containing your data and do
`./project-mercator.sh`
####Sample Output  
`test`

### project-wgs84.sh
Projects data to WGS 84 `EPSG:4326`
####Supported Types  
`.shp`
####Usage  
`./project-wgs84.sh`
####Sample Output  
`test`

### rename-files-gis-friendly.sh
Changes filenames in a directory to be GIS / database friendly by  
removing all white spaces and making characters lowercase
####Supported Types  
`.abc`
####Usage  
`./xxx_yyy.sh $ARGS`
####Sample Output  
`test`

### separate-roads-by-type.sh
Takes an OpenStreetMap `roads.shp` file extracted from a source such as [bbbike.org](http://extract.bbbike.org) and parses into multiple shapefiles based on the aggregating values from the `type` field.  
Will reproject all files to a desired CRS and append EPSG code to the end of the file name.  
####Supported Types  
`.shp`
####Usage  
`./separate-roads-by-type.sh`
####Sample Output  

```
roads_motorways_2227.shp  
roads_motorway-links_2227.shp   
roads_main-rd_2227.shp  
roads_main-rd-links_2227.shp    
roads_other-rd_2227.shp  
roads_dirt-rd_2227.shp            
roads_trails_2227.shp
```

### shp-to-geojson.sh
This converts all shapefiles in a directory `$DIR1` into geoJSON files in `$DIR2`.  If `$DIR1` is not specified, the script looks in the present working directory.  If `$DIR2` is not specificied, the script will place the new geoJSON files in a new subdirectory called `geojson`.  
####Supported Types  
`.shp`
####Usage  
`./shp-to-geojson.sh $DIR1 $DIR2`
####Sample Output  
`converting file: /data/bike_lanes.shp...`
