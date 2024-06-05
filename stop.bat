@echo off
REM Stop and remove the containers
docker stop my-flask-app my-postgres
docker rm my-flask-app my-postgres

REM Remove the network
docker network rm my-network


