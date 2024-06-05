FROM python:3.6-slim-buster

WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

# Install psycopg2 for PostgreSQL connection
RUN apt-get update && apt-get install -y gcc python3-dev libpq-dev
RUN pip install psycopg2

COPY . .

EXPOSE 4000

CMD ["python", "app.py"]
