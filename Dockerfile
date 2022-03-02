FROM python:3.11.0a5-alpine3.15

MAINTAINER Daniel Yanes

# Update and installing dependencies packages
RUN apk update \
    && apk add --no-cache py3-distutils-extra build-base ncurses-dev
    


USER root

# path for build
WORKDIR /root/build

COPY . .

# begin to build
RUN cd vim-8 \
    && chmod 776 configure src/configure src/auto/configure \
    && cd src \
    && ./configure --with-python3-config-dir=/usr/lib/python3.9/config-3.9-x86_64-linux-musl \
      --enable-python3interp \
    && make \
    && make install


# lauching a shell
CMD ["/bin/sh"]