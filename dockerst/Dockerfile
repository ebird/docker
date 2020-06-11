# docker image for ebird status and trends
FROM mstrimas/tidyverse

MAINTAINER "Matt Strimas-Mackey" mes335@cornell.edu
LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

FROM mstrimas/geospatial

USER root

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
    ranger scam gbm mgcv MASS PresenceAbsence DescTools \
    argparse auk \
    car \
    digest \
    fields \
    gbm \
    pryr \
    smoothr \
    units uuid \
  # edarf was removed from cran, use archived versions.
  && r -e 'remotes::install_version("edarf", version = "1.1.1", repos = "http://cran.us.r-project.org")' \ 
  && installGithub.r cornelllabofornithology/ebirdst cornelllabofornithology/auk

WORKDIR /home/docker/
USER docker

CMD ["bash"]