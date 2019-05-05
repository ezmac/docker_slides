#!/bin/bash
source colors.sh
# cleaning up old resources
docker stop app mongodb 2>/dev/null 1>/dev/null
docker network rm internauts  2>/dev/null 1>/dev/null


echo -e "${red}creating docker network \"internauts\" with ${lpurp}"
echo -e " docker network create internauts ${NC}"
docker network create internauts

echo -e "${red}Starting mongo container with ${lpurp}"
echo -e " docker run -d --rm --name=mongodb --env-file=.env --network internauts mongo ${NC}"

docker run -d --rm --name=mongodb --env-file=.env --network internauts mongo

echo -e "${red}Starting app container with ${lpurp}"
echo -e " docker run --name app --rm --init -t --env-file=.env --network internauts -p 4300:4300 compose_app ${NC}"

docker run --name app --rm --init -t --env-file=.env --network internauts -p 4300:4300 compose_app 2>/dev/null 1>/dev/null
