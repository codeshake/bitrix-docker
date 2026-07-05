FROM nginx:stable-alpine

RUN apk add --no-cache shadow

RUN usermod -u 1000 nginx && groupmod -g 1000 nginx
