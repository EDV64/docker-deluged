FROM debian:buster-slim

ENV TZ=Europe/Saratov \
    DEBIAN_FRONTEND=noninteractive \
    PORT_RPC=2975 \
    PORT_WEB=2976 \
    PORT_INC=3000

ADD ./config/* /config/
COPY ./startup.sh /

RUN apt-get update \
&& apt-get install -y apt-utils locales deluged deluge-web deluge-webui \
&& sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
&& locale-gen \
&& chmod +x /startup.sh \
&& mkdir -p /logs /torrent

ENV LC_ALL=ru_RU.UTF-8 \
    LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU.UTF-8

VOLUME /config

EXPOSE $PORT_RPC/tcp $PORT_WEB/tcp $PORT_INC

ENTRYPOINT ["/startup.sh","startup"]
