# docker-soapysdr
![][badge_build] ![][badge_docker_pull]

Use a SoapySDRServer ([Soapy SDR](https://github.com/pothosware/SoapyRemote/wiki) remote support) within a Docker container.

## Usage
Start the server in the background:
```sh
$ docker run -d -rm \
             --name soapysdr \
             -e SOAPY_REMOTE_IP_ADDRESS=[::] \
             -e SOAPY_REMOTE_PORT=55132 \
             -p 55132:55132/tcp \
             --device=/dev/bus/usb/001/004 \
             --device=/dev/bus/usb/001/005 \
             --device=/dev/bus/usb/001/006 \
             --device=/dev/bus/usb/001/007 \
             soapysdr
```

[badge_build]: https://github.com/hbaier/docker-soapysdr/workflows/docker-multiarch/badge.svg
[badge_docker_pull]: https://img.shields.io/docker/pulls/hbaier/soapysdr