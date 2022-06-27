FROM alpine:latest

ENV INFLUXD_BOLT_PATH=/var/lib/influxdb2/influxd.bolt \
INFLUXD_ENGINE_PATH=/var/lib/influxdb2/engine \
INFLUX_CONFIGS_PATH=/etc/influxdb2/configs \
INF_DB_ORG="42" \
INF_DB_PASSWORD="password" \
INF_DB_USER="infadmin" \
INF_DB_RETENTION="1w" \
INF_DB_BASE="monitoring"

ADD srcs srcs

RUN wget --no-verbose https://dl.influxdata.com/influxdb/releases/influxdb2-2.0.4-linux-amd64.tar.gz \
&& tar xzf influxdb2-2.0.4-linux-amd64.tar.gz \
&& mv influxdb2-2.0.4-linux-amd64/influx* /usr/local/bin/ \
&& chmod +x srcs/init.sh 

EXPOSE 8086

VOLUME ["/var/lib/influxdb2/", "/etc/influxdb2"]

ENTRYPOINT ["srcs/init.sh"]
