FROM sumanmukherjee03/ubuntu:16.04
LABEL nginx_version="1.10" \
  io.k8s.display-name="Nginx Base Image" \
  io.k8s.description="This is the Nginx base image that is used for building reverse proxies"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

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
