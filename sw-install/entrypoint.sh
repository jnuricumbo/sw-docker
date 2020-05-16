#!/bin/sh
set -e

# Starts apache and mysql
sudo service apache2 restart
sudo /etc/init.d/mysql start

exec /bin/bash $@
