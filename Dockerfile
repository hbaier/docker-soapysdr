FROM alpine:3.10 AS builder
LABEL maintainer="Harald Baier <hbaier@users.noreply.github.com>"

# build SoapySDR
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    doxygen \
    g++ \
    git \
    make \
    python-dev \
    python3-dev \
    swig \
 && git clone https://github.com/pothosware/SoapySDR.git --depth 1 --branch soapy-sdr-0.7.1 \
 && cd SoapySDR \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libSoapySDR.so* \
    /usr/local/bin/SoapySDRUtil \
    /tmp/artifacts/

# build SoapyRemote
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyRemote.git --depth 1 --branch soapy-remote-0.5.1 \
 && cd SoapyRemote \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libremoteSupport.so \
    /usr/local/bin/SoapySDRServer \
    /tmp/artifacts/

# build SoapyMultiSDR
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyMultiSDR.git --depth 1 --branch master \
 && cd SoapyMultiSDR \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libMultiSDRSupport.so \
    /tmp/artifacts/

# build libairspy
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone https://github.com/airspy/airspyone_host.git --depth 1 --branch v1.0.9 \
 && cd airspyone_host \
 && mkdir build \
 && cd build \
 && cmake .. -DINSTALL_UDEV_RULES=ON \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libairspy.so* \
    /tmp/artifacts/

# build SoapyAirspy
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyAirspy.git --depth 1 --branch soapy-airspy-0.1.2 \
 && cd SoapyAirspy \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libairspySupport.so \
    /tmp/artifacts/

# build libairspyhf
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone https://github.com/airspy/airspyhf.git --depth 1 --branch 1.1.5 \
 && cd airspyhf \
 && mkdir build \
 && cd build \
 && cmake .. -DINSTALL_UDEV_RULES=ON \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libairspyhf.so* \
    /tmp/artifacts/

# build SoapyAirspyHF
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyAirspyHF.git --depth 1 --branch soapy-airspyhf-0.1.0 \
 && cd SoapyAirspyHF \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libairspyhfSupport.so \
    /tmp/artifacts/

# build librtaudio
WORKDIR /opt
RUN apk --no-cache add \
    alsa-lib-dev \
    cmake \
    g++ \
    git \
    jack-dev \
    make \
    pulseaudio-dev \
 && git clone https://github.com/thestk/rtaudio.git --depth 1 --branch 5.1.0 \
 && cd rtaudio \
 && mkdir build \
 && cd build \
 && cmake .. -DCMAKE_INSTALL_LIBDIR=lib \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/librtaudio.so* \
    /tmp/artifacts/

# build SoapyAudio
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyAudio.git --depth 1 --branch soapy-audio-0.1.1 \
 && cd SoapyAudio \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libaudioSupport.so \
    /tmp/artifacts/

# build libbladeRF
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone https://github.com/Nuand/bladeRF.git --depth 1 --branch 2019.07 \
 && cd bladeRF \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libbladeRF.so* \
    /tmp/artifacts/

# build SoapyBladeRF
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyBladeRF.git --depth 1 --branch soapy-bladerf-0.4.1 \
 && cd SoapyBladeRF \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libbladeRFSupport.so \
    /tmp/artifacts/

# build SoapyFCDPP
WORKDIR /opt
RUN apk --no-cache add \
    alsa-lib-dev \
    cmake \
    g++ \
    git \
    make \
 && apk --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community add \
    hidapi-dev \
 && git clone https://github.com/pothosware/SoapyFCDPP.git --depth 1 --branch soapy-fcdpp-0.1.1 \
 && cd SoapyFCDPP \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libFCDPPSupport.so \
    /tmp/artifacts/

# build libhackrf
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    fftw-dev \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone https://github.com/mossmann/hackrf.git --depth 1 --branch v2018.01.1 \
 && cd hackrf/host \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libhackrf.so* \
    /tmp/artifacts/

# build SoapyHackRF
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyHackRF.git --depth 1 --branch soapy-hackrf-0.3.3 \
 && cd SoapyHackRF \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libHackRFSupport.so \
    /tmp/artifacts/

