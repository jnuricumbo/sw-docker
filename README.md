## Steps to build and configure a production shopware instance
### Build image and run it
#### Build
```zsh
  docker build --tag shopware:6.2 .
```
#### Run
```zsh
  docker run --name shopware -d -p 8000:8000 -it shopware:6.2
```
#### Go inside container
```zsh
  docker exec -it shopware bash
```

### Run installers
Inside of container and the home directory sw-install call the mysql, shopware and apache installer
#### Mysql
Setup mysql, choose a password and just answer yes to all
```zsh
sudo /etc/init.d/mysql start
sudo mysql_secure_installation
```
Create a user 'app' with password 'shopware' with all privile1ges
```zsh
sudo mysql -u root
CREATE USER 'app'@'localhost' IDENTIFIED BY 'shopware';
GRANT ALL PRIVILEGES ON *.* TO 'app'@'localhost';
FLUSH PRIVILEGES;
exit
```
#### Shopware
Run shopware installer, it will take some time to download dependencies, after that just follow the instructions. Use http://localhost:8000 as APP_URL and the DB credentials created in previous step
```zsh
  sudo ./shopware.sh
```
#### Apache
Run apache configurator
```zsh
  sudo ./apache.sh
```