FROM python:3.11.0a5-alpine3.15

MAINTAINER Daniel Yanes

USER root

# Path for build
WORKDIR /root

COPY . .


# Update and installing dependencies packages
RUN apk update \
    && pip install --upgrade pip \
    && python3 install-packages.py


# Begin to build
RUN cd vim-8 \
    && chmod 776 configure src/configure src/auto/configure \
    && cd src \
    && ./configure --with-python3-config-dir=/usr/lib/python3.9/config-3.9-x86_64-linux-musl \
      --enable-python3interp \
    && make \
    && make install

# Configurations and cleaning
RUN cd config && \ 
    mv .vimrc /root && \
    cd /root/ && \ 
    rm -rf build && \
    cd

# Lauching a shell
CMD ["/bin/sh"]