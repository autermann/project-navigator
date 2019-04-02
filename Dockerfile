FROM mediawiki:1.31.0

RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*

COPY composer.local.json /var/www/html

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"


RUN cd /var/www/html; php composer.phar update --no-dev;

RUN chown -R www-data:www-data /var/www/html

RUN curl -s -f https://extdist.wmflabs.org/dist/extensions/SemanticDrilldown-REL1_32-54a27ed.tar.gz | tar -xzv -C /var/www/html/extensions && \
    curl -s -f https://extdist.wmflabs.org/dist/extensions/Cargo-REL1_32-dac1f35.tar.gz | tar -xzv -C /var/www/html/extensions
