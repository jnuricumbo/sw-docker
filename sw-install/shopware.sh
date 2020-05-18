#!/bin/sh

SW_DIR=/var/www/shopware
git clone --branch=6.2 https://github.com/shopware/development $SW_DIR
cp -avr .psh.yaml.override $SW_DIR/.psh.yaml.override

# Configure NPM before start installer
mkdir /sw-install/.config
sudo chown -R $USER:$(id -gn $USER) /sw-install/.config
npm config set unsafe-perm true

cd $SW_DIR
./psh.phar install
cd ~
