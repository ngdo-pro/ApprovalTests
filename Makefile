build: ## Build php-fpm dev image (Use IMAGE_DEV='Your image name' to define the image name, COMPOSER_GITHUB_OAUTH='your github auth token' to retrieve Evaneos private repositories)
	docker build -t approval:test -f Dockerfile .

test:
	docker-compose run --rm -T php sh -c "php vendor/bin/phpunit --verbose --configuration=phpunit.xml --stop-on-failure --colors $(R)"
