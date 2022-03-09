FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y apache2 libcgi-pm-perl gcc make bison flex && \
    a2enmod cgi;

COPY . /code

WORKDIR /code

RUN ./configure && make && cp abnf.cgi bap /usr/lib/cgi-bin && chmod 755 /usr/lib/cgi-bin/abnf.cgi

RUN echo '<head> <meta http-equiv="refresh" content="0; URL=/cgi-bin/abnf.cgi" /> </head>' > /var/www/html/index.html

RUN echo 'ServerName 127.0.0.1' >> /etc/apache2/apache2.conf

RUN echo 'Listen 8080' > /etc/apache2/ports.conf

EXPOSE 8080

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
