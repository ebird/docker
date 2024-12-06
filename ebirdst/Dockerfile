FROM rocker/r-ver:4.4.0

LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# create key directories for bridges2 and anvil
RUN mkdir /ocean && mkdir /jet && mkdir /anvil && mkdir /apps

# install Python a variety of system utilities
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    ed \
    expect \
    ffmpeg \
    imagemagick libmagick++-dev \
    git \
    less \
    locales \
    python3-dev python3-pip \
    nano \
    rsync \
    software-properties-common \
    sqlite3 \
    vim-tiny \
    wget
    
# ImageMagick default policy we were getting was extremely restrictive
# (Memory: 256MiB, Disk: 1GiB) which basically made it useless. We don't need
# to impose any system-wide restrictions like that so just remove policy and
# use ImageMagick defaults/commandline values.
RUN rm -f /etc/ImageMagick-6/policy.xml

# install tidyverse
RUN /rocker_scripts/install_tidyverse.sh

# geospatial packages
RUN /rocker_scripts/install_geospatial.sh
RUN install2.r \
  fasterize \
  landscapemetrics \
  mapproj \
  rnaturalearth rnaturalearthdata \
  && installGithub.r \
    ropensci/rnaturalearthhires
# prevent creation of sidecar files by gdal
ENV GDAL_PAM_ENABLED=NO

# additional required packages
RUN install2.r \
  argparse \
  car \
  DescTools \
  digest \
  doParallel \
  exactextractr \
  fastshap \
  fda \
  fields \
  foreach \
  gbm \
  googlesheets4 \
  grf \
  hexbin \
  h3jsr \
  lutz \
  MASS \
  mccf1 \
  mgcv \
  oce \
  patchwork \
  precrec \
  PresenceAbsence \
  protolite \
  magick \
  pryr \
  RColorBrewer \
  scam \
  scico \
  smoothr \
  tictoc \
  uuid \
  viridis \
  yardstick \
  && installGithub.r \
      cornelllabofornithology/auk \
      ebird/ebirdst \
      walkerke/mapboxapi \
      crazycapivara/h3-r \
      # temporary bug fix, change back to CRAN once new version is on CRAN
      datastorm-open/suncalc \
      # ranger has a bug in the C++ sampling code that this branch fixes
      # if this PR is merged, switch back to using the official repo
      # bug report: https://github.com/imbs-hl/ranger/issues/733
      # PR: https://github.com/imbs-hl/ranger/pull/734
      # imbs-hl/ranger \
      sligocki/ranger@sample_skip_bug

# Python packages
COPY requirements.txt /requirements.txt
RUN python3 -m pip install -r /requirements.txt
RUN apt-get update -y \
  && apt-get install -y \
    nvidia-cuda-toolkit
    
# install AWS CLI
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  && unzip awscli-exe-linux-x86_64.zip \
  && ./aws/install \
  && rm -rf aws awscli-exe-linux-x86_64.zip

# install duckdb, versions on cli, r, and python must match
ENV DUCKDB_VERSION=1.1.3
RUN wget https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip \
  && unzip duckdb_cli-linux-amd64.zip -d /usr/bin/ \
  && rm duckdb_cli-linux-amd64.zip \
  && duckdb :memory: "INSTALL sqlite;"
  
# tippecanoe for map tiles
RUN git clone https://github.com/mapbox/tippecanoe.git \
  && cd tippecanoe \
  && make -j \
  && make install \
  && cd .. \
  && rm -rf tippecanoe
  
# install jags
RUN apt-get update -y && apt-get install -y jags && install2.r rjags

CMD ["bash"]