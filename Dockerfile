# Use official PHP with FPM
FROM php:8.2-fpm

# Install NGINX and other packages
RUN apt-get update && apt-get install -y nginx supervisor

# Install Composer 2.8.1 manually
RUN curl -sS https://getcomposer.org/download/2.8.1/composer.phar -o /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Copy PHP app files to web root
COPY ./ /var/www/html

#You need to give write permissions to the storage and bootstrap/cache directories.
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
    
# Run Composer install
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Configure NGINX
COPY ./default.conf /etc/nginx/sites-available/default

# Configure Supervisor to manage both PHP and NGINX
COPY ./supervisord.conf /etc/supervisord.conf

# Expose web port
EXPOSE 80

# Start both NGINX and PHP using Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]