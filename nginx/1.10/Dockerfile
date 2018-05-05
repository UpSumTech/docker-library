FROM sumanmukherjee03/ubuntu:16.04
LABEL nginx_version="1.10"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

RUN set -ex; \
  apt-get install -y --no-install-recommends nginx; \
  rm -rf /etc/nginx \
    && mkdir -p /etc/nginx/vhosts; \
  rm -rf /usr/src/app \
    && mkdir -p /usr/src/app \
    && chown -R www-data:www-data /usr/src/app; \
  ln -sf /dev/stdout /var/log/nginx/access.log; \
  ln -sf /dev/stderr /var/log/nginx/error.log

COPY configuration /etc/nginx/

EXPOSE 80

RUN set -ex; \
  ls /etc/nginx; \
  nginx -t -c /etc/nginx/nginx.conf

CMD ["nginx"]
