#!/bin/bash
cd /data/open-c3-installer/dockerimage || exit 1
ls | xargs -n 1 | awk '{print "docker load -i " $1 }' | bash -x
