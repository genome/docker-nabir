###################################
# Docker for Running NAIBR at MGI #
###################################

# Based on...
FROM python:2.7.14

# File Author / Maintainer
MAINTAINER Eddie Belter <ebelter@wustl.edu>

# Image & Deps
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	libnss-sss \
	vim && \
	apt-get clean

# Install NAIBR
WORKDIR /tmp/
RUN git clone https://github.com/raphael-group/NAIBR.git
WORKDIR /tmp/NAIBR/
RUN echo "#!/usr/bin/env python\n" > /usr/local/bin/NAIBR && \
	cat NAIBR.py >> /usr/local/bin/NAIBR && \
	chmod 755 /usr/local/bin/NAIBR
RUN cp -r src/ /usr/local/lib/python2.7/site-packages/NAIBR
WORKDIR /
RUN rm -rf /tmp/NAIBR/

# Deps
RUN pip install \
	future \
	matplotlib \
	mpmath \
	numpy \
	pysam \
	scipy

# Environment
ENV PYTHONPATH=/usr/local/lib/python2.7/site-packages/NAIBR
