FROM mcr.microsoft.com/mssql/server:2022-latest
WORKDIR /app
ENV SA_PASSWORD=Un!q@to2023 \
    ACCEPT_EULA=Y 
EXPOSE 1433 
COPY . /app                            
CMD ./opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -d master -i salihapp              
                             