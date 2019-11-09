# build stage
# ========================
FROM alpine:latest as build

COPY ucspi-tcp-0.88.tar.gz ucspi-tcp-0.88.errno.patch /tmp/
WORKDIR /tmp

RUN apk --update add gcc musl-dev make && rm -rf /var/cache/apk/*

RUN tar xvzf ucspi-tcp-0.88.tar.gz && \
    cd ucspi-tcp-0.88 && \
    patch -Np1 -i ../ucspi-tcp-0.88.errno.patch && \
    sed 's|/usr/local|/usr|' conf-home > conf-home~ && \
    mv -f conf-home~ conf-home && \
    make && \
    make setup check
	
# ===========================
FROM alpine:latest as run

COPY entrypoint.sh /tmp/
	
COPY --from=build /usr/bin/tcpserver /usr/bin/
COPY --from=build /lib/ld-musl-armhf.so.1 /lib/

ENTRYPOINT ["/tmp/entrypoint.sh"]
