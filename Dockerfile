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
    && ./configure --prefix=/usr --with-python3-config-dir=/usr/lib/python3.9/config-3.9-x86_64-linux-musl \
      --enable-python3interp \
    && make \
    && make install


# Configurations and cleaning
RUN python3 config.py && \
    cd /root/ && \ 
    rm -rf vim-8 config install-packages.py config.py


# Lauching a shell
CMD ["/bin/sh"]