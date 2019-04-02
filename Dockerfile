ARG MEDIA_WIKI_VERSION=1.31.0
FROM mediawiki:${MEDIA_WIKI_VERSION}
ARG SEMANTIC_MEDIA_WIKI_VERSION=2.5.0

ENV COMPOSER_SHA384 "48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5"
ENV EXTENSION_SOURCE "https://extdist.wmflabs.org/dist/extensions"
ENV SEMANTIC_DRILLDOWN_SOURCE "${EXTENSION_SOURCE}/SemanticDrilldown-REL1_32-54a27ed.tar.gz"
ENV CARGO_SOURCE "${EXTENSION_SOURCE}/Cargo-REL1_32-dac1f35.tar.gz"

RUN set -ex \
 && apt-get update \
 && apt-get install -y --no-install-recommends unzip \
 && rm -rf /var/lib/apt/lists/* \
 && curl -sfL https://getcomposer.org/installer -o composer-setup.php \
 && echo "${COMPOSER_SHA384} composer-setup.php" | sha384sum -c - \
 && php composer-setup.php \
 && rm -f composer-setup.php \
 && php composer.phar update --no-dev \
 && php composer.phar require mediawiki/semantic-media-wiki ${SEMANTIC_MEDIA_WIKI_VERSION} \
 && chown -R www-data:www-data /var/www/html \
 && curl -s -f ${SEMANTIC_DRILLDOWN_SOURCE} | tar -xzv -C /var/www/html/extensions && \
    curl -s -f ${CARGO_SOURCE} | tar -xzv -C /var/www/html/extensions 