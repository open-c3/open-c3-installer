#!/bin/bash

VER=v2.6.1
TAG=v2.6.1
TID=$(date +%Y%m%d.%H%M)

ARG=$1

if [ "X$ARG" != "X" ];then
    TAG=$ARG
    VER=$(echo $ARG|awk -F'-' '{print $1}')
    TID=$(echo $ARG|awk -F'-' '{print $2}')
fi


if [ ! -d /data/open-c3-installer/dev-cache ];then
    cd /data/open-c3-installer && git clone https://github.com/open-c3/open-c3-dev-cache dev-cache
fi
cd /data/open-c3-installer/dev-cache && git pull



if [ ! -d /data/open-c3-installer/install-cache ];then
    cd /data/open-c3-installer && git clone http://github.com/open-c3/open-c3-install-cache install-cache
fi
cd /data/open-c3-installer/install-cache && git pull


rm -rf /data/open-c3-installer/book
cd /data/open-c3-installer  && git clone https://github.com/open-c3/open-c3.github.io  book


rm -rf /data/open-c3-installer/open-c3
cd /data/open-c3-installer  && git clone -b "$TAG" https://github.com/open-c3/open-c3


/data/open-c3-installer/tools/image-save.sh

rm -rf /data/open-c3-installer/bdyDiskUpload
cd /data && tar -zcvf /data/open-c3-installer-$VER-$TID.tar.gz open-c3-installer

if [ ! -f ~/.baiduDiskTokenFile ];then
    echo not .baiduDiskTokenFile
    exit
fi

/data/open-c3-installer/tools/uploadBaiduCloud.sh /data/open-c3-installer-$VER-$TID.tar.gz /open-c3-installer/$VER/open-c3-installer-$VER-$TID.tar.gz
