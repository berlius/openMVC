FROM ubuntu:14.04

# dockerfile from https://github.com/baritone/openMVG/blob/master/Dockerfile

# Add openMVG binaries to path
ENV PATH $PATH:/opt/openMVG_Build/install/bin

# Get dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  graphviz \
  git \
  gcc-4.8 \ 
  gcc-4.8-multilib \  
  libpng-dev \
  libjpeg-dev \
  libtiff-dev \
  libxxf86vm1 \
  libxxf86vm-dev \
  libxi-dev \
  libxrandr-dev \
  python-dev \  
  python-pip

# Clone the openvMVG repo 
RUN git clone https://github.com/baritone/openMVG /opt/openMVG
RUN cd /opt/openMVG && git submodule update --init --recursive

# Build
RUN mkdir /opt/openMVG_Build && cd /opt/openMVG_Build && cmake -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX="/opt/openMVG_Build/install" -DOpenMVG_BUILD_TESTS=ON \
  -DOpenMVG_BUILD_EXAMPLES=ON . ../openMVG/src/ && make

RUN cd /opt/openMVG_Build && make test

ENV PATH=/opt/openMVG_Build/Linux-x86_64-RELEASE:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR "/root"
CMD ["/bin/bash"]
