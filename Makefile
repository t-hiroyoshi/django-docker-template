backup:
	docker exec djangodockertemplate_web_1 pg_dumpall -U postgres > backup.sql

clean: cleanContainers cleanVolumes cleanImages

cleanContainers:
	- docker rm -f `docker ps -aq`

cleanVolumes:
	- docker volume rm `docker volume ls -q`

cleanImages:
	- docker rmi `docker images`

cleanUp:
	- docker images | awk '/<none/{print $3}' | xargs docker rmi

closeDev:
	docker-compose -f docker-compose.development.yml stop

deploy:
	docker-compose -f docker-compose.production.yml up -d --build web

dev:
	- docker-compose -f docker-compose.development.yml up -d
	- docker exec -it djangodockertemplate_web_1 bash

stop:
	docker stop `docker ps -aq`

update:
	docker-compose -f docker-compose.development.yml build web
