FROM public.ecr.aws/docker/library/busybox:latest
# プロジェクトルートからビルドすること。
COPY ./src/ /var/www/
RUN chmod -R 777 /var/www/storage/ /var/www/bootstrap/cache
COPY ./docker/app/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
VOLUME ["/var/www"]
ENTRYPOINT ["/docker-entrypoint.sh"]
