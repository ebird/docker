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
    scam sessioninfo smoothr \
    units uuid \
  && installGithub.r \
    cornelllabofornithology/auk \
    ebird/ebirdst \
    walkerke/mapboxapi \
    bgreenwell/fastshap \
    crazycapivara/h3-r \
    ebird/fastmedian \
    # temporary bug fix, change back to CRAN install if package maintainers
    # accept my PR https://github.com/datastorm-open/suncalc/issues/2
    mstrimas/suncalc

# install jags
RUN apt-get update -y && apt-get install -y jags \
  && install.r rjags
  
WORKDIR /home/docker/

CMD ["/start.sh"]
