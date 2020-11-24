#!/bin/sh

set -e

if avahi-daemon -c; then
  exec gosu soapysdr /usr/bin/SoapySDRServer --bind="${SOAPY_REMOTE_IP_ADDRESS}:${SOAPY_REMOTE_PORT}"
else
  exit 1
fi
