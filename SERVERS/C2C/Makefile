up-msf:
	bash -x metasploit-framework/docker/bin/msfconsole
up-beef:
	#cd metasploit-framework && \
	#docker-compose -f docker-compose.yml.full up beef
	cd beef && docker-compose up
build-all:
	make build-msf
	make build-beef

build-msf:
	cd metasploit-framework && docker-compose build

build-beef:
	cd beef && docker-compose build

up-bg:
	make up-msf &
	make up-beef &

build:
	make build-all
