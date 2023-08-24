#
# version: 1.1.11
# このファイルが変更されていたらcodeBuildで新しくイメージが作られる
#
FROM public.ecr.aws/nginx/nginx:1.20.2-alpine as awsvpc

RUN apk --no-cache add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/conf.d/default_awsvpc.conf /etc/nginx/conf.d/default.conf
WORKDIR /var/www/

FROM awsvpc as dev
COPY ./conf/conf.d/default_awsvpc.dev.conf /etc/nginx/conf.d/default.conf

FROM awsvpc as stg
COPY ./conf/conf.d/default_awsvpc.stg.conf /etc/nginx/conf.d/default.conf

FROM awsvpc as local
COPY ./conf/conf.d/default_local.conf /etc/nginx/conf.d/default.conf
