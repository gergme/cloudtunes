FROM ubuntu:16.04

MAINTAINER Greg Holthaus "gerg@gerg.me"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq -y update && \
    apt-get -y install wget && \
    wget -qO - http://icecast.org/multimedia-obs.key | apt-key add -
    
RUN echo "deb http://download.opensuse.org/repositories/multimedia:/xiph/xUbuntu_16.04/ ./" > /etc/apt/sources.list.d/icecast.list

RUN apt-get -qq -y update && \
    apt-get -qq -y install icecast2 python-setuptools joe supervisor sudo && \
    apt-get clean

VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]

ADD ./etc /etc
ADD ./usr /usr
RUN chown -R icecast2 /etc/icecast2

# Add supervisord conf, bootstrap.sh files
COPY container-files /
COPY supervisord-icecast2.conf /etc/supervisor.d/supervisord-icecast2.conf

# Expose ports for radio hub
EXPOSE 8000
ENTRYPOINT ["/config/bootstrap.sh"]
