# docker image for ebird status and trends
FROM mstrimas/geospatial

MAINTAINER "Matt Strimas-Mackey" mes335@cornell.edu
LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

FROM mstrimas/geospatial

# system tools needed
RUN apt-get update -y \
  && apt-get install -y \
    awscli \
    expect \
    ffmpeg \
    imagemagick

# R packages needed
RUN install2.r --error \
    DBI RSQLite   \
    ranger grf scam gbm mgcv MASS PresenceAbsence DescTools \
    argparse auk \
    car \
    digest \
    fields \
    gbm \
    pryr \
    smoothr \
    units uuid \
  && installGithub.r cornelllabofornithology/ebirdst cornelllabofornithology/auk

WORKDIR /home/docker/

CMD ["/start.sh"]