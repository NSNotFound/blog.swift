# How to install PostgreSQL
##	Mac:

	$ brew update
	$ brew doctor
	
	$ brew install postgresql
	
	$ gem install lunchy
	
	$ mkdir -p ~/Library/LaunchAgents
	$ cp /usr/local/Cellar/postgresql/9.2.1/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/

	
	$ lunchy start postgre
	$ lunchy stop postgres

Ref: [How to Install PostgreSQL on a Mac With Homebrew and Lunchy](https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/)

## Ubuntu 14.04

	sudo apt-get update
	sudo apt-get install postgresql postgresql-contrib
	
	sudo service postgresql start
	
Ref: [How To Install and Use PostgreSQL on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04)