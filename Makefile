SHELL :=/bin/bash
PORT   = 3000

.PHONY: bootstrap initdb build start watch

bootstrap:
	pip install watchdog
	brew tap zewo/tap
	brew install libvenice postresql
	# add-apt-repository 'deb [trusted=yes] http://apt.zewo.io/deb ./'
	# apt-get install libvenice

initdb:
	@createdb -Opostgres -Eutf8 blog
	@psql -U postgres -d blog -f db.sql

watch:
	@echo "OK. Try edit your Swift code."
	@watchmedo shell-command \
	  --command='make stop; make build; make start' \
	  --recursive \
	  --patterns="*.swift" \
	  .

stop:
	@pkill blog 2>&1 >/dev/null

build:
	@swift build --configuration release

start:
	@.build/release/blog --port 3000 &
	@echo "Server started: http://0.0.0.0:3000" 

