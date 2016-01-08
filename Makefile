SHELL   :=/bin/bash
PORT     = 4000
UNAME_S := $(shell uname -s)


.PHONY: bootstrap initdb build start watch


bootstrap:
ifeq "$(UNAME_S)" "Darwin"
	brew tap zewo/tap
	brew install libvenice postgresql
else
	sudo add-apt-repository 'deb [trusted=yes] http://apt.zewo.io/deb ./'
	sudo apt-get install libvenice postgresql
endif
	pip install watchdog --upgrade


initdb:
	@sudo -u postgres psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='postgres'" | grep -q 1 || createuser -d -w postgres
	@sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -wq blog || createdb -Opostgres -Eutf8 blog
	@sudo -u postgres psql -U postgres -d blog -f db.sql


watch:
	@echo "OK. Try edit your Swift code."
	@watchmedo shell-command \
	  --command='make stop; make build; make start' \
	  --recursive \
	  --patterns="*.swift" \
	  .


stop:
	@pkill blog 2>&1 >/dev/null


clean:
	@rm -rf ./Packages


build:
	@swift build --configuration release


start:
	@.build/release/blog --port $(PORT) &
	@echo "Server started: http://0.0.0.0:$(PORT)" 

