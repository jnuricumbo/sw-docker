## Steps to build and configure a production shopware instance
### Build image and run it
```zsh
  docker build --tag shopware:6.2 .
```
```zsh
  docker run -p 8000:8000/tcp -it shopware:6.2 /bin/bash
```

### Run installers
#### Mysql
Inside of container call the mysql installer and create a user as follow
```zsh
sudo /etc/init.d/mysql start
sudo mysql_secure_installation
sudo mysql -u root
CREATE USER 'app'@'localhost' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON *.* TO 'app'@'localhost';
FLUSH PRIVILEGES;
exit
```
#### Shopware
Run shopware installer, it will take some time to download dependencies, after that just follow the instructions. Use http://localhost:8000 as APP_URL and the DB credentials created in previous step
```zsh
  sudo /install/shopware.sh
```
#### Apache
Run apache configurator
```zsh
  sudo /install/apache.sh
```