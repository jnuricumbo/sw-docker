#!/bin/sh

git clone --branch=6.2 https://github.com/shopware/production shopware

SHOPWARE_DIR=/var/www/shopware
cp -avr shopware/ $SHOPWARE_DIR
rm -rf shopware/
cd $SHOPWARE_DIR

# install shopware and dependencies according to the composer.lock 
composer install

# Permissions
chmod 777 $SHOPWARE_DIR
chmod 777 -R $SHOPWARE_DIR/var/cache/
chmod 777 -R $SHOPWARE_DIR/var/log/
chmod 777 $SHOPWARE_DIR/public
chmod 777 $SHOPWARE_DIR/config/jwt/
chmod 777 $SHOPWARE_DIR/public/recovery/install/data/
chmod 777 $SHOPWARE_DIR/custom/plugins/
chmod 777 $SHOPWARE_DIR/public/media/
chmod 777 $SHOPWARE_DIR/public/theme/

# setup the environment
bin/console system:setup
# or create .env yourself, if you need more control
# create jwt secret: bin/console system:generate-jwt-secret
# create app secret: APP_SECRET=$(bin/console system:generate-app-secret)
# create .env

# create database with a basic setup (admin user and storefront sales channel)
# or use the interactive installer in the browser: /recovery/install/index.php
bin/console system:install --create-database --basic-setup

# COMPOSER_HOME
echo COMPOSER_HOME="/sw-install/" >> $SHOPWARE_DIR/.env

cd ~
