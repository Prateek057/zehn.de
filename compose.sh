#!/bin/bash
## docker login with ops user
docker login -u prateek057 -p Bakuman057
## pull new images
docker-compose pull
## stop old containers
docker-compose stop
## remove old containers
docker-compose rm -f
## start new containers
docker-compose up -d
##copy dump to container
docker cp dump.sql $(docker ps --format "{{.Names}}" | grep db):/dump.sql
##restore data base
#docker exec -t $(docker ps --format "{{.Names}}" | grep db) /bin/bash -c "export TERM=dumb"
docker exec -i $(docker ps --format "{{.Names}}" | grep db) mysql -uroot -pexample wordpress < dump.sql
exit