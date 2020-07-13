# docker image for ebird status and trends
FROM rocker/geospatial

MAINTAINER "Matt Strimas-Mackey" mes335@cornell.edu
LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

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

CMD ["/bin/bash"]