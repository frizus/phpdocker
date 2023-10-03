FROM mysql:8.1.0

ARG DB_PATH=/var/lib/mysql
ARG APP_USER
ARG APP_GROUP
ARG APP_GROUP_GID
ARG APP_USER_UID

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN groupadd -g $APP_GROUP_GID $APP_GROUP && \
    useradd -u $APP_USER_UID -ms /bin/bash -g $APP_GROUP $APP_USER && \
    chown $APP_USER:$APP_GROUP $DB_PATH

USER $APP_USER

CMD ["mysqld"]

EXPOSE 3306