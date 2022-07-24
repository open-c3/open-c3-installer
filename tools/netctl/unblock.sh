#! /bin/bash

GEOIP=$1

if [ "X$GEOIP" == "X" ];then
    echo no GEOIP
    exit 1
fi

lookuplist=`ipset list | grep "Name:" | grep "$GEOIP"`

if [ -n "$lookuplist" ]; then
    iptables -D INPUT -p tcp -m set --match-set "$GEOIP" src -j DROP
    iptables -D INPUT -p udp -m set --match-set "$GEOIP" src -j DROP
    ipset destroy $GEOIP
    echo -e "所指定国家($GEOIP)的ip解封成功，并删除其对应的规则!"
else
    echo -e "$解封失败，请确认你所输入的国家是否在封禁列表内!"
    exit 1
fi

