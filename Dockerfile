FROM alpine:3.8
LABEL Maintainer="Coşkun Soysal <coskunsoysal@gmail.com>" \
      Description="Lightweight container with Nginx 1.15 & PHP-FPM 7.2 based on Alpine Linux 3.8."

# Install php packages 
RUN apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-gd curl

# Install nginx 
RUN apk --no-cache add nginx

# Install supervisor
RUN apk --no-cache add supervisor

# Configure nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY conf/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf

# Configure supervisord
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
RUN mkdir -p /var/www/html
WORKDIR /var/www/html
RUN echo "<?php phpinfo();" >> /var/www/html/index.php

EXPOSE 80 443

# run nginx and php with supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
