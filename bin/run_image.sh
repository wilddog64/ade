#!/usr/bin/env bash
docker run -d -t -p 80:80 docker-reg.cloud.corp.dig.com:5000/bde_devenv supervisord -c /etc/ade_supervisord.conf && tail -f /dev/null
