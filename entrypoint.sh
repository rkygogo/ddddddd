#!/bin/sh
# Create By ifeng
# Web Site:https://www.hicairo.com
# Telegram:https://t.me/HiaiFeng

sed -i "s/uuid/$uuid/g" /etc/xray/config.json
sed -i "s/uuid/$uuid/g" /etc/nginx/nginx.conf
rm -rf /usr/share/nginx/*
www=${www:-'1'}
wget -c -P /usr/share/nginx "https://github.com/rkygogo/ddddddd/raw/main/3w/html${www}.zip" 
unzip -o "/usr/share/nginx/html${www}.zip" -d /usr/share/nginx/html
exec "$@"
