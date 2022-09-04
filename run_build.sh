#!/bin/bash

ZMK_VERSION="3.0"
docker run --rm -it \
       -v ${PWD}:/zmk \
       --user ${UID} \
       --workdir /zmk \
       zmkfirmware/zmk-build-arm:${ZMK_VERSION} \
       bash build.sh
