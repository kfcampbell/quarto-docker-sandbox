# rocker seems like they make better images than r-base
FROM rocker/r-ver:4.3.0

ENV DEBIAN_FRONTEND=noninteractive

# install a bunch of dependencies for quarto and R
RUN apt-get update && apt-get install -y \
    wget \
    pandoc \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    build-essential \
    zlib1g-dev \
    libglpk-dev \
    libgmp3-dev \
    && rm -rf /var/lib/apt/lists/*

# quarto 1.5.57 picked because it was the latest stable at the time of making this
RUN wget -O /tmp/quarto.deb https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.57/quarto-1.5.57-linux-amd64.deb && \
    dpkg -i /tmp/quarto.deb && \
    rm /tmp/quarto.deb

# install a bunch of packages that might be necessary for homework
# if you need more or less, make edits to this line and rerun ./run.sh
# then wait for R and docker to rebuild...it'll take a while
RUN R -e "install.packages(c('rmarkdown', 'tidyverse', 'assertthat', 'effsize', 'jsonlite', 'GGally', 'dplyr', 'DescTools'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

WORKDIR /app
EXPOSE 3838
CMD ["bash"]
