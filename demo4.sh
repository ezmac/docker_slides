#!/bin/bash
source colors.sh
one_gig_dockerfile=$(cat <<EOF
FROM ubuntu:latest
RUN dd if=/dev/urandom of=/datafile bs=1024 count=1048576
EOF
)

two_gig_dockerfile=$(cat <<EOF
FROM ubuntu:latest
RUN dd if=/dev/urandom of=/datafile bs=1024 count=1048576
RUN chmod 777 /datafile
EOF
)

echo -e "${red} Building Dockerfile\n"
echo -e "${yellow}$one_gig_dockerfile ${NC}\n"

echo "$one_gig_dockerfile"|docker build -t one_gig - 2>/dev/null 1>/dev/null
size=`docker image inspect one_gig --format='{{.Size}}'`
echo -e "${red}image size: ${lpurp}"
echo -e $( echo -e "scale=2 \n $size/(1024^3)" |bc )GB ${NC}

read


echo -e "${red} Building Dockerfile\n"
echo -e "${yellow}$two_gig_dockerfile ${NC}\n"
echo "$two_gig_dockerfile"|docker build -t two_gig - 2>/dev/null 1>/dev/null
size=`docker image inspect two_gig --format='{{.Size}}'`
echo -e "${red}image size: ${lpurp}"
echo -e $( echo -e "scale=2 \n $size/(1024^3)" |bc )GB ${NC}
