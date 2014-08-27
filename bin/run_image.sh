#!/usr/bin/env bash
ipaddr=$(ifconfig eth0 | perl -nle 'print $1 if s/inet addr:(.+?) /$1/g')
mkdir -p /var/log/mysqld
mkdir -p /var/log/httpd
echo docker run -d -t -p $ipaddr:18001:80 -p $ipaddr:19001:443 -v /var/log/mysqld:/var/log/mysqld -v /var/log/httpd:/var/log/httpd docker-reg.cloud.corp.dig.com:5000/bde_devenv bash -c 'supervisord -c /etc/ade_supervisord.conf && tail -f /dev/null'
docker run -d -t -p $ipaddr:18001:80 -p $ipaddr:19001:443 -v /var/log/mysqld:/var/log/mysqld -v /var/log/httpd:/var/log/httpd docker-reg.cloud.corp.dig.com:5000/bde_devenv bash -c 'supervisord -c /etc/ade_supervisord.conf && tail -f /dev/null'
