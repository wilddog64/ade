#!/usr/bin/env bash
yum install -y httpd mysql-server php php-mysql
service mysqld start
service httpd start