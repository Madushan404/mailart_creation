FROM wordpress:latest

# Copy your local custom code (themes, plugins, etc.) into the container
COPY ./wp-content /var/www/html/wp-content
