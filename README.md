# Docker container group for Laravel development
## Container List:
1. nginx
1. php engine
   * php 7.4
   * php-fpm
   * Laravel
1. SQL Server 2019
1. Redis

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
