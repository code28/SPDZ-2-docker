FROM ubuntu

RUN apt-get update \
    && apt-get install -y --no-install-recommends g++ make yasm m4 python bzip2 libsodium-dev \
    && apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

WORKDIR /mpir
ADD http://mpir.org/mpir-3.0.0.tar.bz2 /mpir/

RUN tar xf mpir-3.0.0.tar.bz2 && rm -f mpir-3-0.0.tar.bz2 \
    && cd mpir-3.0.0 && ./configure --enable-cxx && make -j && make install \
    && cd .. && rm -rf mpir-3.0.0

WORKDIR /SPDZ-2
ADD SPDZ-2 /SPDZ-2
ARG insecure=false

RUN if "$insecure" != "false"; then echo "MY_CFLAGS= -DINSECURE" > CONFIG.mine; fi
RUN make

ENV LD_LIBRARY_PATH /usr/local/lib
CMD []
