ARG NGINX_VERSION=1.27.0

FROM nginx:${NGINX_VERSION}-perl

SHELL ["/bin/bash", "-i", "-c"]

COPY nginx.conf /etc/nginx/nginx.conf

ARG SITE_EDITOR_GID=830
ARG DOCKER_USER_UID_GID=1100
ARG DOCKER_WEB_USER=101

RUN groupadd -g $SITE_EDITOR_GID site_editor && \
	useradd -Um -u $DOCKER_USER_UID_GID -G site_editor docker_user && \
	usermod -a -G site_editor `id -un $DOCKER_WEB_USER`

USER docker_user