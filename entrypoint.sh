#!/bin/sh
# Create By ifeng
# Web Site:https://www.hicairo.com
# Telegram:https://t.me/HiaiFeng

sed -i "s/uuid/$uuid/g" /etc/xray/config.json
sed -i "s/uuid/$uuid/g" /etc/nginx/nginx.conf
exec "$@"
