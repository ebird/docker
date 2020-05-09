# ubuntu tidyverse image
FROM ubuntu:18.04

MAINTAINER "Matt Strimas-Mackey" mes335@cornell.edu
LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# install latest r version
# from https://hub.docker.com/r/rocker/r-ubuntu/dockerfile

## set a default user, available via runtime flag `--user docker`
## add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## user should also have & own a home directory (for rstudio or linked volumes to work properly).
RUN useradd docker \
  && mkdir /home/docker \
  && chown docker:docker /home/docker \
  && addgroup docker staff

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    software-properties-common \
    ed \
    less \
    locales \
    vim-tiny \
    ca-certificates \
  && add-apt-repository --enable-source --yes "ppa:edd/r-4.0"

## configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV R_BASE_VERSION 4.0.0

## this was not needed before but we need it now
ENV DEBIAN_FRONTEND noninteractive

## install R and littler, and create a link for littler in /usr/local/bin
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    littler \
                r-cran-littler \
    r-base=${R_BASE_VERSION}-* \
    r-base-dev=${R_BASE_VERSION}-* \
    r-recommended=${R_BASE_VERSION}-* \
  && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
  && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
  && ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
  && ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
  && install.r docopt \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
  && rm -rf /var/lib/apt/lists/*


# install tidyverse, from https://hub.docker.com/r/rocker/tidyverse/dockerfile
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite-dev \
  libmariadbd-dev \
  libmariadbclient-dev \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  libsasl2-dev \
  ### mstrimas: needed to add these to get httr working
  libcurl4-openssl-dev \
  libssl-dev \
  ###
  && install2.r --error \
    --deps TRUE \
    tidyverse \
    data.table \
    dplyr \
    foreach doParallel \
    remotes \
    selectr \
    tictoc \
    BiocManager

CMD ["bash"]