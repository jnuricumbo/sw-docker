#!/bin/sh
set -e

# Starts apache and mysql
sudo service apache2 restart
sudo /etc/init.d/mysql start
sudo /etc/init.d/mysql restart

exec /bin/bash $@
