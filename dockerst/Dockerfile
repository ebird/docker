# docker image for ebird status and trends
FROM mstrimas/geospatial

LABEL maintainer="Matt Strimas-Mackey <mes335@cornell.edu>"

# system tools needed
RUN apt-get update -y \
  && apt-get install -y \
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
#   We attempt to install as many as possible via apt-get for consistency.
#   See: https://packaging.python.org/en/latest/specifications/externally-managed-environments/
RUN apt-get update -y \
  && apt-get install -y \
    python3-click \
    python3-matplotlib \
    python3-pandas \
    python3-scipy \
    python3-sklearn \
    python3-tqdm \
    python3-yaml

RUN apt-get update -y \
  && apt-get install -y \
    nvidia-cuda-toolkit

# For ones not available via apt-get, we install via pip (ex: pytorch)
#   See: https://stackoverflow.com/a/76469774/68736
ENV PIP_BREAK_SYSTEM_PACKAGES 1
RUN python3 -m pip install \
    pyarrow \
    torch

# R packages needed
RUN install.r \
    DBI DescTools MASS PresenceAbsence RSQLite \
    argparse \
    car \
    digest \
    exactextractr \
    fields \
    gbm googlesheets4 grf \
    h3jsr \
    landscapemetrics lutz \
    mccf1 mgcv \
    oce \
    precrec pryr prioritizr \
    readr \
    scam sessioninfo smoothr \
    units uuid \
    yardstick

# mapboxapi dependencies protolite and magick need to be compiled to avoid shared library errors
RUN r -e 'install.packages(c("protolite", "magick"), repos = "https://cloud.r-project.org", type = "source")' \
  && installGithub.r \
      cornelllabofornithology/auk \
      ebird/ebirdst \
      walkerke/mapboxapi \
      bgreenwell/fastshap \
      crazycapivara/h3-r \
      # temporary bug fix, change back to CRAN once new version is on CRAN
      datastorm-open/suncalc \
      # ranger has a bug in the C++ sampling code that this branch fixes
      # if this PR is merged, switch back to using the official repo
      # bug report: https://github.com/imbs-hl/ranger/issues/733
      # PR: https://github.com/imbs-hl/ranger/pull/734
      # imbs-hl/ranger \
      sligocki/ranger@sample_skip_bug

# Install AWS CLI v2
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  && unzip awscli-exe-linux-x86_64.zip \
  && ./aws/install \
  && rm -rf aws awscli-exe-linux-x86_64.zip

# install duckdb, versions on cli, r, and python must match
ENV DUCKDB_VERSION 0.10.2
# must manually install libssl1.0.0
RUN wget https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip \
  && unzip duckdb_cli-linux-amd64.zip -d /usr/bin/ \
  && rm duckdb_cli-linux-amd64.zip \
  && duckdb :memory: "INSTALL sqlite;" \
  && r -e 'remotes::install_version("duckdb", version = "'${DUCKDB_VERSION}'", repos = "https://cloud.r-project.org")' \
  && python3 -m pip install duckdb==${DUCKDB_VERSION}

# install jags
RUN apt-get update -y && apt-get install -y jags \
  && install.r rjags
  
WORKDIR /home/docker/

CMD ["/start.sh"]
