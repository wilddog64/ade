#!/usr/bin/env bash
ipaddr=$(ifconfig eth0 | perl -nle 'print $1 if s/inet addr:(.+?) /$1/g')
echo docker run -d -t -p $ipaddr:8001:8001 docker-reg.cloud.corp.dig.com:5000/bde_devenv bash -c 'supervisord -c /etc/ade_supervisord.conf && tail -f /dev/null'
docker run -d -t -p $ipaddr:8001:8001 docker-reg.cloud.corp.dig.com:5000/bde_devenv bash -c 'supervisord -c /etc/ade_supervisord.conf && tail -f /dev/null'
