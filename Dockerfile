FROM debian:buster-slim

ENV TZ=Europe/Saratov \
    DEBIAN_FRONTEND=noninteractive

ARG B_DAEMON_PORT \
    B_WEB_PORT \
    B_LISTEN_PORT \
    B_RPC_LOGIN \
    B_RPC_PASSWORD

ADD ./config/* /config/
COPY ./startup.sh /

RUN apt-get update \
&& apt-get install -y apt-utils locales deluged deluge-web deluge-webui \
&& sed -i -e 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/' /etc/locale.gen \
&& locale-gen \
&& sed -i -e "s/^.*\"daemon_port\".*$/  \"daemon_port\": $B_DAEMON_PORT, /" /config/core.conf \
&& sed -i -e "/.*listen_ports.*/{N;N;N;s/.*/  \"listen_ports\": \[\n    $B_LISTEN_PORT, \n    $B_LISTEN_PORT\n  \],/}" /config/core.conf \
&& sed -i -e "s/^.*\"port\".*/  \"port\": $B_WEB_PORT, /" /config/web.conf \
&& echo $B_RPC_LOGIN:$B_RPC_PASSWORD:10 > /config/auth \
&& chmod +x /startup.sh \
&& mkdir -p /logs /torrent

ENV LC_ALL=ru_RU.UTF-8 \
    LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU.UTF-8

#VOLUME /config

#EXPOSE $PORT_RPC/tcp $PORT_WEB/tcp $PORT_INC

#ENTRYPOINT ["/startup.sh","startup"]
