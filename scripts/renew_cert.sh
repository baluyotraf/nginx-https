#!/bin/bash

CERTBOT_RENEW_IS_STAGING=$CERTBOT_TEST

if [ ! ${CERTBOT_RENEW_IS_STAGING} = false ]; then
    CERTBOT_RENEW_STAGING=--force-renewal
fi

#Show variables to be used
echo Using the following configs
echo STAGING: $CERTBOT_RENEW_IS_STAGING
echo STAGING_FLAG: $CERTBOT_RENEW_STAGING

certbot renew \
    --renew-hook "nginx -s reload" \
    $CERTBOT_RENEW_STAGING
