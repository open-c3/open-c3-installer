#!/bin/bash

OPENC3VERSION=v2.6.1

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
cd /data/open-c3-installer  && git clone -b "$OPENC3VERSION" https://github.com/open-c3/open-c3


/data/open-c3-installer/tools/image-save.sh

UUID=$(date +%Y%m%d.%H%M)

cd /data && tar -zcvf /data/open-c3-installer-$OPENC3VERSION-$UUID.tar.gz open-c3-installer

rm -rf /tmp/bdyDiskUpload
/data/open-c3-installer/tools/uploadBaiduCloud.sh /data/open-c3-installer-$OPENC3VERSION-$UUID.tar.gz /open-c3-installer/$OPENC3VERSION/open-c3-installer-$OPENC3VERSION-$UUID.tar.gz
