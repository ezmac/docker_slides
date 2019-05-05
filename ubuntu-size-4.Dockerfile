FROM ubuntu:latest
RUN dd if=/dev/urandom of=/datafile bs=1024 count=1048576
