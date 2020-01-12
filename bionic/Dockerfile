FROM ubuntu:bionic
LABEL maintainer="Harald Baier <hbaier@users.noreply.github.com>"

ENV SOAPY_REMOTE_IP_ADDRESS=[::] \
    SOAPY_REMOTE_PORT=55132

RUN apt-get update \
 && apt-get install -y \
    software-properties-common \
 && add-apt-repository -y ppa:bladerf/bladerf \
 && printf '%s\n' 'Package: *' 'Pin: release o=LP-PPA-bladerf-bladerf' 'Pin-Priority: 1001' > /etc/apt/preferences.d/bladerf.pref \
 && add-apt-repository -y ppa:myriadrf/drivers \
 && printf '%s\n' 'Package: *' 'Pin: release o=LP-PPA-myriadrf-drivers' 'Pin-Priority: 1001' > /etc/apt/preferences.d/myriadrf.pref \
 && apt-get update \
 && apt-get install -y \
    avahi-daemon \
    dbus \
    gosu \
    soapysdr-module-airspy \
    soapysdr-module-airspyhf \
    soapysdr-module-audio \
    soapysdr-module-bladerf \
    soapysdr-module-fcdpp \
    soapysdr-module-hackrf \
    soapysdr-module-iris \
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
 && apt-get install -y --download-only \
    soapysdr-server \
 && dpkg --unpack /var/cache/apt/archives/soapysdr-server*.deb \
 && rm -f /var/lib/dpkg/info/soapysdr-server.postinst \
 && apt --fix-broken install \
 && apt-get purge --autoremove -y software-properties-common \
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
