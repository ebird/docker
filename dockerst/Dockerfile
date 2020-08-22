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
    imagemagick

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
    pryr \
    ranger readr
    scam smoothr \
    units uuid \
  && installGithub.r cornelllabofornithology/ebirdst cornelllabofornithology/auk tomauer/fastRfuncs

WORKDIR /home/docker/

CMD ["/start.sh"]
