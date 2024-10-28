# add r and python geospatial tools
FROM mstrimas/tidyverse

LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# install spatial packages, from https://hub.docker.com/r/rocker/geospatial/dockerfile
RUN apt-get update \
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
    netcdf-bin nco \
    postgis \
    protobuf-compiler \
    sqlite3 \
    tk-dev \
    unixodbc-dev
    
# gdal binaries, including python bindings
RUN apt-get update \
  && apt-get install -y gdal-bin python3-dev python3-pip python3-numpy python3-gdal
  
# tippecanoe for map tiles
RUN git clone https://github.com/mapbox/tippecanoe.git \
  && cd tippecanoe \
  && make -j \
  && make install \
  && cd .. \
  && rm -rf tippecanoe
  
# install spatial packages, from https://hub.docker.com/r/rocker/geospatial/dockerfile
RUN  r -e 'install.packages(c("rgdal", "s2", "sf", "lwgeom", "ncdf4", "raster", "terra"), repos = "https://cloud.r-project.org", type = "source")' \
  && install.r \
    fasterize \
    hdf5r \
    landscapemetrics \
    mapproj \
    proj4 \
    rgeos \
    rnaturalearth rnaturalearthdata \
    stars \
  && installGithub.r \
    ropensci/rnaturalearthhires

# fix proj issue on singularity  
RUN echo 'PROJ_LIB=/usr/share/proj/' >> /usr/lib/R/etc/Renviron

# prevent creation of sidecar files by gdal
ENV GDAL_PAM_ENABLED=NO

# get things working on bridges2
RUN mkdir /ocean && mkdir /jet && mkdir /anvil && mkdir /apps
  
WORKDIR /home/docker/

CMD ["/start.sh"]