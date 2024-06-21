run:
	docker-compose up -d

build: copy-env
	docker-compose build

build-no-cache: copy-env
	docker-compose build --no-cache

download-app-and-run-setup:
	docker-compose run --rm php bash -i -c "\
	git clone https://github.com/frizus/php-test-work1.git ./; \
	make setup"

test:
	docker-compose run --rm php bash -i -c "make test"

copy-env:
	cp -n .env.default .env || true

down:
	docker-compose stop || true

build-php:
	docker-compose build php

rebuild-php:
	docker-compose build --no-cache php

build-nginx:
	docker-compose build nginx

rebuild-nginx:
	docker-compose build --no-cache nginx

setup: down build download-app-and-run-setup

start: run

launch: run

compose: run

up: run

.PHONY: test