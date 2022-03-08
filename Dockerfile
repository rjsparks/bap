FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y apache2 libcgi-pm-perl gcc make bison flex && \
    a2enmod cgi;

COPY . /code

WORKDIR /code

RUN ./configure && make && cp abnf.cgi bap /usr/lib/cgi-bin && chmod 755 /usr/lib/cgi-bin/abnf.cgi

RUN echo '<head> <meta http-equiv="refresh" content="0; URL=/cgi-bin/abnf.cgi" /> </head>' > /var/www/html/index.html

ENTRYPOINT service apache2 start && /bin/sh
EXPOSE 80
