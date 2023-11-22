FROM node:21.2.0
WORKDIR /var/www/app
# https://forums.docker.com/t/files-havent-been-copied-to-volume-folder-during-docker-run/114478
COPY ./package.json ./package.json
RUN npm install --global gulp-cli
RUN npm install
ENTRYPOINT ["tail", "-f", "/dev/null"]