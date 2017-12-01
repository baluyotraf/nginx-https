FROM library/nginx:1.13.5

RUN apt-get update \
 && apt-get install -y \
    openssl \
    certbot=0.10.2-1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV NGINX_DOMAIN=www.test.com \
    NGINX_MAX_BODY=1G \
    NGINX_UPSTREAM=localhost \
    CERTBOT_TEST=true \
    CERTBOT_EMAIL=test@test.com

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY scripts/ /usr/local/bin/

CMD ["run.sh"]

