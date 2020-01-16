# docker-soapysdr
[![GitHub Workflow Status][badge_build_image]][badge_build_link] [![Docker Pulls][badge_docker_pull_image]][badge_docker_pull_link]

Use a SoapySDRServer (as a part of [SoapyRemote](https://github.com/pothosware/SoapyRemote/wiki)) within a Docker container.

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
Print SoapySDR module information:
```sh
$ docker run -it --rm --entrypoint /usr/bin/SoapySDRUtil hbaier/soapysdr --info
```

[badge_build_image]: https://img.shields.io/github/workflow/status/hbaier/docker-soapysdr/docker-multiarch
[badge_build_link]: https://github.com/hbaier/docker-soapysdr/blob/master/.github/workflows/main.yml
[badge_docker_pull_image]: https://img.shields.io/docker/pulls/hbaier/soapysdr
[badge_docker_pull_link]: https://hub.docker.com/r/hbaier/soapysdr
