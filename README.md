# Docker container group for Laravel development

## Requirement
* Mac OSX with [Docker](https://www.docker.com/) installed.


## Container List
1. nginx
1. php engine
   * php 7.4
   * php-fpm
   * Laravel 7.21.0
1. SQL Server 2019
1. Redis 6.0.5

# Installion
1. Replace <your password> with your SQL Server password under docker-compose.yml
```yml
  sqlsrv:
    ...
    ...
    environment:
      ACCEPT_EULA: Y
      MSSQL_SA_PASSWORD: <your password> <-- here
    ...
```

2. run ```make container``` under root directory
