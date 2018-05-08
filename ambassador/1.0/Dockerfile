FROM svendowideit/ambassador
LABEL ambassador_version="1.0" \
  author_name="Suman Mukherjee" \
  author_email="sumanmukherjee03@gmail.com" \
  io.k8s.display-name="Ambassador Pattern Base Image" \
  io.k8s.description="This is the Ambassador Pattern base image that is used for building sidecars"

ARG NON_ROOT_UID=1001
ARG NON_ROOT_GID=1001
ARG NON_ROOT_USER=default

COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD []

STOPSIGNAL SIGTERM
