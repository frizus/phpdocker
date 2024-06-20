run:
	docker-compose up -d

build: copy-env
	docker-compose build

build-no-cache: copy-env
	docker-compose build --no-cache

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

start: run

launch: run

compose: run

up: run