#!/bin/sh

if [ ! -d /var/lib/influxdb2/engine ]; then
	echo "Influxdb configuration in progress ..."
	nohup influxd >/dev/null 2>&1 &
	sleep 10
	influx setup -f -o "$INF_DB_ORG" -p "$INF_DB_PASSWORD" -u "$INF_DB_USER" -r "$INF_DB_RETENTION" -b "$INF_DB_BASE"
	influx auth create -o "$INF_DB_ORG" --write-buckets --read-buckets | awk '{print $2}' | grep -v Description > /etc/influxdb2/token
	kill $!
	sleep 10
	echo "Influxdb configuration done"
fi

influxd
