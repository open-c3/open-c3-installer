#!/bin/bash

cd /data/open-c3-installer/tools/netctl && ./zone.zh |xargs -i{} ./block.sh {}
