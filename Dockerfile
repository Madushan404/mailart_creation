FROM wordpress:latest

# Copy your local custom code (themes, plugins, etc.) into the container
# Use --chown to ensure correct permissions for the web server
COPY --chown=www-data:www-data ./wp-content /var/www/html/wp-content

# Copy the custom entrypoint script
COPY railway-start.sh /usr/local/bin/railway-start.sh
RUN chmod +x /usr/local/bin/railway-start.sh

# Set the custom entrypoint
ENTRYPOINT ["railway-start.sh"]
CMD ["apache2-foreground"]
