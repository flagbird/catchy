FROM ubuntu:14.04

RUN apt-get update --fix-missing
RUN apt-get -qq install -y language-pack-en-base software-properties-common python-software-properties build-essential apt-transport-https
RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update
RUN apt-get -qq install -y --force-yes php7.0 php7.0-mcrypt php7.0-mysql php7.0-gd php7.0-curl php7.0-intl php7.0-xsl ca-certificates curl ssl-cert
RUN rm -Rf /etc/php5

# Catchy.io
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DE1D1B6C
RUN add-apt-repository "deb https://deb.catchy.io/ catchy main"
RUN apt-get update
RUN apt-get -y install catchy-io-daemon catchy-io-php

# Symfony
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony
RUN mkdir -p /var/www/html
RUN symfony new /var/www/html 3.0

EXPOSE 8000

# RUN php /var/www/html/bin/console server:start 0.0.0.0:8000

RUN echo "\033[1;36mThe IP is: $(ifconfig eth0 | egrep -o "inet addr:[0-9\.]+" | cut -d: -f2)\033[0m"

CMD ["php", "/var/www/html/bin/console", "server:run", "0.0.0.0:8000"]