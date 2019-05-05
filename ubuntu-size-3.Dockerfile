FROM ubuntu:latest
RUN apt-get update &&\
    apt-get install --no-install-recommends -y python python-pip &&\
    rm -rf /var/lib/apt/lists/*
