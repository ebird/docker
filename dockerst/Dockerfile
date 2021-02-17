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
    imagemagick \
    rsync

# R packages needed
RUN install.r \
    DBI DescTools MASS PresenceAbsence RSQLite \
    argparse auk \
    car \
    digest \
    exactextractr \
    fields \
    gbm grf \
    mgcv \
    pryr prioritizr \
    ranger readr \
    scam smoothr \
    units uuid \
  && installGithub.r \
    cornelllabofornithology/auk \
    cornelllabofornithology/ebirdst@dev_erd2019

WORKDIR /home/docker/

CMD ["/start.sh"]
