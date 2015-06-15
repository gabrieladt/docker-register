FROM ubuntu:14.04
MAINTAINER Jason Wilder jwilder@litl.com

RUN apt-get update
RUN apt-get install -y wget python python-pip python-dev libssl-dev libffi-dev bash

RUN mkdir /app
WORKDIR /app

RUN mkdir -p /usr/local/bin
ADD docker-gen /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-gen

RUN pip install python-etcd

ADD . /app

ENV DOCKER_HOST unix:///var/run/docker.sock

CMD docker-gen -interval 10 -watch -notify "python /tmp/register.py" etcd.tmpl /tmp/register.py
