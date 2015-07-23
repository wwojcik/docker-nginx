FROM gliderlabs/alpine:latest
MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>
RUN apk --update add nginx openssl tar \
    && wget -O /tmp/dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.0.2/dockerize-linux-amd64-v0.0.2.tar.gz \
    && tar -C /usr/local/bin -xvzf /tmp/dockerize.tar.gz \
    && rm /tmp/dockerize.tar.gz \
    && mkdir -p /etc/nginx/sites-available/ /etc/nginx/sites-enabled/ \
    && echo "daemon off;" >> /etc/nginx/nginx.conf

COPY ./config/nginx.conf /etc/nginx/
COPY ./config/default.tmpl /var/www/config/
EXPOSE 80 443
VOLUME /var/www
ENTRYPOINT ["/usr/sbin/nginx"]