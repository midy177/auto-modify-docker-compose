#!/bin/bash
. /etc/profile
. ~/.bash_profile
intag=$1
newtag=$(echo $intag | tr -d "a-zA-Z/")
echo "the tag is ${newtag}"
oldtag=`grep "image: " docker-compose.yml|awk NR==1|awk -F "image: " '{print $2}'|awk -F ":" '{print $NF}'`
imname=`grep "image: " docker-compose.yml|awk NR==1|awk -F "image: " '{print $2}'|awk -F ":" '{print $1}'`
echo "docker pull ${imname}:${newtag}"
docker pull ${imname}:${newtag}
if [ $? -eq 0 ]; then
     echo "pull image successfull!"
     sed -e s/${oldtag}/${newtag}/g docker-compose.yml
else
     echo "pull image failed! Please check if the image exists in the repository?"
     exit 0
fi
