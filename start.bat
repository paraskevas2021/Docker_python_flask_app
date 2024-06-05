@echo off
REM Create Docker network
docker network create my-network

REM Start the PostgreSQL container
docker run -d ^
    --name my-postgres ^
    --network my-network ^
    -v postgres-data:/var/lib/postgresql/data ^
    -e POSTGRES_PASSWORD=mysecretpassword ^
    postgres:13

REM Wait for the database to start
echo Waiting for the database to start...
timeout /t 10 /nobreak

REM Build the Flask application image
docker build -t my-flask-app .

REM Start the Flask application container
docker run -d ^
    --name my-flask-app ^
    --network my-network ^
    -p 4000:4000 ^
    -e DATABASE_URL=postgresql://postgres:mysecretpassword@my-postgres:5432/postgres ^
    my-flask-app

REM Wait for the containers to initialize
timeout /t 10 /nobreak

REM Get logs for the PostgreSQL container
echo PostgreSQL container logs:
docker logs my-postgres

REM Get logs for the Flask application container
echo Flask application container logs:
docker logs my-flask-app
