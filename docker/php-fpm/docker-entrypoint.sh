#!/bin/sh
set -eu
#cd /var/www
#php artisan route:cache
#php artisan config:cache
#echo 'Docker entrypoint script finished' > docker-entrypoint.log
#cd -
printenv | grep -v "no_proxy" >> /etc/environment
exec "$@"
