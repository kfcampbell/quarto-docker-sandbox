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
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)"

# quarto 1.5.57 picked because it was the latest stable at the time of making this
ENV QUARTO_VERSION=1.5.57
RUN ARCH=$(dpkg --print-architecture) && \
    echo "Detected architecture: $ARCH" && \
    wget -O /tmp/quarto.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${ARCH}.deb" && \
    dpkg -i /tmp/quarto.deb && \
    rm /tmp/quarto.deb

# install a bunch of packages that might be necessary for homework
# if you need more or less, make edits to these lines and rerun ./run.sh
# then wait for R and docker to rebuild...it'll take a super long time (~25 min)
RUN R -e "install.packages('rmarkdown', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('tidyverse', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('assertthat', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('effsize', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('jsonlite', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('microbenchmark', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('GGally', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('dplyr', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('DescTools', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('sparklyr', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('Rcpp', repos='https://cran.rstudio.com/', dependencies=TRUE)"

RUN R -e "library(sparklyr); \
          spark_install(version='3.5.3', hadoop_version='3')"

WORKDIR /app
EXPOSE 3838
CMD ["bash"]
