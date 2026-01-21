#!/bin/bash
set -e

# If PORT is defined, configure Apache to listen on that port.
if [ -n "$PORT" ]; then
    echo "Configuring Apache to listen on port $PORT..."
    sed -i "s/Listen 80/Listen $PORT/g" /etc/apache2/ports.conf
    sed -i "s/<VirtualHost \*:80>/<VirtualHost *:$PORT>/g" /etc/apache2/sites-available/000-default.conf
fi

# Execute the original entrypoint
exec docker-entrypoint.sh "$@"
