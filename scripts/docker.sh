#!/bin/bash

docker run -i --rm \
  -v /opt/letsencrypt/cert:/etc/letsencrypt \
  -v /opt/web_cert/scripts/docker:/tmp/scripts \
  -e "API_KEY=INSTALL_API_KEY.INSTALL_KEY_SECRET" \
  certbot/certbot \
  certonly \
  --keep-until-expiring \
  --preferred-challenges dns \
  --non-interactive \
  --agree-tos \
  -m INSTALL_EMAIL_VAR \
  --manual \
  --manual-auth-hook /tmp/scripts/authenticate.sh \
  --manual-cleanup-hook /tmp/scripts/cleanup.sh \
  -d *.INSTALL_DOMAIN_VAR


