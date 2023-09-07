FROM nginx:latest
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY . /usr/share/nginx/html
EXPOSE 8099
RUN sed -i 's/listen 80;/listen 8099;/g' /etc/nginx/conf.d/default.conf
