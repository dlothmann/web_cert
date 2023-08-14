#!/bin/bash

openssl pkcs12 -inkey /opt/letsencrypt/cert/live/INSTALL_DOMAIN_VAR/privkey.pem -in /opt/letsencrypt/cert/live/INSTALL_DOMAIN_VAR/fullchain.pem -export -passout pass:"INSTALL_PFX_PASS" -out /opt/letsencrypt/wildcard.INSTALL_DOMAIN_VAR.pfx

tar -czf /tmp/wildcard.INSTALL_DOMAIN_VAR_Cert_PFX.tar.gz /opt/letsencrypt/wildcard.INSTALL_DOMAIN_VAR.pfx

rm /opt/letsencrypt/wildcard.INSTALL_DOMAIN_VAR.pfx
