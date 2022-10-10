# docker image for ebird status and trends
FROM mstrimas/dockerst

MAINTAINER "Matt Strimas-Mackey" mes335@cornell.edu
LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# system tools needed
RUN apt-get update -y \
  && apt-get install -y python3.9

WORKDIR /home/docker/

CMD ["/start.sh"]
