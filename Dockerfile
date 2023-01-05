FROM nginx:latest
LABEL ifeng ygkkk
EXPOSE 80
USER root
RUN apt-get update && apt-get install -y supervisor wget unzip
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir /etc/xray /usr/local/xray
COPY config.json /etc/xray/
COPY entrypoint.sh /usr/local/xray/
#wget -q -O /tmp/xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/download/v1.7.0/Xray-linux-64.zip
RUN wget -qO- https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep -o '"https://github.com/XTLS/Xray-core/releases/download/.*/Xray-linux-64.zip"' | xargs wget -qO /tmp/Xray-linux-64.zip \
&& unzip -d /usr/local/xray /tmp/Xray-linux-64.zip \
&& chmod a+x /usr/local/xray/entrypoint.sh 
RUN rm -rf /usr/share/nginx/*
RUN wget -qO- /tmp/master.zip https://github.com/AYJCSGM/mikutap/archive/master.zip >/dev/null \
&& unzip -o "/tmp/master" -d /usr/share/nginx/html >/dev/null

ENTRYPOINT [ "/usr/local/xray/entrypoint.sh" ]
CMD ["/usr/bin/supervisord"]
