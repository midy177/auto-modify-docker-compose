#!/bin/bash
. /etc/profile
. ~/.bash_profile
intag=$1
imname=$2
newtag=$(echo $intag|awk '{$1=substr($1,12)}1')
echo "the tag is ${newtag}"
oldtag=`grep "${imname}" docker-compose.yml|awk NR==1|awk -F ":" '{print $NF}'`
echo "docker pull ${imname}:${newtag}"
docker pull ${imname}:${newtag}
if [ $? -eq 0 ]; then
     echo "pull image successfull!"
     sed -i s/${oldtag}/${newtag}/g docker-compose.yml
     rm $0
else
     echo "pull image failed! Please check if the image exists in the repository?"
     rm $0 
     exit 0
fi
