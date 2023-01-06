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
RUN python3 -m pip install matplotlib \
  && python3 -m pip install pandas \
  && python3 -m pip install pyarrow \
  && python3 -m pip install duckdb==0.5.0 \
  && python3 -m pip install click \
  && python3 -m pip install PyYAML \
  && python3 -m pip install scikit_learn \
  && python3 -m pip install scipy \
  && python3 -m pip install torch \
  && python3 -m pip install tqdm
  
# R packages needed
RUN install.r \
    DBI DescTools MASS PresenceAbsence RSQLite \
    argparse auk \
    car \
    digest \
    exactextractr \
    fields \
    gbm grf \
    h3jsr \
    landscapemetrics lutz \
    mccf1 mgcv \
    precrec pryr prioritizr \
    ranger readr \
    scam sessioninfo smoothr suncalc \
    units uuid \
  && installGithub.r \
    cornelllabofornithology/auk \
    cornelllabofornithology/ebirdst@dev_erd2021 \
    walkerke/mapboxapi \
    bgreenwell/fastshap \
    crazycapivara/h3-r

WORKDIR /home/docker/

CMD ["/start.sh"]
