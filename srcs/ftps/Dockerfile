FROM alpine:latest

RUN apk update \
&& apk add vsftpd shadow openssl 

ADD srcs srcs

ENV FTP_USER="ftpuser" \
FTP_PSSWORD="password" 

RUN cp srcs/vsftpd.conf /etc/vsftpd \
&& cp srcs/toni-serv.42.pem /etc/ssl \
&& cp srcs/toni-serv.42.np.key /etc/ssl

EXPOSE 20 21 42420-42422

ENTRYPOINT chmod +x srcs/start.sh \
&& srcs/start.sh
