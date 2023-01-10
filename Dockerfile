FROM nginx:latest
LABEL ifeng ygkkk
EXPOSE 80
WORKDIR /app
USER root
RUN apt update && apt install -y supervisor wget unzip iproute2
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json ./
COPY entrypoint.sh ./
# RUN mkdir /etc/xray /usr/local/xray
# COPY config.json /etc/xray/
# COPY entrypoint.sh /usr/local/xray/
RUN chmod a+x ./entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
# CMD ["/usr/bin/supervisord"]
