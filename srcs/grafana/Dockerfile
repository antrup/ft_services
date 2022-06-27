FROM alpine:latest

RUN apk update \
&& apk add libc6-compat

ENV GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
GF_PATHS_DATA="/var/lib/grafana" \
GF_PATHS_HOME="/usr/share/grafana" \
GF_PATHS_LOGS="/var/log/grafana" \
GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
GF_PATHS_PROVISIONING="/etc/grafana/provisioning" \
PATH="/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
INF_SERVER="localhost" \
INF_DB_ORG="42" \
INF_DB_BASE="monitoring" \
INF_TOKEN="toekn"

ADD srcs srcs

RUN wget https://dl.grafana.com/oss/release/grafana-7.4.3.linux-amd64.tar.gz \
&&  mkdir "$GF_PATHS_HOME" \
&& tar xzf grafana-7.4.3.linux-amd64.tar.gz --strip-components 1 -C "$GF_PATHS_HOME" \
&& rm -rf grafana-7.4.3.linux-amd64.tar.gz \
&& mkdir -p "$GF_PATHS_PROVISIONING/datasources" \
            "$GF_PATHS_PROVISIONING/dashboards" \
            "$GF_PATHS_PROVISIONING/notifiers" \
            "$GF_PATHS_PROVISIONING/plugins" \
            "$GF_PATHS_LOGS" \
            "$GF_PATHS_PLUGINS" \
            "$GF_PATHS_DATA" \
&& chmod -R 777 "$GF_PATHS_HOME" "$GF_PATHS_DATA" "$GF_PATHS_LOGS" "$GF_PATHS_PLUGINS" "$GF_PATHS_PROVISIONING" \ 
&& cp "$GF_PATHS_HOME/conf/sample.ini" "$GF_PATHS_CONFIG" \
&& cp srcs/datasources.yaml "$GF_PATHS_PROVISIONING/datasources" \
&& cp srcs/dashboards.yaml "$GF_PATHS_PROVISIONING/dashboards" \
&& cp -r srcs/dashboards "$GF_PATHS_DATA"

EXPOSE 3000

ENTRYPOINT chmod +x srcs/start.sh \
&& srcs/start.sh
