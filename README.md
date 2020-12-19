Chromium browser Docker image
=============================

[![Build Status](https://travis-ci.org/monstrenyatko/docker-chromium.svg?branch=master)](https://travis-ci.org/monstrenyatko/docker-chromium)


About
=====

[Chromium](https://www.chromium.org) browser in the `Docker` container.

Upstream Links
--------------
* Docker Registry @[monstrenyatko/chromium](https://hub.docker.com/r/monstrenyatko/chromium/)
* GitHub @[monstrenyatko/docker-chromium](https://github.com/monstrenyatko/docker-chromium)
* Based on GitHub @[theasp/docker-novnc](https://github.com/theasp/docker-novnc)

Image Contents
--------------

* [Xvfb](http://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml): virtual framebuffer X server for X Version 11
* [x11vnc](http://www.karlrunge.com/x11vnc/): [VNC](https://en.wikipedia.org/wiki/Virtual_Network_Computing) server
* [noNVC](https://novnc.com): HTML `VNC` client
* [Fluxbox](http://www.fluxbox.org): small window manager
* [supervisord](http://supervisord.org): process control system


Quick Start
===========

* Configure environment:

  - `DOCKER_REGISTRY`: [**OPTIONAL**] registry prefix to pull image from a custom `Docker` registry:

    ```sh
      export DOCKER_REGISTRY="my_registry_hostname:5000/"
    ```
* Pull prebuilt `Docker` image:

  ```sh
    docker-compose pull
  ```
* Start prebuilt image:

  ```sh
    docker-compose up -d
  ```
* Verify:

  Open `http://localhost:8080` in web browser.

* Stop/Restart:

  ```sh
    docker-compose stop
    docker-compose start
  ```


Configuration
=============

Container can be configured using environment variables:

* `APP_UID`: [**OPTIONAL**] `UID` to be used to run user-faced processes instead of `default`
* `APP_GID`: [**OPTIONAL**] `GID` to be used to run user-faced process instead of `default`
* `SYS_UID`: [**OPTIONAL**] `UID` to be used to run system processes instead of `default`
* `SYS_GID`: [**OPTIONAL**] `GID` to be used to run system processes instead of `default`
* `DISPLAY_WIDTH`: [**OPTIONAL**] the virtual display width in pixels
* `DISPLAY_HEIGHT`: [**OPTIONAL**] the virtual display height in pixels
* `WEBSOCKIFY_PARAMS`: [**OPTIONAL**] the extra command-line parameters to be passed to the `websockify`
* `CHROMIUM_PARAMS`: [**OPTIONAL**] the extra command-line parameters to be passed to the `Chromium`
* `LOG_LEVEL`: [**OPTIONAL**] the `supervisord` logging level. Set to `debug` to see services output
* `NET_GW`: [**OPTIONAL**] the network default GW to be used instead of one assigned by `Docker`.
  This option requires `--cap-add=NET_ADMIN`


Build own image
===============

* `default` target platform:

  ```sh
    cd <path to sources>
    DOCKER_BUILDKIT=1 docker build --tag <tag name> .
  ```
* `arm64` target platform:

  ```sh
    cd <path to sources>
    DOCKER_BUILDKIT=1 docker build --platform=linux/arm64 --tag <tag name> .
  ```
