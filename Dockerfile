FROM debian:buster-slim

ENV TZ=Europe/Saratov \
    LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU.UTF-8 \
    LC_ALL=ru_RU.UTF-8 \
    PORT_RPC=2975 \
    PORT_WEB=2976 \
    PORT_INC=3000
#    PORTS_OUT=3001-3100

ADD ./config/* /config/
COPY ./startup.sh /

RUN apt update && apt install -y apt-utils htop mc deluged deluge-web deluge-webui \
&& chmod +x /startup.sh \
&& mkdir -p /logs /torrent

VOLUME /config

#EXPOSE $PORT_RPC/tcp $PORT_WEB/tcp $PORT_INC $PORTS_OUT
EXPOSE $PORT_RPC/tcp $PORT_WEB/tcp $PORT_INC

ENTRYPOINT ["/startup.sh","startup"]
