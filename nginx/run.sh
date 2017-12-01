#!/bin/bash

NGINX_RUN_CONFIG=/etc/nginx/nginx.conf
NGINX_RUN_MAX_BODY=$NGINX_MAX_BODY
NGINX_RUN_DOMAIN=$NGINX_DOMAIN
NGINX_RUN_UPSTREAM=$NGINX_UPSTREAM
NGINX_RUN_CERT_LOC=/etc/letsencrypt/live/$NGINX_RUN_DOMAIN/
NGINX_RUN_CERT_FILE=${NGINX_RUN_CERT_LOC}fullchain.pem
NGINX_RUN_CERT_KEY=${NGINX_RUN_CERT_LOC}privkey.pem

#Show variables to be used
echo Using the following configs
echo CONFIG: $NGINX_RUN_CONFIG
echo MAX BODY: $NGINX_RUN_MAX_BODY
echo DOMAIN: $NGINX_RUN_DOMAIN
echo UPSTREAM: $NGINX_RUN_UPSTREAM
echo CERT_LOCATION: $NGINX_RUN_CERT_LOC
echo CERT_FILE: $NGINX_RUN_CERT_FILE
echo CERT_KEY: $NGINX_RUN_CERT_KEY

#Replace nginx config based on variables
sed -i -e "s/<MAX_BODY>/$NGINX_RUN_MAX_BODY/g" $NGINX_RUN_CONFIG \
       -e "s/<DOMAIN>/$NGINX_RUN_DOMAIN/g" $NGINX_RUN_CONFIG \
       -e "s/<UPSTREAM>/$NGINX_RUN_UPSTREAM/g" $NGINX_RUN_CONFIG

#Check if certificates exist, it not, create a dummy
if [ -f $NGINX_RUN_CERT_FILE ] && [ -f $NGINX_RUN_CERT_KEY ]; then
    echo "Certificate and key found"
else
    echo "Certificate and/or key is misssing. Generating a new pair"
    mkdir -p $NGINX_RUN_CERT_LOC && \
    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=ZZ/ST=Test/L=Test/O=Test/CN=$NGINX_RUN_DOMAIN" \
    -keyout $NGINX_RUN_CERT_KEY -out $NGINX_RUN_CERT_FILE
fi

#Start nginx
nginx -g "daemon off;"
