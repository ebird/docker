# add r and python geospatial tools
FROM mstrimas/tidyverse

MAINTAINER "Matt Strimas-Mackey" mes335@cornell.edu
LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# install spatial packages, from https://hub.docker.com/r/rocker/geospatial/dockerfile
RUN apt-get update \
  # connect to ubuntugis/ubuntugis-unstable to get latest versions of spatial libraries
  && add-apt-repository ppa:ubuntugis/ubuntugis-unstable -y \
  && apt-get install -y \
    lbzip2 \
    libfftw3-dev \
    libgeos-dev \
    libgdal-dev \
    libgsl0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libhdf4-alt-dev \
    libjq-dev \
    libmysqlclient-dev \
    libpq-dev \
    libproj-dev \
    libprotobuf-dev \
    libnetcdf-dev \
    libsqlite3-dev \
    libssl-dev \
    libudunits2-dev \
    netcdf-bin \
    postgis \
    protobuf-compiler \
    sqlite3 \
    tk-dev \
    unixodbc-dev
    
# gdal binaries, including python bindings
RUN apt-get update \
  && apt-get install -y gdal-bin python3-dev python3-pip python3-numpy python3-gdal \
  && git clone https://github.com/mstrimas/gdal-summarize.git \
  && mv gdal-summarize/gdal-summarize.py /usr/bin/ \
  && rm -rf gdal-summarize/
  
# install spatial packages, from https://hub.docker.com/r/rocker/geospatial/dockerfile
RUN install.r \
    RColorBrewer \
    RandomFields \
    RNetCDF \
    countrycode \
    classInt \
    fasterize \
    geofacet \
    gstat \
    hdf5r \
    janitor \
    lwgeom \
    mapproj \
    ncdf4 \
    proj4 \
    raster \
    rasterVis \
    rgdal \
    rgeos \
    rnaturalearth rnaturalearthdata \
    sf \
    sp \
    stars \
    spacetime \
    spatstat \
    spdep \
    geoR \
    geosphere \
  && installGithub.r rspatial/terra r-barnes/dggridR ropensci/rnaturalearthhires

# fix proj issue on singularity  
RUN echo 'PROJ_LIB=/usr/share/proj/' >> /usr/lib/R/etc/Renviron
  
WORKDIR /home/docker/

CMD ["/start.sh"]