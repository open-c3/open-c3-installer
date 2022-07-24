#!/bin/bash

cd /data/open-c3-installer/tools/netctl && ./list.sh | grep DROP | grep tcp | grep match-set | awk '{print $7}' | xargs -i{} ./unblock.sh {}
