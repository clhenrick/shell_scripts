shell_scripts
=============

Bash [shell scripts](http://en.wikipedia.org/wiki/Shell_script) primarily for batch geoprocessing spatial data using the OGR2OGR utility, a part of the Geospatial Data Abstract Library: [GDAL.](http://www.gdal.org/ogr2ogr.html)  

These scripts are useful when open-source GIS applications such as [QGIS](http://qgis.org/en/site/) do not allow for batch processing directories of vector spatial data. Additionally, invoking the scripts from a shell (such as the [Terminal.App](http://en.wikipedia.org/wiki/Terminal_%28OS_X%29) in Mac OSX) allows for heavy data processing to be run in the background while freeing up a GIS software to be used simultaneously for visualization and analysis.

There are also a few scripts in here for doing other useful things such as a batch find and replace or renaming files to be database and GIS friendly. 

## The Scripts
* [clip-extent-project.sh](#clip-extent-projectsh)
* [clip-raster-to-shp.sh](#clip-raster-to-shpsh)
* [clip-to-polygon.sh](#clip-to-polygonsh)
* [geojson-to-shp.sh](#geojson-to-shpsh)
* [get-extent.sh](#get-extentsh)
* [gpx-to-shp.sh](#gpx-to-shpsh)
* [grep-find-replace.sh](#grep-find-replacesh)
* [make-hillshades.sh](#make-hillshadessh)
* [merge.sh](#mergesh)
* [project-google.sh](#project-googlesh)
* [project-mercator.sh](#project-mercatorsh)
* [project-wgs84.sh](#project-wgs84sh)
* [rename-files-gis-friendly.sh](#rename-files-gis-friendlysh)
* [separate-roads-by-type.sh](#separate-roads-by-typesh)
* [shp-to-geojson.sh](#shp-to-geojsonsh)

## Requirements
You must install [**GDAL**](http://gdal.org/) and be able to access its utilities from the command line.  

###Mac OS X:
Install GDAL via either [**King Chaos**](http://www.kyngchaos.com/software/qgis) or [**Homebrew**](http://brew.sh/).  

If installing through **King Chaos** be sure to follow the instructions for appending the **GDAL** utilities' absolute path to the `PATH` variable in your `.bash_profile` or `.bashrc` file in your home directory.  

###Linux:

Install **FWTools** (the Linux 64-bit version is [here](http://fwtools.maptools.org/linux-experimental.html)).

###Test:

Make sure `ogr2ogr` is working in Bash with basic command: `ogrinfo --version`

You should get back something like:

    GDAL 1.11.0, released 2014/04/16

You can either add the shell_scripts directory to your `PATH` or run the commands with the full file path.

##FAQ
The scripts I authored in this repository were written while working with Cartographic Design & GIS software that primarily uses the [ESRI Shapefile format](http://en.wikipedia.org/wiki/Shapefile) for storing vector spatial data. Thus most of these scripts assume that is your desired output (and sometimes input) data format unless otherwise specified. Use the `shp-to-geojson` and `geojson-to-shp` scripts to convert data between the ESRI Shapefile and GeoJSON data formats as needed.

Many of these scripts contain variables that must be edited to in order to change their paramaters. Before running open the script of choice with a text editor and change variable assignments for parameters such as output projection (eg: `T_SRS=EPSG:4326`).

**Note:** *You must set the executible permission for these scripts before you can run them.* First `cd` to the folder in which they live and do `chmod +ux *` to make them executible.

## Reference Material
These resources have helped me out in learning to build the `ogr2ogr` shell scrips:

* [Directory of Spatial Reference Systems (SRS)](http://spatialreference.org/ref/)

* FYI, GitHub currently likes (i.e., requires) data in the [CRS](http://en.wikipedia.org/wiki/Spatial_reference_system) `urn:ogc:def:crs:OGC:1.3:CRS84` / `EPSG:4326` for displaying geoJSON.

* [List of OGR-supported Vector Formats](http://www.gdal.org/ogr/ogr_formats.html)...*so many options!*

* This [Unix shell scripting tutorial](https://supportweb.cs.bham.ac.uk/documentation/tutorials/docsystem/build/tutorials/unixscripting/unixscripting.html)

## Script Descriptions

### clip-extent-project.sh
Clips data given bounding box coordinates and projects to an output CRS. Change variable assignments within the script for these parameters.  
####Supported Types  
ESRI Shapefile  
####Usage
**variables:**  

```
LAT_MIN # minimum latitude  (min y value)
LON_MIN # minimum longitude ( min x value)
LAT_MAX # maximum latitude  (max y value)
LON_MAX # maximum longitude (max x value)
S_SRS  #data's source coordinate system / projection
T_SRS   #data's target coordinate system / projection
DIR_OUT # set absolute path for output .shp files here
PRJ # extracts EPSG code from T_SRS to append to filename
```
  
`cd` to the directory of your `.shp` data and do 
`./clip-extent-project.sh`  
####Sample Output  
`test`

### clip-raster-to-shp.sh
Clips raster datasets to a shapefile polygon. Both the raster and vector datasets must be in the same projection / CRS.  
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
**variables:**

```
CLIP # absolute path to clipping .shp polygon
DIR_OUT # absolute path for output .shp files
```

`cd` to directory containing `.shp` data and do
`./clip-to-polygon.sh`  
####Sample Output  
`test`

### geojson-to-shp.sh
This script will export all `.geojson` files in a directory to `.shp` files in a specified subdirectory.  
####Supported Types  
`.geojson`  
####Usage  
**variables:**  
`NEWDIR # Path for new sub-directory for output .shp files`  

`cd` to the directory of `.geojson` files you want to convert
`./geojson-to-shp.sh`  
####Sample Output  
Writes new files to a subdirectory.  

### get-extent.sh
Returns bounding box coordinates for a dataset as:  
`<x_min> <y_min> <x_max> <y_max>`
####Supported Types  
`.shp`  
####Usage  
`./get-extent.sh $DIR/$FILE`  
####Sample Output  
`-84.391994 33.758135 -84.376599 33.754353`

### gpx-to-shp.sh
Converts all `.gpx` files in a directory into separate `.shp` files for the following `.gpx` data layers:  
`tracks`, `way points` and `track points` assuming the `.gpx` file contains data for these layers.  
####Supported Types  
`.gpx`  
####Usage  
**variables:**  

```
OUTDR # absolute path for .shp files here
TSRS # target CRS EPSG code
PRJ # extracts EPSG code from $TSRS to append to filename
```
`./gpx-to-shp.sh`  
####Sample Output  

```
some_gpx_file_tracks_2223.shp  
some_gpx_file_points_2223.shp
some_gpx_file_waypoints_2223.shp
```

### grep-find-replace.sh
Search through all files in a directory and perform a find and replace on text inside those files.  
####Supported Types  
`.txt, .html, .css, etc.`  
####Usage  
**variables:**  

```
startdirectory # directory to search in
searchterm # file name to search for
replaceterm # file name to move / replace
```
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
**Suggestion:** Process DEM data prior to running this script (mosaic, clip, resample, reproject, etc).  
####Supported Types  
GDAL supported Raster files.  
####Usage  
**variables:**  
`Z # vertical exaggeration factor. Default is 1`

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
Merges a directory of shapefiles. Copies the first `.shp` file as the target to merge to and then appends each following `.shp` file to it.  
**Caveats:** Files must be of same geometry. If attribute schema differs between files you will end up with a huge attribute table.
####Supported Types  
`.shp`
####Usage  
**variables:**  

```
FILE # name of .shp file to be merged to (will be created if it doesn't yet exist)
LAYER # must be same as above but without `.shp` extension
SSRS # source CRS
TSRS # target CRS
```

`cd` to the folder containing files to merge
copy a shapefile to merge other shapefiles to by doing
`ogr2ogr merge.shp shapefile-to-merge-everything-to.shp`
then do
`./merge.sh`
####Sample Output  
`test`

### project-web-mercator.sh
Projects all data in a directory to web-mercator projection `EPSG:3857`
####Supported Types  
`.shp`
####Usage  
**variables:**  
`$1 # source CRS of target data`  

do:  
`./project-web-mercator.sh <EPSG code>`
####Sample Output  
`test`

### project-mercator.sh
Projects all data in a directory to WGS 94 / World Mercator `EPSG:3395`
####Supported Types  
`.shp`
####Usage  
**variables:**  
`$1 # source CRS of target data`  

`cd` to the folder containing your data and do
`./project-mercator.sh <EPSG code>`
####Sample Output  
`test`

### project-wgs84.sh
Projects all data in a directory to WGS 84 `EPSG:4326`
####Supported Types  
`.shp`
####Usage  
**variables:**  
`$1 # source CRS of target data` 

`./project-wgs84.sh <EPSG code>`
####Sample Output  
`test`

### rename-files-gis-friendly.sh
Modifies all filenames in a directory to be GIS / database friendly by  
replacing white spaces with underscores and making all characters lowercase.
####Supported Types  
any
####Usage  
`./rename-files-gis-friendly.sh`
####Sample Output  
`test`

### separate-roads-by-type.sh
Takes a generic OpenStreetMap `roads.shp` file extracted from a Planet OSM source such as [bbbike.org](http://extract.bbbike.org) and parses into multiple shapefiles based on the aggregating values from the `type` field.  
Will reproject all files to a desired CRS and append EPSG code to the end of the file name.  
####Supported Types  
`.shp`
####Usage  
**variables:**  

```
ROADS # the name of your OSM roads layer file, must have a type field name and be named roads.shp
TSRS # target CRS
PRJ # extracts EPSG code from T_SRS to append to filename
DIR_OUT # set absolute path for output .shp files here
````
`cd` to folder containing `roads.shp` and do: `./separate-roads-by-type.sh`
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
Converts all shapefiles in a directory `$DIR1` into geoJSON files in `$DIR2` and reprojects to `EPSG:4326`.  

If `$DIR1` is not specified, the script looks in the present working directory.  If `$DIR2` is not specificied, the script will place the new geoJSON files in a new subdirectory called `geojson`.

**Note:** if on Mac OSX you must specify input and output directories or script will fail due to stupid unix differences between Linux and OSX.  
####Supported Types  
`.shp`
####Usage  
`./shp-to-geojson.sh $DIR1 $DIR2`
####Sample Output  
```
91764 bytes
converting file: ./roads_2277.shp into roads_2277.geojson...
```
