@echo off
REM Creating an image for the RESTful service
docker build -t my-flask-app .

REM Creating a storage space for the database
docker volume create postgres-data
