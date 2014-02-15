BUILD:
docker build -t armin/postgres:v1 .

RUN:
docker run -i -t -p 5432:5432 armin/postgres:v1