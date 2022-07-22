#!/bin/bash
set -e

DHOST=/data/open-c3-installer/t/.dbhost
if [ ! -f $DHOST ];then
    echo nofind $DHOST
    exit
fi

LHOST=/data/open-c3-installer/t/.myhost
if [ ! -f $LHOST ];then
    echo nofind $LHOST
    exit
fi

if [ -f /data/open-c3/open-c3.sh ]; then

    if [ -d  /data/open-c3-installer/dockerimage ];then
        cd /data/open-c3-installer/dockerimage || exit 1
        ls | xargs -n 1 |grep compose | awk '{print "docker load -i " $1 }' | bash -x
    fi

    /data/open-c3/open-c3.sh stop
fi

docker ps     | grep -v CONTAINER | awk '{print $1}'| xargs -i{} docker stop {}
docker ps -a  | grep -v CONTAINER | awk '{print $1}'| xargs -i{} docker rm   {}

docker images | grep -v REPOSITORY | awk '{print $1":"$2}' | xargs -i{} docker rmi {}

docker system prune -f

rm -rf /data/open-c3-installer/book
rm -rf /data/open-c3-installer/dev-cache
rm -rf /data/open-c3-installer/dockerimage
rm -rf /data/open-c3-installer/install-cache
rm -rf /data/open-c3-installer/open-c3
rm -rf /data/open-c3-installer/bdyDiskUpload

