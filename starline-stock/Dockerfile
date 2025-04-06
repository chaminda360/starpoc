# Use the official PHP image with FPM
FROM php:8.1-fpm

# Set working directory
WORKDIR /var/www/starline-stock

# Copy application files
COPY . /var/www/starline-stock

# Install dependencies including Nginx and PHP extensions
# RUN apt-get update && apt-get install -y \
#     libzip-dev \
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     libxml2-dev \
#     unzip \
#     git \
#     curl

# Install dependencies including Nginx
RUN apt-get update && apt-get install -y \
    nginx \
    && docker-php-ext-install pdo pdo_mysql

# Set permissions
RUN chown -R www-data:www-data /var/www/starline-stock \
    && chmod -R 755 /var/www/starline-stock

# Copy Nginx configuration
COPY ../nginx/conf.d/starline-stock.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start PHP-FPM and Nginx
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
