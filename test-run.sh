
#!/bin/bash

cd /data || exit 1
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -d 192.168.10.0/24 -j ACCEPT
iptables -A OUTPUT -j DROP

docker ps   |awk '{print $1}'|grep -v CONTAINER|xargs -i{} docker stop {}
docker ps -a|awk '{print $1}'|grep -v CONTAINER|xargs -i{} docker rm {}

docker images|awk '{print $3}'|grep -v IMAGE|xargs -i{} docker rmi {}

rm -rf /data/open-c3
rm -rf /data/open-c3-data
rm -rf /data/open-c3-installer-2*

tar -zxf open-c3-installer.tar.gz

ls open-c3-installer-2*/install|tail -n 1|xargs -i{} bash {}
