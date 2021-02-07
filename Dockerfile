FROM ubuntu:20.04

MAINTAINER <christoph.hahn@uni-graz.at>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
	echo "tzdata tzdata/Zones/Europe select Vienna" >> /tmp/preseed.txt; \
	debconf-set-selections /tmp/preseed.txt && \
	apt-get update && \
	apt-get install -y build-essential git tzdata \
		python3 libhdf5-dev libgtk-3-dev python3-networkx autoconf

WORKDIR /usr/src

RUN git clone --recursive https://github.com/schloi/MARVEL.git && \
	cd MARVEL && \
	git reset --hard e3f3cae82cec91ee0040889c6b5d283e50254b51 && \
	autoreconf && \
	./configure --prefix $(pwd)/bin && \
	make && make install

ENV PYTHONPATH="${PYTHONPATH}:/usr/src/MARVEL/bin/lib.python"
ENV PATH="${PATH}:/usr/src/MARVEL/bin/scripts:/usr/src/MARVEL/bin/bin"

##add user (not really necessary)
RUN adduser --disabled-password --gecos '' marveluser
USER marveluser

WORKDIR /usr/home

CMD ["DBprepare.py"]
