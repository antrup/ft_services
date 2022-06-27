#!/bin/sh
curl grafana:3000 > /dev/null 2>&1; echo "{\"grafana connect error\": $?}"
