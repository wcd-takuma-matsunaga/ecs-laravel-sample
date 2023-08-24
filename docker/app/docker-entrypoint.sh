#!/bin/sh
set -eu
#echo -e "${LARAVEL_ENV}" > /var/www/.env
exec "$@"
