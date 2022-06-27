FROM alpine:latest

RUN apk update \
&& apk add libc6-compat lftp curl

ENV TELEGRAF_VERSION="1.18.0" \
TG_DB_PASSWORD="password" \
mysql_server="localhost" \
INF_SERVER="localhost" \
INF_DB_ORG="42" \
INF_DB_BASE="monitoring" \
INF_TOKEN="token"

ADD srcs srcs

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz \
&& mkdir -p /usr/src /etc/telegraf \
&& tar -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz -C /usr/src \
&& mkdir /etc/telegraf/telegraf.d  \
&& cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin \
&& cp /srcs/ftps_test.sh /etc/telegraf \
&& chmod +x /etc/telegraf/ftps_test.sh \
&& cp /srcs/script_ftps /etc/telegraf \
&& cp /srcs/grafana_test.sh /etc/telegraf \
&& chmod +x /etc/telegraf/grafana_test.sh \
&& mv srcs/telegraf.conf /etc/telegraf/

EXPOSE 8125/udp 8092/udp 8094

ENTRYPOINT ["telegraf"]
