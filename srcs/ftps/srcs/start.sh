#!/bin/sh

if [ ! -d /home/$FTP_USER ]; then
useradd --create-home $FTP_USER \
&& echo -e "$FTP_PSSWORD\n$FTP_PSSWORD" | passwd $FTP_USER \
&& chmod 755 /home \
&& chmod 755 /home/$FTP_USER
fi
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
