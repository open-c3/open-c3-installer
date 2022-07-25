#!/bin/bash
set -e

TAG=$1

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

DH=`cat $DHOST`;
LH=`cat $LHOST`


if [ "X$TAG" == "X" ];then
    scp $DH:/data/open-c3-installer-*.tar.gz /data/
    TF=`ls /data/open-c3-installer-*.tar.gz|tail -n 1`
else
    TF="/data/open-c3-installer-$TAG.tar.gz"
    scp $DH:$TF $TF
fi

echo $TF

if [ "X$TF" == "X" ];then
    echo nodata /data/open-c3-installer-*.tar.gz
fi

cd /data && tar -zxvf $TF

cd /data/open-c3-installer && ./install $LH
