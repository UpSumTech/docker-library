FROM upsumtech/ubuntu:20.04
LABEL nginx_version="1.18.0" \
  io.k8s.display-name="Nginx Base Image" \
  io.k8s.description="This is the Nginx base image that is used for building reverse proxies"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default
ENV EXPECTED_NON_ROOT_UID=$NON_ROOT_UID
ENV EXPECTED_NON_ROOT_GID=$NON_ROOT_GID
ENV NGINX_VERSION=1.18.0

RUN set -ex; \
  export GNUPGHOME="$(mktemp -d)"; \
  gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62"; \
  gpg --batch --export "573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62" > /etc/apt/trusted.gpg.d/nginx.gpg; \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7; \
  gpgconf --kill all; \
  rm -rf $GNUPGHOME; \
  apt-key update; \
  echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main" >> /etc/apt/sources.list.d/passenger.list; \
  echo "deb https://nginx.org/packages/debian/ buster nginx" >> /etc/apt/sources.list.d/nginx.list; \
  echo "deb http://il.archive.ubuntu.com/ubuntu bionic main" >> /etc/apt/sources.list.d/bionic-main.list; \
  echo "deb http://il.archive.ubuntu.com/ubuntu bionic universe" >> /etc/apt/sources.list.d/bionic-universe.list; \
  apt-get -qq update

RUN set -ex; \
  apt-get install --no-install-recommends -y libnginx-mod-http-passenger; \
  apt-get install --no-install-recommends -y \
    nginx \
    nginx-module-xslt \
    nginx-module-geoip \
    nginx-module-image-filter \
    libreadline7 \
    gettext-base \
    nginx-module-njs \
    passenger

RUN set -ex; \
  rm -rf /etc/nginx; \
  mkdir -p /etc/nginx/vhosts; \
  mkdir -p /etc/nginx/modules-enabled; \
  rm -rf /usr/src/app; \
  mkdir -p /usr/src/app; \
  chown -R www-data:www-data /usr/src/app; \
  mkdir -p /var/lib/nginx; \
  chown -R www-data:www-data /var/lib/nginx; \
  mkdir -p /var/log/nginx; \
  chown -R www-data:www-data /var/log/nginx; \
  ln -sf /dev/stdout /var/log/nginx/access.log; \
  ln -sf /dev/stderr /var/log/nginx/error.log

COPY configuration /etc/nginx/

EXPOSE 80

RUN set -ex; \
  ls /etc/nginx; \
  nginx -t -c /etc/nginx/nginx.conf; \
  passenger-config validate-install

CMD ["nginx"]
