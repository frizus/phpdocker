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

start: run

launch: run

compose: run

up: run