# build Lime Suite support
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone https://github.com/myriadrf/LimeSuite.git --depth 1 --branch v19.04.0 \
 && cd LimeSuite \
 && mkdir builddir \
 && cd builddir \
 && cmake .. -DENABLE_API_DOXYGEN=OFF \
             -DENABLE_EVB7COM=OFF \
             -DENABLE_EXAMPLES=OFF \
             -DENABLE_FTDI=OFF \
             -DENABLE_FX3=OFF \
             -DENABLE_HEADERS=OFF \
             -DENABLE_LIBRARY=ON \
             -DENABLE_LIME_UTIL=OFF \
             -DENABLE_PCIE_XILLYBUS=OFF \
             -DENABLE_QUICKTEST=OFF \
             -DENABLE_REMOTE=OFF \
             -DENABLE_SOAPY_LMS7=ON \
             -DENABLE_SPI=OFF \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libLimeSuite.so* \
    /usr/local/lib/SoapySDR/modules*/libLMS7Support.so \
    /tmp/artifacts/

# build SoapyNetSDR
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyNetSDR.git --depth 1 --branch master \
 && cd SoapyNetSDR \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libnetSDRSupport.so \
    /tmp/artifacts/

# build libiio
WORKDIR /opt
RUN apk --no-cache add \
    bison \
    cmake \
    doxygen \
    flex-dev \
    g++ \
    git \
    graphviz \
    libusb-dev \
    libxml2-dev \
    make \
    python3-dev \
    zlib-dev \
 && git clone https://github.com/analogdevicesinc/libiio.git --depth 1 --branch v0.18 \
 && cd libiio \
 && mkdir build \
 && cd build \
 && cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
             -DCMAKE_INSTALL_LIBDIR=lib \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libiio.so* \
    /tmp/artifacts/

# build libad9361-iio
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    doxygen \
    g++ \
    git \
    make \
 && git clone https://github.com/analogdevicesinc/libad9361-iio.git --depth 1 --branch v0.2 \
 && cd libad9361-iio \
 && mkdir build \
 && cd build \
 && cmake .. -DCMAKE_INSTALL_LIBDIR=lib \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libad9361.so* \
    /tmp/artifacts/

# build SoapyPlutoSDR
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyPlutoSDR.git --depth 1 --branch soapy-plutosdr-0.2.0 \
 && cd SoapyPlutoSDR \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libPlutoSDRSupport.so \
    /tmp/artifacts/

# build SoapyRedPitaya
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyRedPitaya.git --depth 1 --branch soapy-redpitaya-0.1.1 \
 && cd SoapyRedPitaya \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libRedPitaya.so \
    /tmp/artifacts/

# build librtlsdr
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone git://git.osmocom.org/rtl-sdr.git --depth 1 --branch 0.6.0 \
 && cd rtl-sdr \
 && mkdir build \
 && cd build \
 && cmake .. -DINSTALL_UDEV_RULES=ON \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/librtlsdr.so* \
    /tmp/artifacts/

# build SoapyRTLSDR
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyRTLSDR.git --depth 1 --branch soapy-rtlsdr-0.3.0 \
 && cd SoapyRTLSDR \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/librtlsdrSupport.so \
    /tmp/artifacts/

# build libuhd
WORKDIR /opt
RUN apk --no-cache add \
    boost-dev \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
    py-mako \
 && git clone https://github.com/EttusResearch/uhd.git --depth 1 --branch v3.14.1.1 \
 && cd uhd/host \
 && mkdir build \
 && cd build \
 && cmake .. -DENABLE_B100=OFF \
             -DENABLE_B200=OFF \
             -DENABLE_C_API=OFF \
             -DENABLE_DOXYGEN=OFF \
             -DENABLE_DPDK=OFF \
             -DENABLE_E300=OFF \
             -DENABLE_E320=OFF \
             -DENABLE_EXAMPLES=OFF \
             -DENABLE_GPSD=OFF \
             -DENABLE_LIBERIO=OFF \
             -DENABLE_LIBUHD=ON \
             -DENABLE_MAN_PAGES=OFF \
             -DENABLE_MANUAL=OFF \
             -DENABLE_MPMD=OFF \
             -DENABLE_N230=OFF \
             -DENABLE_N300=OFF \
             -DENABLE_N320=OFF \
             -DENABLE_OCTOCLOCK=OFF \
             -DENABLE_PYTHON_API=OFF \
             -DENABLE_TESTS=OFF \
             -DENABLE_USB=ON \
             -DENABLE_USRP1=OFF \
             -DENABLE_USRP2=OFF \
             -DENABLE_UTILS=OFF \
             -DENABLE_X300=OFF \
             -DNEON_SIMD_ENABLE=OFF \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libuhd.so* \
    /tmp/artifacts/

