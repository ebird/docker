# docker image for ebird status and trends
FROM mstrimas/geospatial

MAINTAINER "Matt Strimas-Mackey" mes335@cornell.edu
LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# system tools needed
RUN apt-get update -y \
  && apt-get install -y \
    awscli \
    expect \
    ffmpeg \
    imagemagick libmagick++-dev \
    rsync

# ImageMagick default policy we were getting was extremely restrictive
# (Memory: 256MiB, Disk: 1GiB) which basically made it useless. We don't need
# to impose any system-wide restrictions like that so just remove policy and
# use ImageMagick defaults/commandline values.
RUN rm -f /etc/ImageMagick-6/policy.xml

# Python packages
RUN python3 -m pip install \
  click \
  matplotlib \
  pandas \
  pyarrow \
  PyYAML \
  scikit_learn \
  scipy \
  torch \
  tqdm
  
# R packages needed
RUN install.r \
    DBI DescTools MASS PresenceAbsence RSQLite \
    argparse \
    car \
    digest \
    exactextractr \
    fields \
    gbm googlesheets4 grf \
    h3jsr \
    landscapemetrics lutz \
    mccf1 mgcv \
    oce \
    precrec pryr prioritizr \
    readr \
    scam sessioninfo smoothr \
    units uuid \
    yardstick \
  && installGithub.r \
    cornelllabofornithology/auk \
    ebird/ebirdst \
    walkerke/mapboxapi \
    bgreenwell/fastshap \
    crazycapivara/h3-r \
    imbs-hl/ranger \
    ebird/fastmedian \ 
    # temporary bug fix, change back to CRAN once new version is on CRAN
    datastorm-open/suncalc
    
# install duckdb, versions on cli, r, and python must match
ENV DUCKDB_VERSION 0.9.2
# must manually install libssl1.0.0
RUN wget https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip \
  && unzip duckdb_cli-linux-amd64.zip -d /usr/bin/ \
  && rm duckdb_cli-linux-amd64.zip \
  && duckdb :memory: "INSTALL sqlite;" \
  && r -e 'remotes::install_version("duckdb", version = "0.9.2", repos = "https://cloud.r-project.org")' \
  && python3 -m pip install duckdb==${DUCKDB_VERSION}

# install jags
RUN apt-get update -y && apt-get install -y jags \
  && install.r rjags
  
WORKDIR /home/docker/

CMD ["/start.sh"]
