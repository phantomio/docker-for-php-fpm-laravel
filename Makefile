up:
	docker-compose up -d
build:
	docker-compose build --build-arg SA_PASSWORD=$(SA_PASSWORD) --no-cache --force-rm
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
	docker-compose exec php cp .env.example .env
	docker-compose exec php php artisan key:generate
	docker-compose exec php php artisan storage:link
	@make restart
