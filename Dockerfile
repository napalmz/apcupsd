FROM ubuntu:latest
LABEL maintainer="NapalmZ (https://github.com/napalmz)"

ENV LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Rome
# Default 120s
ENV HEALT_LIMIT=120

COPY scripts /usr/local/bin

RUN echo Starting. \
# && cp /etc/apt/sources.list /etc/apt/sources.list.default \
# && mv /usr/local/bin/sources.list.localrepo /etc/apt/sources.list \
 && apt-get -q -y update \
 && apt-get -q -y install --no-install-recommends apcupsd dbus libapparmor1 libdbus-1-3 libexpat1 tzdata \
 && apt-get -q -y full-upgrade \
 && rm -rif /var/lib/apt/lists/* \
 && mv /usr/local/bin/apcupsd      /etc/default/apcupsd \
 && mv /usr/local/bin/apcupsd.conf /etc/apcupsd/apcupsd.conf \
 && mv /usr/local/bin/hosts.conf   /etc/apcupsd/hosts.conf \
 && mv /usr/local/bin/doshutdown   /etc/apcupsd/doshutdown \
###  Revert to default repositories  ###
# && mv /etc/apt/sources.list.default /etc/apt/sources.list \
 && echo Finished.

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD ["sh", "-c", "healthcheck.sh $HEALT_LIMIT"]

CMD ["/sbin/apcupsd", "-b"]
