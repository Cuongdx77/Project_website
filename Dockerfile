FROM nginx:latest
COPY ./src /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
EXPOSE 80
