FROM ubuntu:16.04

MAINTAINER berlius <berlius52@yahoo.com>

RUN apt-get update && apt-get install imagemagick -y  \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libxxf86vm1 \
    libxxf86vm-dev \
    libxi-dev \
    libxrandr-dev \
    graphviz

RUN git clone --recursive https://github.com/openMVG/openMVG
RUN mkdir openMVG_Build && cd openMVG_Build

RUN cmake -DCMAKE_BUILD_TYPE=RELEASE -DOpenMVG_BUILD_TESTS=ON -DOpenMVG_BUILD_EXAMPLES=ON . ../openMVG/src/

RUN cmake -G "CodeBlocks - Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE . ../openMVG/src/

RUN make && make test

WORKDIR "/root"
CMD ["/bin/bash"]
