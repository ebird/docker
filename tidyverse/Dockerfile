FROM rstudio/r-base:4.4-noble

LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# set a default user, available via runtime flag `--user docker`
# add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
# user should also have & own a home directory (for rstudio or linked volumes to work properly).
RUN useradd docker \
  && mkdir /home/docker \
  && chown docker:docker /home/docker \
  && usermod -G staff docker
  
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git \
    software-properties-common \
    ed \
    less \
    locales \
    nano \
    vim-tiny \
    ca-certificates

# configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen en_US.utf8 \
  && /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# use rstudio package manager
RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))' > /usr/lib/R/etc/Rprofile.site \
  && echo 'REPOS=https://packagemanager.rstudio.com/all/__linux__/focal/latest' >> /usr/lib/R/etc/Renviron \
  && echo 'LIBLOC=/usr/lib/R/library/' >> /usr/lib/R/etc/Renviron \
  && echo 'alias R="R --no-save --no-restore-data --no-restore"' >> /etc/bash.bashrc

# install littler
RUN R --slave -e 'install.packages(c("littler", "docopt"), repos = "https://cloud.r-project.org", type = "source")' \ 
  && ln -s /usr/lib/R/library/littler/bin/r /usr/local/bin/r \
  && ln -s /usr/lib/R/library/littler/examples/install.r /usr/local/bin/install.r \
  && ln -s /usr/lib/R/library/littler/examples/install2.r /usr/local/bin/install2.r \
  && ln -s /usr/lib/R/library/littler/examples/installGithub.r /usr/local/bin/installGithub.r
  
# install tidyverse, from https://hub.docker.com/r/rocker/tidyverse/dockerfile
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  libxml2-dev \
  libcairo2-dev \
  libsqlite3-dev \
  libmariadbd-dev \
  libmariadb-dev-compat \
  libpq-dev \
  libssh2-1-dev \
  unixodbc-dev \
  libsasl2-dev \
  libcurl4-openssl-dev \
  libssl-dev

RUN install.r \
  tidyverse \
  data.table \
  geofacet \
  jsonlite \
  keyring \
  plyr \
  here \
  foreach doParallel \
  remotes pak \
  RSQLite PostgreSQL \
  tictoc bench \
  RColorBrewer viridis pals scico hexbin patchwork

# install arrow, needs to be compiled from source
RUN r -e 'Sys.setenv(LIBARROW_BINARY = TRUE); install.packages("arrow", repos = "https://cran.rstudio.com/", type = "source")'

# install development version of stringi to avoid libicui version mismatch
RUN installGithub.r gagolews/stringi

COPY start.sh /start.sh
WORKDIR /home/docker/

CMD ["/start.sh"]
