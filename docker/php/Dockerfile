### Dockerfile ###
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Install Node.js and npm (using NodeSource repository for latest version)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
&& apt-get install -y nodejs

# Verify Node.js and npm versions
RUN node -v && npm -v

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy existing application directory contents
COPY . .

# Set permissions
RUN mkdir -p /var/www/storage && \
    chown -R www-data:www-data /var/www && \
    chmod -R 775 /var/www/storage

# Expose port 9000
EXPOSE 9000
CMD ["php-fpm"]