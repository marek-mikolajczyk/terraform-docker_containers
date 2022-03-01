FROM alpine:latest                               
RUN apk add --no-cache apache2                   
COPY ./public-html/ /var/www/localhost/htdocs/   
EXPOSE 80                                        
CMD ["-D","FOREGROUND"]                          
ENTRYPOINT ["/usr/sbin/httpd"]                   
