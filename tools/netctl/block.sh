#! /bin/bash

GEOIP=$1

if [ "X$GEOIP" == "X" ];then
    echo no GEOIP
    exit 1
fi

if [ ! -f "/data/open-c3-installer/tools/netctl/data/zone/$GEOIP.zone" ]; then
    echo "获取 $GEOIP.zone 数据失败"
    exit 1
fi

ipset -N $GEOIP hash:net

for i in $(cat /data/open-c3-installer/tools/netctl/data/zone/$GEOIP.zone ); do ipset -A $GEOIP $i; done
iptables -I INPUT -p tcp -m set --match-set "$GEOIP" src -j DROP
iptables -I INPUT -p udp -m set --match-set "$GEOIP" src -j DROP
echo -e "所指定国家($GEOIP)的ip封禁成功!"
