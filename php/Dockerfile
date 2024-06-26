FROM ubuntu:24.04

SHELL ["/bin/bash", "-i", "-c"]

RUN apt-get -y update && \
    apt-get install -y \
    curl git

ARG SITE_EDITOR_GID=830
ARG DOCKER_USER_UID_GID=1100
ARG DOCKER_WEB_USER=101
ARG PHP_VERSION=8.3.8
ARG NVM_VERSION=v0.39.7
ARG NODEJS_VERSION=v22.3.0
ARG PROJECT_ROOT
ARG PUBLIC_ROOT

RUN groupadd -g ${SITE_EDITOR_GID} site_editor && \
	useradd -Um -u ${DOCKER_USER_UID_GID} -G site_editor docker_user && \
	useradd -MrU -u ${DOCKER_WEB_USER} -G site_editor -d /nonexistent -s /usr/sbin/nologin nginx

USER docker_user

RUN echo -e "\n\
umask 002\n\
\n" | tee -a ~/.bashrc ~/.profile ~/.zshrc

# установка php version manager и php последней версии
RUN curl -L https://raw.githubusercontent.com/phpenv/phpenv-installer/master/bin/phpenv-installer \
    | bash

RUN echo -e "\n\
export PHPENV_ROOT=\"/home/docker_user/.phpenv\"\n\
if [ -d \"\${PHPENV_ROOT}\" ]; then\n\
export PATH=\"\${PHPENV_ROOT}/bin:\${PATH}\"\n\
eval \"\$(phpenv init -)\"\n\
fi\n\
\n" | tee -a ~/.bashrc ~/.profile ~/.zshrc

USER root

RUN /home/docker_user/.phpenv/plugins/php-build/install-dependencies.sh

USER docker_user

RUN phpenv install ${PHP_VERSION} && \
    phpenv global ${PHP_VERSION}

ENV PROJECT_ROOT ${PROJECT_ROOT}

WORKDIR ${PROJECT_ROOT}

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"

USER root

RUN mv composer.phar /usr/local/bin/composer

USER docker_user

# https://github.com/nvm-sh/nvm
RUN export PROFILE=/dev/null && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash

RUN echo -e "\n\
export NVM_DIR=\"/home/docker_user/.nvm\"\n\
[ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\"  # This loads nvm\n\
[ -s \"\$NVM_DIR/bash_completion\" ] && \. \"\$NVM_DIR/bash_completion\"  # This loads nvm bash_completion\n\
\n" | tee -a ~/.bashrc ~/.profile ~/.zshrc

RUN nvm install ${NODEJS_VERSION} && \
	npm install -g yarn

COPY ${PHP_VERSION} /home/docker_user/.phpenv/versions/${PHP_VERSION}/etc/