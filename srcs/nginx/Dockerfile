FROM alpine:latest

RUN apk update \
&& apk add nginx

ADD srcs srcs

RUN adduser -D -g www www \
&& mkdir /www \
&& chown -R www:www /var/lib/nginx \
&& chown -R www:www /www \
&& cp srcs/index.html /www

RUN mkdir /etc/nginx/ssl \
&& cp srcs/toni-serv.42.pem /etc/nginx/ssl \
&& cp srcs/toni-serv.42.np.key /etc/nginx/ssl

RUN cp srcs/nginx.conf /etc/nginx 

EXPOSE 80
EXPOSE 443
EXPOSE 9090

ENTRYPOINT ["nginx"]
