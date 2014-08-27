#!/usr/bin/env bash

# The Portal already has an install script

# a forked instance can be deployed like so:
#curl -s https://github.disney.com/Portal/portal_application_framework/raw/master/install.sh | bash /dev/stdin -u cloud\-user -g wheel -r git://github.disney.com/ServiceManagement/portal_application_framework.git

# install just the normal portal
#curl -s https://github.disney.com/Portal/portal_application_framework/raw/master/install.sh | bash

# environment
ENV="desktop_osx";
DOMAIN="desktop.framework.corp.disney.com";
REPO="git://github.disney.com/Portal/portal_application_framework.git";
# APACHE_USER is the apache running user
# for DTSS IaaS, this should be cloud\-user
# for DTSS Managed, this should be MGMTPROD\\_dtsssvc_portal
APACHE_USER="apache";
# APACHE_GROUP is the apache running group
# for DTSS IaaS, this should be wheel
# for DTSS Managed, this should be MGMTPROD\\domain^users
APACHE_GROUP="apache";

# Install and configure Zend/PHP, Git and needed extensions
yum install -y -q dos2unix httpd php php-mysql git-core wget
yum install -y -q python python-setuptools.noarch

easy_install supervisor

# for Redis:
# yum install -y -q make gcc;

# Create .ini entry to load the env extension
#echo "extension=env.so" > /usr/local/zend/etc/conf.d/env.ini;
# Make sure user:group ownership and permissions for the new env.ini match other .ini files
#chmod 664 /usr/local/zend/etc/conf.d/env.ini;

# bypass https cert error
git config --global http.sslVerify false;
# remove current html dir (if exists)
rm -rf /var/www/html;

git clone $REPO /var/www/html;

cd /var/www/html;
./deploy.sh -b master -l;

# setup php.ini settings
sed -i 's/post_max_size = 8M/post_max_size = 2000M/' /etc/php.ini;
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 2000M/' /etc/php.ini;
sed -i 's/;date.timezone =/date.timezone = "UTC"/' /etc/php.ini;
sed -i 's/memory_limit = 128M/memory_limit = 512M/' /etc/php.ini;
sed -i 's/expose_php = On/expose_php = Off/' /etc/php.ini;


# esure system time is UTC!
# only required on IaaS default image!
#cp /usr/share/zoneinfo/UTC /etc/localtime;
#sed -i "s/America\/Los_Angeles/UTC/" /etc/sysconfig/clock;
#sed -i "s/America\/NewYork/UTC/" /etc/sysconfig/clock;

# install SSL
yum install -y --quiet mod_ssl;

# change apache to run on 80 and 443:
sed -i 's/Listen 127.0.0.1:8091/Listen 8001/' /etc/httpd/conf/httpd.conf;
# replace default doc root
sed -i 's/"\/var\/www\/html"/"\/var\/www\/html\/public"/' /etc/httpd/conf/httpd.conf;

# add vhost
echo '<VirtualHost *:8001>
    ServerName '$DOMAIN'
    DocumentRoot "/var/www/html/public"

    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}

    SetEnv APPLICATION_ENV '$ENV'

    <Directory "/var/www/html/public">
        AllowOverride All
        Allow from all
    </Directory>
</VirtualHost>' > /etc/httpd/conf.d/portal.conf

# add .htaccess allowance# add .htaccess allowance
# make sure the environment is set in SSL mode
sed -i 's/AllowOverride None/AllowOverride All\nSetEnv APPLICATION_ENV '$ENV'/' /etc/httpd/conf/httpd.conf;

# remove new confs
rm -f /etc/httpd/conf.d/welcome.conf;


# redis
# wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
# rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
# yum install redis -y

# for external access
# nohup redis-server&

# for internal node access
# /etc/init.d/redis start

# only necessary on DOCKER!
# lest mysqld won't start:
# /sbin/service mysqld start
# /etc/init.d/mysqld: line 23: /etc/sysconfig/network: No such file or directory
# https://www.centos.org/forums/viewtopic.php?t=5050
# http://erwyn.piwany.com/docker-io-vagrant-for-lxc/
echo "HOSTNAME=internal.hostname.DOMAIN.com" > /etc/sysconfig/network

# mysql
yum install -y mysql-server mysql-client supervisord;
/etc/init.d/mysqld restart;
cd /var/www/html/db/;
mysql -u root < portal_user.sql;
mysql -u root < portal_schema.sql;
mysql -u root < portal_data.sql;
mysql -u root < portal_test.sql;

# make apache run as the user we want
sed -i 's/User apache/User '$APACHE_USER'/' /etc/httpd/conf/httpd.conf;
sed -i 's/Group apache/Group '$APACHE_GROUP'/' /etc/httpd/conf/httpd.conf;
chown -R $APACHE_USER:$APACHE_GROUP /var/www/html;
