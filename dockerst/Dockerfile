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
RUN python3 -m pip install matplotlib

# duckdb
RUN wget https://github.com/duckdb/duckdb/releases/download/v0.2.7/duckdb_cli-linux-amd64.zip \
    unzip duckdb_cli-linux-amd64.zip -d /usr/bin/ \
    rm duckdb_cli-linux-amd64.zip

# R packages needed
RUN install.r \
    DBI DescTools MASS PresenceAbsence RSQLite \
    argparse auk \
    car \
    digest \
    exactextractr \
    fastshap fields \
    gbm grf \
    landscapemetrics lutz \
    mgcv \
    pryr prioritizr \
    ranger readr \
    scam smoothr suncalc \
    units uuid \
  && installGithub.r \
    cornelllabofornithology/auk \
    cornelllabofornithology/ebirdst@dev_erd2019 \
    walkerke/mapboxapi

WORKDIR /home/docker/

CMD ["/start.sh"]
