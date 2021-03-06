FROM debian:9.2

LABEL maintainer "opsxcq@strm.sh"

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git wget curl \
    build-essential make autoconf \
    ## Packages and libs for polybar
    cmake cmake-data \
    libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev \ 
    libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev  \
    libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev \
    libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    i3-wm

WORKDIR /libs
COPY libc /libs
