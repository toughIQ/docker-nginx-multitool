FROM nginx:stable
LABEL maintainer="toughIQ <toughiq@gmail.com>"

RUN apt-get update \
    && apt-get install openssl -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /etc/ssl \
    && openssl dhparam -out RSA2048.pem -5 2048

COPY docker-entrypoint.sh /
COPY templates /etc/nginx/templates

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

ENV CONFIG_TYPE=simple_proxy \
    NGX_BACKEND_SERVER=mybackend \
    NGX_BACKEND_PORT=8080 \
    NGX_BACKEND_PROTO=http \
    NGX_BACKEND_RESOLVE_DNS=8.8.8.8 \
    NGX_BACKEND_RESOLVE_IPV6=off \
    NGX_HTTP_PORT=80 \
    NGX_HTTPS_PORT=443 \
    NGX_REDIRECT_DESTINATION="http\:\/\/someurl" \
