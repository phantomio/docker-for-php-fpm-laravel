up:
	docker-compose up -d
build:
	docker-compose build --no-cache --force-rm
container:
	@make build
	@make up
	docker-compose exec php composer create-project --prefer-dist laravel/laravel .
	docker-compose exec php chmod -R 777 storage/ bootstrap/cache/
	docker-compose exec php composer require --dev barryvdh/laravel-ide-helper
	docker-compose exec php composer require --dev barryvdh/laravel-debugbar
