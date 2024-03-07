FROM nginx:alpine

COPY index.html tetris.js /usr/share/nginx/html/


EXPOSE 80
