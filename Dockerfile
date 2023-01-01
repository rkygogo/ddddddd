FROM nginx:latest
MAINTAINER ifeng <https://t.me/HiaiFeng>
EXPOSE 80
USER root

RUN apt-get update && apt-get install -y supervisor wget unzip

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir /etc/xray /usr/local/xray
COPY config.json /etc/xray/
COPY entrypoint.sh /usr/local/xray/
RUN chmod a+x /usr/local/xray/entrypoint.sh

RUN wget -q -O /tmp/xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/download/v1.7.0/Xray-linux-64.zip && \
    unzip -d /usr/local/xray /tmp/xray-linux-64.zip

ENTRYPOINT [ "/usr/local/xray/entrypoint.sh" ]
CMD ["/usr/bin/supervisord"]
