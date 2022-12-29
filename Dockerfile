FROM nginx:latest
MAINTAINER ifeng <https://t.me/HiaiFeng>
EXPOSE 80
USER root

RUN apt-get update && apt-get install -y supervisor wget unzip

#定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径前无需加/符号，程序已自行添加.)
ENV UUID de04add9-5c68-8bab-950c-08cd5320df18
ENV VMESS_WSPATH vmess
ENV VLESS_WSPATH vless

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir /etc/xray /usr/local/xray
COPY config.json /etc/xray/
COPY entrypoint.sh /usr/local/xray/
RUN chmod a+x /usr/local/xray/entrypoint.sh

RUN wget -q -O /tmp/xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/download/v1.6.1/Xray-linux-64.zip && \
    unzip -d /usr/local/xray /tmp/xray-linux-64.zip

ENTRYPOINT [ "/usr/local/xray/entrypoint.sh" ]
CMD ["/usr/bin/supervisord"]
