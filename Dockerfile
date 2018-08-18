#
# Dockerfile for shadowsocks-libev
#

FROM alpine
LABEL maintainer="kev <noreply@datageek.info>, Sah <contact@leesah.name>, Jiang Zeming <jiangzeming@ccpc.org.cn>"

COPY ./ss.json /etc/ss.json

RUN set -ex \
    # Build environment setup
    && apk add --no-cache --virtual .build-deps \
    autoconf \
    automake \
    build-base \
    c-ares-dev \
    libev-dev \
    libtool \
    libsodium-dev \
    linux-headers \
    openssl \
    asciidoc \
    xmlto \
    libpcre32 \
    mbedtls-dev \
    pcre-dev \
    git \
    # Clone the source
    && cd /tmp \
    && git clone --recursive  --depth=1 https://github.com/shadowsocks/shadowsocks-libev.git \
    && git clone  --recursive  --depth=1 https://github.com/shadowsocks/simple-obfs.git \
    # Build & install Shadowsocks
    && cd /tmp/shadowsocks-libev \
    && ./autogen.sh \
    && ./configure --prefix=/usr --disable-documentation \
    && make install \
    #Build & install Simple-Obfs
    && cd /tmp/simple-obfs \
    && ./autogen.sh \
    && ./configure --prefix=/usr --disable-documentation \
    && make install \
    && apk del .build-deps \
    # Runtime dependencies setup
    && apk add --no-cache \
    rng-tools \
    $(scanelf --needed --nobanner /usr/bin/ss-* \
    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
    | sort -u) \
    && rm -rf /tmp/shadowsocks-libev \
    && rm -rf /tmp/simple-obfs

USER nobody

CMD exec ss-server -c /etc/ss.json
