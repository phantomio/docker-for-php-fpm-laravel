up:
	docker-compose up -d
build:
	ifndef SA_PASSWORD
	$(error Database password is required, e.g. make install SA_PASSWORD=<your password>)
	endif
	docker-compose build --build-arg SA_PASSWORD=$(SA_PASSWORD) --force-rm
start:
	docker-compose start
stop:
	docker-compose stop
restart:
	docker-compose restart
install:
	@make build
	@make up
	docker-compose exec php composer create-project --prefer-dist laravel/laravel .
	docker-compose exec php chmod -R 777 storage/ bootstrap/cache/
	docker-compose exec php composer require --dev barryvdh/laravel-ide-helper
	docker-compose exec php composer require --dev barryvdh/laravel-debugbar
	docker-compose exec php composer require --dev predis/predis
	docker-compose exec php sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=sqlsrv/g' .env
	docker-compose exec php sed -i 's/DB_HOST=127.0.0.1/DB_HOST=laravel-sqlsrv/g' .env
	docker-compose exec php sed -i 's/DB_PORT=3306/DB_PORT=1433/g' .env
	docker-compose exec php sed -i 's/DB_USERNAME=root/DB_USERNAME=SA/g' .env
	docker-compose exec php sed -i 's/DB_PASSWORD=/DB_PASSWORD=$(SA_PASSWORD)/g' .env
	docker-compose exec php sed -i 's/REDIS_HOST=127.0.0.1/REDIS_HOST=laravel-redis/g' .env
	docker-compose exec php php artisan key:generate
	docker-compose exec php php artisan storage:link
	docker-compose rm -f init-data
	@make restart
down:
	docker-compose down
