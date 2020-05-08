FROM ubuntu:focal
LABEL maintainer="Harald Baier <hbaier@users.noreply.github.com>"

ARG MYRIADRF_PPA_CODENAME=bionic
ARG MYRIADRF_PPA_KEY=11FC2E68126782B43762694F22C627172ECB91FE

ENV SOAPY_REMOTE_IP_ADDRESS=[::] \
    SOAPY_REMOTE_PORT=55132

RUN apt-get update \
 && apt-get install -y \
    gnupg \
 && echo "deb http://ppa.launchpad.net/myriadrf/drivers/ubuntu ${MYRIADRF_PPA_CODENAME} main" > /etc/apt/sources.list.d/myriadrf.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${MYRIADRF_PPA_KEY} \
 && printf '%s\n' 'Package: *' 'Pin: release o=LP-PPA-myriadrf-drivers' 'Pin-Priority: 100' > /etc/apt/preferences.d/myriadrf.pref \
 && apt-get update \
 && apt-get install -y \
    avahi-daemon \
    dbus \
    gosu \
    soapyremote-server \
    soapysdr-module-airspy \
    soapysdr-module-airspyhf \
    soapysdr-module-audio \
    soapysdr-module-bladerf \
    soapysdr-module-fcdpp \
    soapysdr-module-hackrf \
    soapysdr-module-iris \
    soapysdr-module-lms7 \
    soapysdr-module-mirisdr \
    soapysdr-module-osmosdr \
    soapysdr-module-plutosdr \
    soapysdr-module-redpitaya \
    soapysdr-module-remote \
    soapysdr-module-rfspace \
    soapysdr-module-rtlsdr \
    soapysdr-module-uhd \
    soapysdr-tools \
    supervisor \
 && apt-get purge --autoremove -y gnupg \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /var/run/dbus \
 && groupadd -r soapysdr \
 && useradd --no-log-init -r -g soapysdr -s /usr/sbin/nologin soapysdr \
 && printf '%s\n' \
    '#!/bin/sh' \
    '' \
    'set -e' \
    '' \
    'if avahi-daemon -c; then' \
    '  exec gosu soapysdr /usr/bin/SoapySDRServer --bind="${SOAPY_REMOTE_IP_ADDRESS}:${SOAPY_REMOTE_PORT}"' \
    'else' \
    '  exit 1' \
    'fi' > /usr/local/bin/soapysdr-helper.sh \
 && chmod 744 /usr/local/bin/soapysdr-helper.sh \
 && printf '%s\n' \
    '[supervisord]' \
    'user=root' \
    'nodaemon=true' \
    '' \
    '[program:dbus]' \
    'command=/usr/bin/dbus-daemon --system --nopidfile --nofork' \
    'priority=100' \
    'autorestart=true' \
    'stdout_logfile=/proc/1/fd/1' \
    'stdout_logfile_maxbytes=0' \
    'stderr_logfile=/proc/1/fd/2' \
    'stderr_logfile_maxbytes=0' \
    '' \
    '[program:avahi]' \
    'command=/usr/sbin/avahi-daemon --no-chroot' \
    'priority=200' \
    'autorestart=true' \
    'stdout_logfile=/proc/1/fd/1' \
    'stdout_logfile_maxbytes=0' \
    'stderr_logfile=/proc/1/fd/2' \
    'stderr_logfile_maxbytes=0' \
    '' \
    '[program:soapysdr]' \
    'command=/usr/local/bin/soapysdr-helper.sh' \
    'priority=300' \
    'stopsignal=INT' \
    'autorestart=true' \
    'stdout_logfile=/proc/1/fd/1' \
    'stdout_logfile_maxbytes=0' \
    'stderr_logfile=/proc/1/fd/2' \
    'stderr_logfile_maxbytes=0' > /etc/supervisor/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-c"]
CMD ["/etc/supervisor/supervisord.conf"]
