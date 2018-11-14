FROM alpine:3.8

MAINTAINER AlloVince <allo.vince@gmail.com>

RUN mkdir /config && mkdir /downloads && mkdir /cache && touch /config/aria2.session
ADD aria2.conf /config/aria2.conf

RUN apk update && \
	apk --no-cache upgrade && \
	apk add --no-cache aria2=1.34.0-r0

VOLUME ["/downloads", "/config", "/cache"]

ENV TOKEN aria2-admin

#For RPC
EXPOSE 6800
#For DHT
EXPOSE 6881
#For Torrent Download
EXPOSE 6999

CMD touch /config/aria2.session && aria2c --conf-path=/config/aria2.conf \
           --rpc-secret=${TOKEN}
