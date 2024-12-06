## Docker images for eBird Status and Trends

A set of Docker images for geospatial analysis in R built on Ubuntu. These images borrow heavily from the [Rocker project](https://hub.docker.com/u/rocker/), especially their `rocker/geospatial` images, with the following modifications:

- Ubuntu rather than Debian based
- Up-to-date versions of GDAL and PROJ are included
- Includes GDAL binaries and Python GDAL bindings
- RStudio Server is not included

The following three images are included, each building upon the previous:

- `ebirdst/tidyverse`: R + Tidyverse packages, similar to `rocker/tidyverse`
- `ebirdst/geospatial`: includes current geospatial libraries, GDAL binaries, and a suite of geospatial R packages
- `ebirdst/dockerst`: includes some additional utilities and R packages specifically for the eBird Status and Trends project

### Usage

To start an interactive session within one of these containers use:

```
docker run --rm -it ebirdst/dockerst
```

To share files between the host machine and Docker container, use the `-v` flag to link a host directory to a container directory. For example, to link the current directory to the home directory in the container use:

```
docker run --rm -it -v $(pwd):/home/docker ebirdst/dockerst
```

## Users and permissions

By default, the container will be run as the root user. To run as a non-root user, use:

```
docker run --rm -it --user docker ebirdst/dockerst
```

If files created in the container are saved to a shared directory on the host machine, the owner of those files will be the user inside the container. In some cases this can cause file permission issues. To address this, use the following command to start the container, which will ensure the host and container users are the same:

```
docker run --rm -it -v $(pwd):/home/docker -e USER=$USER -e USERID=$UID ebirdst/dockerst
```