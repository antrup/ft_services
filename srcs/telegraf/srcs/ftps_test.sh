#!/bin/sh
lftp -f /etc/telegraf/script_ftps > /dev/null 2>&1; echo "{\"ftps connect error\": $?}"
