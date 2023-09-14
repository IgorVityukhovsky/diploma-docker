FROM docker.io/nginx:latest
EXPOSE 8099
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN sed -i 's/listen 80;/listen 8099;/g' /etc/nginx/conf.d/default.conf
LABEL version="1.0"
COPY . /usr/share/nginx/html



