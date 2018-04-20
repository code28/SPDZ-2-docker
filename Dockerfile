# Copyright (c) 2018 Simon Kempendorf

FROM alpine

# Add tools necessary for SPDZ-2 compiling
RUN apk add --no-cache g++ make python libsodium-dev

# Install MPIR
WORKDIR /mpir
ADD http://mpir.org/mpir-3.0.0.tar.bz2 /mpir/
RUN apk add --no-cache -t mpir-build yasm m4 bzip2 \
    && tar xf mpir-3.0.0.tar.bz2 && cd mpir-3.0.0 \
    && ./configure --enable-cxx && make -j && make install \
    && cd .. && rm -rf mpir-3.0.0 && rm -f mpir-3-0.0.tar.bz2 \
    && apk del mpir-build

# Start SPDZ-2 handling
WORKDIR /SPDZ-2
ADD SPDZ-2 /SPDZ-2

# Allow build argument "insecure" to build with insecure flag
ARG insecure=false
RUN if test "$insecure" != "false"; then echo "MY_CFLAGS= -DINSECURE" >> CONFIG.mine; fi

ARG MAX_MOD_SZ=2
RUN if test "$MAX_MOD_SZ" != "2"; then echo -n "MOD = -DMAX_MOD_SZ=" >> CONFIG.mine; echo $MAX_MOD_SZ >> CONFIG.mine; fi

# Compile SPDZ-2
RUN make

# Prepare environment to run SPDZ-2 with MPIR
ENV LD_LIBRARY_PATH /usr/local/lib
CMD /bin/sh
