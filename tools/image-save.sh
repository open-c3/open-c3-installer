#!/bin/bash

rm -rf   /data/open-c3-installer/dockerimage
mkdir -p /data/open-c3-installer/dockerimage

cd /data/open-c3-installer/dockerimage || exit 1

cat ../open-c3/Installer/C3/JOB/dockerfile        | grep FROM  |               awk       '{print $2}' | awk '{print "docker save -o " $1 " " $1}'|sed 's/\//_/'| bash -x
cat /data/open-c3/Installer/C3/docker-compose.yml | grep image | grep -v "^#"| awk -F'"' '{print $2}' | awk '{print "docker save -o " $1 " " $1}'|sed 's/\//_/'| bash -x
