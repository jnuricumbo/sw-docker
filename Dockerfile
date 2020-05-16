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

WORKDIR /sw-install
COPY sw-install/ .

# Create user, give privileges and use sw-install as home directory
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN sudo chown -R ubuntu:ubuntu /sw-install
RUN sudo usermod -d /sw-install ubuntu

# Install composer
RUN ./composer.sh

# Entry on sw-install home directory
USER ubuntu
ENTRYPOINT ["/bin/bash"]

# Expose the port apache is reachable on
EXPOSE 8000/tcp