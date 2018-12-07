FROM ubuntu:16.04

MAINTAINER Greg Holthaus "<gerg@gerg.me>"

RUN \
	apt-get -qq update && \
	apt-get -qq -y upgrade && \
	apt-get -qq -y install ices2 python-setuptools joe supervisor lltag normalize-audio

RUN mkdir -p /var/log/ices
RUN mkdir -p /etc/ices2
ADD etc/ices/ /etc/ices2
ADD data/ /data
RUN /etc/ices2/update_songs.sh
RUN /etc/ices2/process_songs.sh

# Add supervisord conf, bootstrap.sh files
COPY container-files /
COPY supervisord-ices.conf /etc/supervisor.d/supervisord-ices.conf

# Expose ports for radio station
EXPOSE 8001
ENTRYPOINT ["/config/bootstrap.sh"]
