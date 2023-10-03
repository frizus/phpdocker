FROM nginx:1.25

ARG APP_USER
ARG APP_GROUP
ARG APP_GROUP_GID
ARG APP_USER_UID
COPY conf/nginx.conf /etc/nginx/

#RUN groupmod -g $APP_GROUP_GID $APP_GROUP && \
#    usermod -u $APP_USER_UID $APP_USER

#RUN addgroup -g $APP_GROUP_GID -S $APP_GROUP && \
#    adduser -s /sbin/nologin -S -u $APP_USER_UID -G $APP_GROUP $APP_USER

#USER $APP_USER

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]