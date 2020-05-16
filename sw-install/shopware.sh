#!/bin/sh

SHOPWARE_DIR=/var/www/shopware

# sudo wget https://www.shopware.com/de/Download/redirect/version/sw6/file/install_6.1.5_1585830011.zip -O sw6.zip
# sudo unzip sw6.zip -q -d ./shopware

git clone --branch=6.2 https://github.com/shopware/production $SHOPWARE_DIR
cd $SHOPWARE_DIR

# Permissions
sudo chmod 777 /var/www/shopware/
sudo chmod 777 /var/www/shopware/var/cache/
sudo chmod 777 /var/www/shopware/var/log/
# sudo chmod 777 /var/www/shopware/public
# sudo chmod 777 /var/www/shopware/config/jwt/
# sudo chmod 777 /var/www/shopware/public/recovery/install/data/

# install shopware and dependencies according to the composer.lock 
composer install

# setup the environment
bin/console system:setup
# or create .env yourself, if you need more control
# create jwt secret: bin/console system:generate-jwt-secret
# create app secret: APP_SECRET=$(bin/console system:generate-app-secret)
# create .env

# create database with a basic setup (admin user and storefront sales channel)
bin/console system:install --create-database --basic-setup

# or use the interactive installer in the browser: /recovery/install/index.php

