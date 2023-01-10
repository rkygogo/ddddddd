#!/bin/sh
# Create By ifeng ygkkk
apt update && apt install -y supervisor wget unzip iproute2
# wget -O temp.zip https://github.com/XTLS/Xray-core/releases/download/v1.7.0/Xray-linux-64.zip
wget -qO- https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep -o '"https://github.com/XTLS/Xray-core/releases/download/.*/Xray-linux-64.zip"' | xargs wget -O temp.zip
unzip temp.zip
chmod a+x xray
sed -i "s/uuid/$uuid/g" ./config.json
sed -i "s/uuid/$uuid/g" /etc/nginx/nginx.conf
[ -n "${www}" ] && rm -rf /usr/share/nginx/* && wget -c -P /usr/share/nginx "https://github.com/rkygogo/ddddddd/raw/main/3w/html${www}.zip" && unzip -o "/usr/share/nginx/html${www}.zip" -d /usr/share/nginx/html
xpid=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv xray $xpid
cat config.json | base64 > config
rm -f config.json
nginx
base64 -d config > config.json; ./$xpid -config=config.json
