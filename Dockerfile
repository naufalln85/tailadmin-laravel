# Dockerfile
FROM ubuntu:22.04

# Install dependencies
RUN apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y apache2 \
    php \
    npm \
    php-xml \
    php-mbstring \
    php-curl \
    php-mysql \
    php-gd \
    unzip \
    nano  \
    curl \
    docker-compose

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Set up application directory
RUN mkdir /var/www/sosmed
ADD . /var/www/sosmed

# Configure Apache
ADD sosmed.conf /etc/apache2/sites-available/
RUN a2dissite 000-default.conf && \
    a2ensite sosmed.conf

# Set working directory
WORKDIR /var/www/sosmed

# Install application dependencies
RUN chmod +x install.sh
RUN ./install.sh

# Set permissions
RUN chown www-data:www-data /var/www/sosmed -R
RUN chmod -R 755 /var/www/sosmed

# Expose the port
EXPOSE 80

# Start Apache
CMD ["apachectl", "-D", "FOREGROUND"]
