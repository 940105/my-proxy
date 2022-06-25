FROM nginx:stable

ARG CERTBOT_EMAIL=info@domain.com
ARG DOMAIN

RUN apt-get update \
      && apt-get install -y cron certbot python-certbot-nginx bash wget
RUN certbot certonly --standalone --agree-tos -m "${CERTBOT_EMAIL}" -n -d ${DOMAIN_LIST}

COPY entrypoint.sh /usr/bin/local
COPY certbot-renew /etc/cron.d/
RUN crontab /etc/cron.d/certbot-renew

ENTRYPOINT [ "entrypoint.sh" ]
