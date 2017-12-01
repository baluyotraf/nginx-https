FROM library/nginx:1.13.5

RUN apt-get update \
 && apt-get install -y \
    openssl \
    certbot \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV NGINX_DOMAIN=www.test.com \
    NGINX_MAX_BODY=1G \
    NGINX_UPSTREAM=localhost \
    CERTBOT_TEST=true \
    CERTBOT_EMAIL=test@test.com

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/run.sh /usr/local/bin/run.sh
COPY nginx/get_cert.sh /usr/local/bin/get_cert.sh

CMD ["run.sh"]

