# Docker container group for Laravel development

## Requirement
* Mac OSX with [Docker](https://www.docker.com/) installed.


## Container List
1. nginx 1.19.1
1. php engine
   * php 7.4
   * php-fpm
   * Laravel 7.21.0
1. SQL Server 2019
1. Redis 6.0.5

# Installion
run ```make install SA_PASSWORD=<Your Strong Password>``` under root directory

# Commands
1. ```make install SA_PASSWORD=<Your Strong Password>```: Builds images and ```make up```.
1. ```make up```: Builds, (re)creates, starts, and attaches to containers, alternative to ```docker-compose up -d```.
1. ```make down```: Stops and removes containers, alternative to ```docker-compose down```.
1. ```make stop```: Stops existing containers, alternative to ```docker-compose stop```.
1. ```make start```: Starts existing containers, alternative to ```docker-compose start```.
1. ```make restart```: Restarts all stopped and running services, alternative to ```docker-compose restart```.
