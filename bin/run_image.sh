#!/usr/bin/env bash
# echo out what we run
ipaddr=$(ifconfig eth0 | perl -nle 'print $1 if s/inet addr:(.+?) /$1/g')
mkdir -p /var/log/node
set -x;docker run -d -t -p $ipaddr:18001:80 -p $ipaddr:19001:443 -v /tmp/vagrant/ade/log:/var/log -v /tmp/vagrant/ade/src:/var/www docker-reg.cloud.corp.dig.com:5000/bde_devenv bash -c 'supervisord -c /etc/ade_supervisord.conf && tail -f /dev/null'
echo "if you need to debug the node setup, run:"
echo "docker run -i -t -v /tmp/vagrant/ade/log:/var/log -v /tmp/vagrant/ade/src:/var/www docker-reg.cloud.corp.dig.com:5000/bde_devenv /bin/bash"