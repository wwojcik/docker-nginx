FROM gliderlabs/alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

RUN apk --update add nginx \
    openssl \
    tar \
    && wget -O /tmp/dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/v0.0.2/dockerize-linux-amd64-v0.0.2.tar.gz \
    && tar -C /usr/local/bin -xvzf /tmp/dockerize.tar.gz \
    && rm -rf /tmp/dockerize.tar.gz /var/www/html /var/cache/apk/* \
    && mkdir -p /etc/nginx/sites-available/ /etc/nginx/sites-enabled/ \
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && chown -R nginx:www-data /var/lib/nginx

COPY ./config/nginx.conf /etc/nginx/
COPY ./config/default.tmpl /etc/nginx/sites-enabled/default

EXPOSE 80 443

VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/app"]

CMD ["/usr/sbin/nginx"]