# build SoapyUHD
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyUHD --depth 1 --branch soapy-uhd-0.3.6 \
 && cd SoapyUHD \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/SoapySDR/modules*/libuhdSupport.so \
    /usr/local/lib/uhd/modules/libsoapySupport.so \
    /tmp/artifacts/

# build libfreesrp
WORKDIR /opt
RUN apk --no-cache add \
    boost-dev \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone https://github.com/myriadrf/libfreesrp.git --depth 1 --branch 0.3.0 \
 && cd libfreesrp \
 && mkdir build \
 && cd build \
 && cmake .. -DCMAKE_BUILD_TYPE=Release \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libfreesrp.so* \
    /tmp/artifacts/

# build libmirisdr
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone https://github.com/osmocom/libmirisdr.git --depth 1 --branch master \
 && cd libmirisdr \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libmirisdr.so* \
    /tmp/artifacts/

# build libosmosdr
WORKDIR /opt
RUN apk --no-cache add \
    cmake \
    g++ \
    git \
    libusb-dev \
    make \
 && git clone https://github.com/osmocom/osmo-sdr.git --depth 1 --branch v0.1 \
 && cd osmo-sdr/software/libosmosdr \
 && mkdir build \
 && cd build \
 && cmake .. \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libosmosdr.so* \
    /tmp/artifacts/

# build SoapyOsmo
WORKDIR /opt
RUN apk --no-cache add \
    boost-dev \
    cmake \
    g++ \
    git \
    make \
 && git clone https://github.com/pothosware/SoapyOsmo.git --depth 1 --branch soapy-osmo-0.2.5 \
 && cd SoapyOsmo \
 && mkdir build \
 && cd build \
 && cmake .. -DENABLE_DEFAULT=OFF \
             -DENABLE_FREESRP=ON \
             -DENABLE_MIRI=ON \
             -DENABLE_OSMOSDR=ON \
 && make -j$(nproc) \
 && make install \
 && mkdir -p /tmp/artifacts \
 && cp -P -p --parents \
    /usr/local/lib/libSoapyOsmoSDR.so* \
    /usr/local/lib/SoapySDR/modules*/libosmosdrSupport.so \
    /usr/local/lib/SoapySDR/modules*/libmiriSupport.so \
    /usr/local/lib/SoapySDR/modules*/libfreesrpSupport.so \
    /tmp/artifacts/

# strip artifacts
RUN apk --no-cache add \
    binutils \
 && find /tmp/artifacts -type f -executable -exec strip -sp '{}' + || true

# create artifacts tarball preserving symlinks
RUN apk --no-cache add \
    tar \
 && tar -cvzpf /tmp/artifacts.tar.gz -C /tmp/artifacts .

FROM alpine:3.10
LABEL maintainer="Harald Baier <hbaier@users.noreply.github.com>"

ENV SOAPY_REMOTE_IP_ADDRESS=[::] \
    SOAPY_REMOTE_PORT=55132

COPY --from=builder /tmp/artifacts.tar.gz /tmp/

RUN apk --no-cache add \
    boost-chrono \
    boost-date_time \
    boost-filesystem \
    boost-regex \
    boost-serialization \
    boost-thread \
    jack \
    libpulse \
    libstdc++ \
    libusb \
    libxml2 \
    tar \
 && apk --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community add \
    hidapi \
 && tar --same-owner -xvzf /tmp/artifacts.tar.gz -C / \
 && rm -f /tmp/artifacts.tar.gz \
 && apk --no-cache del \
    tar \
 && addgroup -g 1000 -S soapysdr \
 && adduser -u 1000 -S -H soapysdr -G soapysdr

STOPSIGNAL SIGINT

USER soapysdr
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/usr/local/bin/SoapySDRServer --bind=${SOAPY_REMOTE_IP_ADDRESS}:${SOAPY_REMOTE_PORT}"]
