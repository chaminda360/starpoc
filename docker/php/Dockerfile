### Dockerfile ###
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-install pdo pdo_mysql

# Commenting out image processing libraries as they are not required for the current application
# RUN apt-get update && apt-get install -y \
#     libpng-dev \
#     libjpeg-dev \
#     libfreetype6-dev \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg \
#     && docker-php-ext-install gd

# Commenting out unnecessary parts for the current application
# RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
# && apt-get install -y nodejs

# RUN node -v && npm -v

# COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# RUN mkdir -p /var/www/storage && \
#     chown -R www-data:www-data /var/www && \
#     chmod -R 775 /var/www/storage

# Copy existing application directory contents
COPY . .

# Expose port 3000
EXPOSE 3000

# Add a health check to ensure the container is running correctly
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:3000 || exit 1

CMD ["php-fpm"]