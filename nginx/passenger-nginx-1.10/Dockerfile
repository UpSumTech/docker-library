FROM sumanmukherjee03/ubuntu:16.04
LABEL nginx_version="passenger-nginx-1.10" \
  io.k8s.display-name="Nginx Base Image with passenger enabled" \
  io.k8s.description="This is the Nginx base image that is used for building reverse proxies with passenger module enabled"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID

RUN set -ex; \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7; \
  echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main' > /etc/apt/sources.list.d/passenger.list; \
  apt-get install -y --no-install-recommends \
    nginx-extras \
    passenger; \
  rm -rf /etc/nginx; \
  mkdir -p /etc/nginx/vhosts; \
  mkdir -p /var/lib/nginx; \
  chown -R www-data:www-data /var/lib/nginx; \
  mkdir -p /var/log/nginx; \
  chown -R www-data:www-data /var/log/nginx

COPY configuration/nginx.conf /etc/nginx/

EXPOSE 80

RUN set -ex; \
  ls /etc/nginx; \
  nginx -t -c /etc/nginx/nginx.conf

CMD ["nginx"]
