#!/bin/bash
source colors.sh
dockerfile=$(cat <<EOF

FROM ubuntu:latest
RUN apt-get update && apt-get install -y python python-pip
EOF
)
echo -e "${red} Building Dockerfile\n"
echo -e "${yellow}$dockerfile ${NC}\n"
echo "$dockerfile" >ubuntu-python.Dockerfile

docker build -t ubuntu-python -f ubuntu-python.Dockerfile .
