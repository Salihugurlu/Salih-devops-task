FROM nginx
RUN apt-get update && apt-get install -y php7.1
COPY ./quickdbtest.php /usr/share/nginx/html/
EXPOSE 80     
CMD ["nginx", "-g", "daemon off;"]




                             