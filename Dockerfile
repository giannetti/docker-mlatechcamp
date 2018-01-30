# =============================================================================
# RSTUDIO DOCKER IMAGE
# =============================================================================
#
# To build:
#
# $ docker build -t giannetti/mlatechcamp:mostrecent .
# 
# To force a rebuild:
#
# $ docker build --no-cache -t giannetti/mlatechcamp:mostrecent .
#
# To run:
#
# $ docker run --rm -p 80:8787 giannetti/mlatechcamp:mostrecent
#
# -----------------------------------------------------------------------------
#

FROM rocker/tidyverse
MAINTAINER Francesca Giannetti <fg162@rutgers.edu>
RUN apt-get update && apt-get install -y \
	libudunits2-0 \
	libudunits2-dev \
	libgdal-dev \
	libproj-dev \
	whois && \
	apt-get clean -y
RUN R -e 'install.packages(c("rgdal", "ggraph", "RColorBrewer", "igraph", "historydata", "leaflet", "rgeos", "sp", "knitr", "lubridate"))'
#
# Add script to generate new user accounts.
#
ADD https://raw.githubusercontent.com/DataWookie/docker-exegetic/master/users-create-accounts.sh /usr/sbin
ADD https://github.com/DataWookie/docker-exegetic/blob/master/users-generate-details.sh /usr/sbin
ADD https://gist.githubusercontent.com/giannetti/c7ecc3aece3eb0cd843c6c3765454fdc/raw/e44814161e6071f55645172e96f85756c147c4b6/users.csv /usr/sbin
RUN chmod 700 /usr/sbin/users-generate-details.sh
RUN chmod 700 /usr/sbin/users-create-accounts.sh
