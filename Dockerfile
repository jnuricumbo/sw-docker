FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive 

# Update
RUN apt-get update

# Install packages
RUN apt-get install -y \
      sudo git wget vim unzip mysql-server \
      php libapache2-mod-php php-fpm \
      php-ctype php-curl php-dom php-fileinfo php-gd \
      php-iconv php-intl php-json php-mbstring \
      php-mysqli \
      php-simplexml php-tokenizer php-xml \
      php-xmlreader php-xmlwriter php-zip php-phar

# Copy scripts to install folder
COPY install/ /install/

# Install composer
RUN /install/composer.sh

# Create user and give privileges
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu

# Expose the port apache is reachable on
EXPOSE 8000/tcp