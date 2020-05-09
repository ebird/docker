## Docker images for eBird Status and Trends

A set of Docker images for geospatial analysis in R built on Ubuntu. These images borrow heavily from the [Rocker project](https://hub.docker.com/u/rocker/), especially their `rocker/geospatial` images, with the following modifications:

- Ubuntu rather than Debian based
- Up-to-date versions of GDAL and PROJ are included
- Includes GDAL binaries and Python GDAL bindings
- RStudio Server is not included

The following three images are included, each building upon the previous:

- `mstrimas/tidyverse`: R + Tidyverse packages, similar to `rocker/tidyverse`
- `mstrimas/geospatial`: includes current geospatial libraries, GDAL binaries, and a suite of geospatial R packages
- `mstrimas/dockerst`: includes some additional utilities and R packages specifically for the eBird Status and Trends project