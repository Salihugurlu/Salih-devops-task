FROM nginx
RUN apt-get update && apt-get install -y php7.1
COPY ./QuickDBTest.php /usr/share/nginx/html/
# WORKDIR /app
# ENV SA_PASSWORD=Un!q@to2023 \
#     ACCEPT_EULA=Y 
EXPOSE 80
# COPY . .                           
#  CMD [/opt/mssql/bin/sqlservr, salihapp]       
CMD ["nginx", "-g", "daemon off;"]



# # Docker resmi MSSQL Server görüntüsünü temel alın
# FROM mcr.microsoft.com/mssql/server:2019-latest

# # Ortam değişkenlerini ayarla
# ENV ACCEPT_EULA=Y
# ENV SA_PASSWORD=YourStrongPassword

# # MSSQL Server örneğini başlatmak için gereken komutu belirt
# CMD ["/opt/mssql/bin/sqlservr"]
                             