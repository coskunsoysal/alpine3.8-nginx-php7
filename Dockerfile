FROM alpine:3.8
LABEL Maintainer="Coşkun Soysal <coskunsoysal@gmail.com>" \
      Description="Lightweight container with Nginx 1.15 & PHP-FPM 7.2 based on Alpine Linux 3.8."

# Install php packages 
RUN apk --no-cache add php7.2 php7.2-fpm php7.2-mysqli php7.2-json php7.2-openssl php7.2-curl \
    php7.2-zlib php7.2-xml php7.2-phar php7.2-intl php7.2-dom php7.2-xmlreader php7.2-ctype \
    php7.2-mbstring php7.2-gd curl

# Install nginx 
RUN apk --no-cache add nginx

# Configure nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY conf/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf

# Add application
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
RUN echo "<?php info();" >> /var/www/html/index.php

EXPOSE 80 443
