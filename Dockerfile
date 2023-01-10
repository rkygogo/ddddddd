FROM nginx:latest
LABEL ifeng ygkkk
EXPOSE 80
USER root
RUN apt update && apt install -y supervisor wget unzip iproute2
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir /etc/xray /usr/local/xray
COPY config.json /etc/xray/
COPY entrypoint.sh /usr/local/xray/
RUN chmod a+x /usr/local/xray/entrypoint.sh
ENTRYPOINT [ "/usr/local/xray/entrypoint.sh" ]
CMD ["/usr/bin/supervisord"]
