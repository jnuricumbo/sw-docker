#!/bin/sh

SHOPWARE_PUBLIC_DIR=/var/www/shopware/public
# Copy config and enable site
sudo a2dissite 000-default.conf
sudo rm /etc/apache2/sites-available/000-default.conf
sudo rm /etc/apache2/ports.conf
sudo cp /install/shopware.conf /etc/apache2/sites-available/shopware.conf
sudo cp /install/ports.conf /etc/apache2/ports.conf

sudo a2ensite shopware.conf
# Add info
sudo cp /install/info.php $SHOPWARE_PUBLIC_DIR/info.php
# Adapt ini
sudo sed -i 's/;opcache.validate_root=0/opcache.validate_root=1/g' /etc/php/7.4/apache2/php.ini
sudo sed -i 's/memory_limit = 128M/memory_limit = 1024M/g' /etc/php/7.4/apache2/php.ini
sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 6M/g' /etc/php/7.4/apache2/php.ini

sudo chown www-data:www-data $SHOPWARE_PUBLIC_DIR/private.pem
sudo chown www-data:www-data $SHOPWARE_PUBLIC_DIR/public.pem

# Restart
sudo service apache2 reload
sudo service apache2 restart
