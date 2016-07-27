FROM phusion/baseimage:latest
MAINTAINER Steven Brezina <steveinatorx@gmail.com>

CMD ["/sbin/my_init"]

RUN echo en_US.UTF-8 > /etc/container_environment/LC_ALL
#RUN chmod -R 777 /etc/container_environment
#RUN chmod -R 777 /etc/container_environment.sh

#source bits
COPY ./commonSources/ /usr/src

#nginx build
RUN apt-get update
RUN apt-get install -y build-essential libpcre3-dev libssl-dev
RUN cd /usr/src/ && tar xzvf nginx-1.9.9.tar.gz && cd /usr/src/nginx-1.9.9 && ./configure --sbin-path=/usr/local/sbin --with-http_realip_module --with-http_ssl_module && make && make install
#keep logs in /var/log
RUN mkdir /var/log/nginx/

#use our custom log to syslog-ng config - rest is default season to your needs
ADD conf/nginx/nginx.conf /usr/local/nginx/conf/nginx.conf

#runit daemon scripts
RUN mkdir -p /etc/sv/nginx
ADD scripts/nginxRun.sh /etc/sv/nginx/run
RUN chmod a+x /etc/sv/nginx/run
RUN ln -s /etc/sv/nginx /etc/service/

#add our custom syslog-ng configs - need to use unix-dgram sockets to get nginx to push to syslog socket
ADD ./conf/syslog-ng/custom.syslog-ng.conf /etc/syslog-ng/conf.d
ADD ./conf/syslog-ng/syslog-ng.conf /etc/syslog-ng/

#cleanup remove gcc + apache
RUN apt-get remove -y apache2 apache2-bin apache2-data apache2-utils build-essential

RUN apt-get autoremove -y && apt-get autoclean -y
CMD ["/sbin/my_init"]
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80 
