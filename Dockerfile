# Используем официальный образ nginx
FROM nginx:latest

# Копируем содержимое сайта в контейнер
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY . /usr/share/nginx/html


# Указываем nginx слушать порт 8099
EXPOSE 8099

# Изменяем конфигурацию nginx, чтобы он слушал порт 8099
#RUN sed -i 's/listen 80;/listen 8099;/g' /etc/nginx/conf.d/default.conf
