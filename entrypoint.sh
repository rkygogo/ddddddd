#!/bin/sh
# Create By ifeng ygkkk
# wget -q -O /tmp/xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/download/v1.7.0/Xray-linux-64.zip

wget -qO- temp.zip https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep -o '"https://github.com/XTLS/Xray-core/releases/download/.*/Xray-linux-64.zip"' | xargs wget -qO /tmp/Xray-linux-64.zip
unzip temp.zip xray geoip.dat geosite.dat
chmod -v 755 xray
sed -i "s/uuid/$uuid/g" ./config.json
sed -i "s/uuid/$uuid/g" /etc/nginx/nginx.conf
sed -i "s#RELEASE_RANDOMNESS#${RELEASE_RANDOMNESS}#g" /etc/supervisor/conf.d/supervisord.conf
[ -n "${www}" ] && rm -rf /usr/share/nginx/* && wget -c -P /usr/share/nginx "https://github.com/rkygogo/ddddddd/raw/main/3w/html${www}.zip" && unzip -o "/usr/share/nginx/html${www}.zip" -d /usr/share/nginx/html
RELEASE_RANDOMNESS=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv xray ${RELEASE_RANDOMNESS}
cat config.json | base64 > config
rm -f config.json
nginx
base64 -d config > config.json; ./${RELEASE_RANDOMNESS} -config=config.json
