# Use official PHP with FPM
FROM php:8.2-fpm

# Install NGINX and other packages
RUN apt-get update && apt-get install -y nginx supervisor

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy PHP app files to web root
COPY ./ /var/www/html

# Configure NGINX
COPY ./default.conf /etc/nginx/sites-available/default

# Configure Supervisor to manage both PHP and NGINX
COPY ./supervisord.conf /etc/supervisord.conf

# Run Composer install
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Expose web port
EXPOSE 80

# Start both NGINX and PHP using Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]