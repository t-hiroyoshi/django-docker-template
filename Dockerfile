FROM python:3
MAINTAINER Hiroyoshi Takahashi <t.hiroyoshi209@gmail.com>

ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get install -y nginx supervisor memcached && \
    rm -rf /var/lib/apt/lists/*

# setting up nginx and supervisor
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor.conf /etc/supervisor/conf.d/

# setting up django
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt

ADD . /code/
RUN chmod +x /code/run.sh
RUN chmod +x /code/run.development.sh

CMD ./run.sh
