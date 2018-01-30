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
ADD https://gist.githubusercontent.com/stephlocke/0036331e7a3338e965149833e92c1360/raw/607fb01602e143671c83216a4c5f1ad2deb10bf6/mkusers.sh /
ADD https://gist.githubusercontent.com/giannetti/c7ecc3aece3eb0cd843c6c3765454fdc/raw/e44814161e6071f55645172e96f85756c147c4b6/users.csv /
RUN chmod 700 /mkusers.sh
RUN /mkusers.sh