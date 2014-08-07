#!/usr/bin/env bash

# make sure you can write to apache conf directory
sudo chown -R $(whoami) /etc/apache2
# if you don't already have a locally signed ssl cert, create one:
mkdir -p /etc/apache2/ssl;
cd /etc/apache2/ssl;
# create a key (with no password)
ssh-keygen -f server.key;
# just hit enter through all these options
openssl req -new -key server.key -out request.csr;
openssl x509 -req -days 365 -in request.csr -signkey server.key -out server.crt;
