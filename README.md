# docker-soapysdr
![][badge_build] ![][badge_docker_pull]

Use a SoapySDRServer ([Soapy SDR](https://github.com/pothosware/SoapyRemote/wiki) remote support) within a Docker container.

## Usage
Start the server in the background:
```sh
$ docker run -d --rm \
             --name soapysdr \
             -e SOAPY_REMOTE_IP_ADDRESS=[::] \
             -e SOAPY_REMOTE_PORT=55132 \
             --net=host \
             --device=/dev/bus/usb/001/004 \
             --device=/dev/bus/usb/001/005 \
             --device=/dev/bus/usb/001/006 \
             --device=/dev/bus/usb/001/007 \
             hbaier/soapysdr
```
Print Soapy SDR module information:
```sh
$ docker run -it --rm --entrypoint /usr/bin/SoapySDRUtil hbaier/soapysdr --info
```

[badge_build]: https://github.com/hbaier/docker-soapysdr/workflows/docker-multiarch/badge.svg
[badge_docker_pull]: https://img.shields.io/docker/pulls/hbaier/soapysdr
