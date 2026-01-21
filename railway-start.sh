#!/bin/bash
set -e
set -x

# Check if PORT is defined
if [ -n "$PORT" ]; then
    echo "PORT defined as $PORT. Configuring Apache..."

    # Update ports.conf
    # Matches "Listen 80", "Listen  80", etc.
    if [ -f /etc/apache2/ports.conf ]; then
        echo "Updating /etc/apache2/ports.conf"
        sed -E -i "s/Listen[[:space:]]+80/Listen $PORT/g" /etc/apache2/ports.conf
        grep "Listen $PORT" /etc/apache2/ports.conf || echo "WARNING: Could not find 'Listen $PORT' in ports.conf after sed"
    else
        echo "WARNING: /etc/apache2/ports.conf not found!"
    fi

    # Update default site config
    # Matches "<VirtualHost *:80>", "<VirtualHost   *:80>", etc.
    if [ -f /etc/apache2/sites-available/000-default.conf ]; then
        echo "Updating /etc/apache2/sites-available/000-default.conf"
        sed -E -i "s/<VirtualHost[[:space:]]+\*:80>/<VirtualHost *:$PORT>/g" /etc/apache2/sites-available/000-default.conf
    else
        echo "WARNING: /etc/apache2/sites-available/000-default.conf not found!"
    fi
else
    echo "PORT not defined. Defaulting to standard configuration."
fi

# Execute the original entrypoint
echo "Starting WordPress..."
exec docker-entrypoint.sh "$@"
