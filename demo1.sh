#!/bin/bash

source colors.sh
# Clean up old resources

echo -e "${red}Starting container container with ${lpurp}"
echo -e "docker run -it --rm docker/surprise ${NC}"

docker run -it --rm docker/surprise
