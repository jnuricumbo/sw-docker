#!/bin/sh

SHOPWARE_DIR=/var/www/shopware
# Copy config and enable site
sudo a2dissite 000-default.conf
sudo rm /etc/apache2/sites-available/000-default.conf
sudo rm /etc/apache2/ports.conf
sudo cp /sw-install/shopware.conf /etc/apache2/sites-available/shopware.conf
sudo cp /sw-install/ports.conf /etc/apache2/ports.conf

sudo a2ensite shopware.conf
# Add info
sudo cp /sw-install/info.php $SHOPWARE_DIR/public/info.php
# Adapt ini
sudo sed -i 's/;opcache.validate_root=0/opcache.validate_root=1/g' /etc/php/7.2/apache2/php.ini
sudo sed -i 's/memory_limit = 128M/memory_limit = 1024M/g' /etc/php/7.2/apache2/php.ini
sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 6M/g' /etc/php/7.2/apache2/php.ini
# pem key should be owned by apache
sudo chown www-data:www-data $SHOPWARE_DIR/config/jwt/private.pem
sudo chown www-data:www-data $SHOPWARE_DIR/config/jwt/public.pem

# Restart
sudo a2enmod rewrite
sudo service apache2 reload
sudo service apache2 restart
