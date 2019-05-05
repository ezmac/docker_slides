#!/bin/bash

source colors.sh
# Clean up old resources
docker stop app mongodb 2>/dev/null 1>/dev/null

echo -e "${red}Starting mongo container with ${lpurp}"
echo -e " docker run -d --rm --name=mongodb --env-file=.env mongo ${NC}"
docker run -d --rm --name=mongodb --env-file=.env mongo

echo -e "${red}Starting app container with ${lpurp}"
echo -e " docker run --name app --rm --init --env-file=.env --link mongodb -p 4300:4300 compose_app ${NC}"
docker run --name app --rm --init --env-file=.env --link mongodb -p 4300:4300 compose_app 2>/dev/null 1>/dev/null
docker stop app mongodb
