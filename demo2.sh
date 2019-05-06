#!/bin/bash

source colors.sh
# Clean up old resources
rm zzz_new_file

echo -e "${red} Running \n ${lpurp}\"docker run -it ubuntu ls /root/\" ${yellow}"
docker run -it ubuntu ls -lah /root/
echo -e "${NC}"
echo "notice mostly empty"

read

echo -e "${red} Running \n ${lpurp}\"docker run -it -v \$PWD:/root/ ubuntu ls /root/\" ${yellow}"
docker run -it -v $PWD:/root/ ubuntu ls /root/
echo -e "${NC}"
echo "notice it contains my notes"

read


echo -e "${red} Running \n ${lpurp}\"docker run -it -v \$PWD:/root/ ubuntu touch /root/zzz_new_file\" ${yellow}"
docker run -it -v $PWD:/root/ ubuntu touch /root/zzz_new_file
echo -e "${NC}"

read
