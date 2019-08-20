FROM mogtofu33/drupal8ci:$DRUPAL_TAG

LABEL maintainer="dev-drupal.com"

USER www-data

# Update Drupal 8 Node tools / linters / Nightwatch.
WORKDIR /var/www/.node

RUN cp /var/www/html/core/package.json /var/www/.node \
  && yarn install --no-progress \
  && npm cache clean --force

USER root

WORKDIR /var/www/html

RUN ln -sf /var/www/.node/node_modules/.bin/* /usr/local/bin \
  && ln -sf /var/www/.node/node_modules /var/www/html/core/node_modules

# Install Chromium 76 on debian.

COPY 99defaultrelease /etc/apt/apt.conf.d/99defaultrelease
COPY sources.list /etc/apt/sources.list.d/sources.list

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
  && apt-get update && apt-get -t testing install --no-install-recommends -y \
  chromium


# Remove the vanilla Drupal project that comes with the parent image.
RUN rm -rf ..?* .[!.]* *

RUN set -eux; \
  curl -fSL "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_DEV_TAG}.tar.gz" -o drupal.tar.gz; \
  tar -xz --strip-components=1 -f drupal.tar.gz; \
  rm drupal.tar.gz; \
  chown -R www-data:www-data sites modules themes
