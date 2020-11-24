FROM ubuntu:focal
LABEL maintainer="Harald Baier <hbaier@users.noreply.github.com>"

ENV SOAPY_REMOTE_IP_ADDRESS=[::] \
    SOAPY_REMOTE_PORT=55132

RUN apt-get update \
 && apt-get install -y \
    avahi-daemon \
    dbus \
    gosu \
    soapyremote-server \
    soapysdr-module-airspy \
    soapysdr-module-audio \
    soapysdr-module-bladerf \
    soapysdr-module-hackrf \
    soapysdr-module-lms7 \
    soapysdr-module-mirisdr \
    soapysdr-module-osmosdr \
    soapysdr-module-redpitaya \
    soapysdr-module-remote \
    soapysdr-module-rtlsdr \
    soapysdr-module-uhd \
    soapysdr-tools \
    supervisor \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /var/run/dbus \
 && groupadd -r soapysdr \
 && useradd --no-log-init -r -g soapysdr -s /usr/sbin/nologin soapysdr

COPY ./soapysdr-helper.sh /usr/local/bin
COPY ./supervisord.conf /etc/supervisor
RUN chmod 744 /usr/local/bin/soapysdr-helper.sh

ENTRYPOINT ["/usr/bin/supervisord", "-c"]
CMD ["/etc/supervisor/supervisord.conf"]
