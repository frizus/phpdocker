FROM ubuntu:24.04

RUN apt-get -y update && \
    apt-get install -y \
    curl git

ARG SITE_EDITOR_GID=830
ARG DOCKER_USER_UID_GID=1100
ARG DOCKER_WEB_USER=101
ARG PHP_VERISON=
ARG NVM_VERSION=v0.39.7
ARG NODEJS_VERSION=v22.2.0

RUN groupadd -g $SITE_EDITOR_GID site_editor && \
	useradd -Um -u $DOCKER_USER_UID_GID -G site_editor docker_user && \
	useradd -MrU -u $DOCKER_WEB_USER -G site_editor -d /nonexistent -s /usr/sbin/nologin docker_web_user

USER docker_user

RUN echo "\n\
umask 002\n\
\n" | tee -a ~/.bashrc ~/.profile ~/.zshrc

# установка php version manager и php последней версии
RUN curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer \
    | bash

RUN echo "\n\
export PHPENV_ROOT=\"/home/docker_user/.phpenv\"\n\
if [ -d \"\${PHPENV_ROOT}\" ]; then\n\
export PATH=\"\${PHPENV_ROOT}/bin:\${PATH}\"\n\
eval \"\$(phpenv init -)\"\n\
fi\n\
\n" | tee -a ~/.bashrc ~/.profile ~/.zshrc

# https://github.com/nvm-sh/nvm
#RUN export PROFILE=/dev/null && \
#	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash
#
#RUN echo "\n\
#export NVM_DIR=\"/home/docker_user/.nvm\"\n\
#[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"  # This loads nvm\n\
#[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion\n\
#\n" | tee -a ~/.bashrc ~/.profile ~/.zshrc
#
#SHELL ["/bin/bash", "-i", "-c"]
#
#RUN nvm install $NODEJS_VERSION# && \
#	#npm install -g yarn

# установить composer
#RUN gem install bundler

ENV PROJECT_ROOT /home/docker_user/app

WORKDIR ${PROJECT_ROOT}